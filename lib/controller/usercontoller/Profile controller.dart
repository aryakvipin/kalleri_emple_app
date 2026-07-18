import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

/// Controller for the Profile screen.
///
/// Fetches:
///  - user's basic details from `users/{uid}` (name, photoUrl, tagline)
///  - total pooja booking count from `booking` collection (userId match)
///  - total donation amount from `donations` collection (uid match, sum of amount)
///
/// SCHEMA (matches actual Firestore structure):
///  users/{uid}:
///     - name        (String)
///     - photoUrl    (String, optional)
///     - devoteeType (String)  e.g. "Thiruvathira" shown under the name
///     - tagline     (String, optional) e.g. "May Lord Kuttichathan bless your path."
///  booking/{bookingId}:  -- pooja bookings only, no "type" field needed
///     - userId      (String)  -> uid of the devotee who booked
///     - poojaId, poojaName, totalAmount, pricePerDevotee, devoteeCount,
///       devoteeTotalCount, status, userEmail, nakshatram, paymentMethod, specialRequest
///  donations/{donationId}:  -- separate collection from booking
///     - uid         (String)  -> uid of the devotee who donated
///     - amount      (num)
///     - category, devoteeName, nakshatram, nakshatramMalayalam, status, userName, createdAt
class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Observable state
  final RxBool isLoading = true.obs;
  final RxString name = ''.obs;
  final RxString devoteeType = ''.obs;
  final RxString tagline = ''.obs;
  final RxString photoUrl = ''.obs;
  final RxInt poojaCount = 0.obs;
  final RxDouble donationTotal = 0.0.obs;
  final RxString errorMessage = ''.obs;

  String? get _uid => _auth.currentUser?.uid;

  @override
  void onInit() {
    super.onInit();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final uid = _uid;
    if (uid == null) {
      errorMessage.value = 'No signed-in user found.';
      isLoading.value = false;
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      await Future.wait([
        _fetchUserDetails(uid),
        _fetchPoojaCount(uid),
        _fetchDonationTotal(uid),
      ]);
    } catch (e) {
      errorMessage.value = 'Failed to load profile: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _fetchUserDetails(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    if (doc.exists) {
      final data = doc.data() ?? {};
      name.value = (data['name'] ?? 'Devotee').toString();
      devoteeType.value = (data['devoteeType'] ?? '').toString();
      tagline.value = (data['tagline'] ??
          'May Lord Kuttichathan bless your path.')
          .toString();
      photoUrl.value = (data['photoUrl'] ?? '').toString();
    } else {
      name.value = 'Devotee';
    }
  }

  /// Counts pooja bookings for this user.
  /// `booking` collection holds only pooja bookings, matched by `userId`.
  /// This is a single-field equality filter, so no composite index is needed.
  Future<void> _fetchPoojaCount(String uid) async {
    final query = _firestore.collection('booking').where('userId', isEqualTo: uid);

    final countSnapshot = await query.count().get();
    poojaCount.value = countSnapshot.count ?? 0;
  }

  /// Sums donation amounts for this user from the separate `donations` collection.
  /// Field is `uid` (not `userId`) here. Single-field filter, no composite index needed.
  Future<void> _fetchDonationTotal(String uid) async {
    final query = _firestore.collection('donations').where('uid', isEqualTo: uid);

    final sumSnapshot = await query.aggregate(sum('amount')).get();
    donationTotal.value = (sumSnapshot.getSum('amount') ?? 0).toDouble();
  }

  /// Formats donation total like the design's "₹15.2k" style.
  String get formattedDonations {
    final value = donationTotal.value;
    if (value >= 100000) {
      return '₹${(value / 100000).toStringAsFixed(1)}L';
    } else if (value >= 1000) {
      return '₹${(value / 1000).toStringAsFixed(1)}k';
    }
    return '₹${value.toStringAsFixed(0)}';
  }

  Future<void> logout() async {
    await _auth.signOut();
    Get.offAllNamed('/login'); // adjust to your actual login route name
  }

  Future<void> refresh() => loadProfile();
}