import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalleri_emple_app/screen/admin/widgets/bottom_nav.dart';

import '../../Model/adminmodel/adminmodel.dart';
import '../../utils/AppBackground.dart';
import 'add_pooja_screen.dart';
import 'booking_detail_screen.dart';

import 'dashboard_screen.dart';
import 'gallery_screen.dart';
import 'profile_screen.dart';

class BookingsScreen extends StatefulWidget {
  /// When embedded inside the bottom-nav shell, hides its own back arrow
  /// and its own bottom nav bar.
  final bool embedded;
  const BookingsScreen({super.key, this.embedded = false});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

/// Bundles a Booking with the booker's user info (from the `userId` /
/// `userEmail` fields the devotee-facing flow writes), without needing to
/// modify the shared Booking model itself.
class _BookingWithUser {
  final Booking booking;
  final String? userId;
  final String? userEmail;

  const _BookingWithUser({
    required this.booking,
    required this.userId,
    required this.userEmail,
  });
}

class _BookingsScreenState extends State<BookingsScreen> {
  final _filters = const ['All', 'Today', 'Upcoming', 'Past'];
  int _selected = 0;

  // This screen represents index 2 (Booking) in the bottom nav.
  static const int _navIndex = 2;

  final CollectionReference _bookingCollection =
  FirebaseFirestore.instance.collection('booking');

  /// Parses a Firestore booking document (written by the devotee-facing
  /// booking flow) into a Booking model this screen already knows how to
  /// display, plus the booker's user info.
  _BookingWithUser _bookingFromDoc(QueryDocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    final poojaName = (data['poojaName'] as String?) ?? 'Pooja';

    final bookingDateTs = data['bookingDate'] as Timestamp?;
    final baseDate = bookingDateTs?.toDate() ?? DateTime.now();

    // bookingTime is stored as e.g. "04:00 PM" — combine it with the
    // booking date so we get one full DateTime for display/sorting.
    final timeStr = (data['bookingTime'] as String?) ?? '';
    final dateTime = _combineDateAndTime(baseDate, timeStr);

    // Prefer the total headcount (main devotee + additional members) if
    // present; fall back to devoteeCount, then 0.
    final devotees = (data['devoteeTotalCount'] as int?) ??
        (data['devoteeCount'] as int?) ??
        0;

    final statusStr = (data['status'] as String?) ?? 'pending';
    final status = statusStr == 'confirmed'
        ? BookingStatus.confirmed
        : BookingStatus.pending;

    final booking = Booking(
      id: doc.id,
      poojaName: poojaName,
      dateTime: dateTime,
      devotees: devotees,
      status: status, imageUrl: '',
    );

    return _BookingWithUser(
      booking: booking,
      userId: data['userId'] as String?,
      userEmail: data['userEmail'] as String?,
    );
  }

  DateTime _combineDateAndTime(DateTime date, String timeStr) {
    final match = RegExp(r'^(\d{1,2}):(\d{2})\s*(AM|PM)$', caseSensitive: false)
        .firstMatch(timeStr.trim());

    if (match == null) {
      return DateTime(date.year, date.month, date.day);
    }

    int hour = int.parse(match.group(1)!);
    final minute = int.parse(match.group(2)!);
    final period = match.group(3)!.toUpperCase();

    if (period == 'PM' && hour != 12) hour += 12;
    if (period == 'AM' && hour == 12) hour = 0;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<_BookingWithUser> _applyFilter(List<_BookingWithUser> bookings) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (_filters[_selected]) {
      case 'Today':
        return bookings
            .where((b) => _isSameDate(b.booking.dateTime, today))
            .toList();
      case 'Upcoming':
        return bookings
            .where((b) =>
        b.booking.dateTime.isAfter(today) &&
            !_isSameDate(b.booking.dateTime, today))
            .toList();
      case 'Past':
        return bookings
            .where((b) =>
        b.booking.dateTime.isBefore(today) &&
            !_isSameDate(b.booking.dateTime, today))
            .toList();
      case 'All':
      default:
        return bookings;
    }
  }

  Future<void> _toggleStatus(String docId, BookingStatus current) async {
    final newStatus =
    current == BookingStatus.confirmed ? 'pending' : 'confirmed';

    await _bookingCollection.doc(docId).set(
      {'status': newStatus},
      SetOptions(merge: true),
    );
  }

  /// Shared bottom-nav routing: Home pops back to the first route; every
  /// other tab swaps to its peer screen via pushReplacement.
  void _onNavTap(int index) {
    if (index == _navIndex) return;

    if (index == 0) {
      Navigator.of(context).popUntil((route) => route.isFirst);
      return;
    }

    Widget target;
    switch (index) {
      case 1:
        target = const AddPoojaScreen(embedded: false);
        break;
      case 3:
        target = const AdminGalleryPage(embedded: false);
        break;
      case 4:
        target = const AdminProfileScreen(embedded: false);
        break;
      default:
        return;
    }

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => target),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        automaticallyImplyLeading: !widget.embedded,
        leading: widget.embedded
            ? null
            : IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Bookings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_customize_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              children: List.generate(_filters.length, (i) {
                final selected = i == _selected;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: GestureDetector(
                    onTap: () => setState(() => _selected = i),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 9),
                      decoration: BoxDecoration(
                        color: selected ? AppColors.maroon : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: selected
                              ? AppColors.maroon
                              : Colors.grey.shade300,
                        ),
                      ),
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          color: selected ? Colors.white : AppColors.textGrey,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _bookingCollection
                  .orderBy('bookingDate', descending: false)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      "Could not load bookings.",
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                  );
                }

                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allBookings =
                snapshot.data!.docs.map(_bookingFromDoc).toList();
                final bookings = _applyFilter(allBookings);

                if (bookings.isEmpty) {
                  return Center(
                    child: Text(
                      "No bookings in this filter yet.",
                      style: TextStyle(color: AppColors.textGrey),
                    ),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                  itemCount: bookings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final b = bookings[index];
                    return _BookingCard(
                      booking: b.booking,
                      userEmail: b.userEmail,
                      userId: b.userId,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) =>
                                BookingDetailScreen(booking: b.booking),
                          ),
                        );
                      },
                      onToggleStatus: () =>
                          _toggleStatus(b.booking.id, b.booking.status),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: widget.embedded
          ? null
          : AdminBottomNavBar(
        selectedIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }
}

/// Shortens a raw Firebase Auth UID for display (e.g. as a fallback when
/// a booking has no userEmail saved) — first 8 chars + ellipsis.
String _shortUserId(String userId) {
  if (userId.length <= 8) return userId;
  return '${userId.substring(0, 8)}…';
}

class _BookingCard extends StatelessWidget {
  final Booking booking;
  final String? userId;
  final String? userEmail;
  final VoidCallback onTap;
  final VoidCallback onToggleStatus;

  const _BookingCard({
    required this.booking,
    required this.userId,
    required this.userEmail,
    required this.onTap,
    required this.onToggleStatus,
  });

  @override
  Widget build(BuildContext context) {
    final confirmed = booking.status == BookingStatus.confirmed;
    final date = booking.dateTime;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final dateStr =
        '${date.day} ${months[date.month - 1]} ${date.year}, ${hour12.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.id,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade500,
                  ),
                ),
                // Tap to toggle Pending <-> Confirmed for this booking.
                GestureDetector(
                  onTap: onToggleStatus,
                  child: const Icon(Icons.more_vert, size: 18, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 52,
                    height: 52,
                    color: AppColors.maroon.withOpacity(0.1),
                    child: const Icon(Icons.local_fire_department_rounded,
                        color: AppColors.maroon),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        booking.poojaName,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        dateStr,
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textGrey),
                      ),
                      if ((userEmail != null && userEmail!.isNotEmpty) ||
                          (userId != null && userId!.isNotEmpty)) ...[
                        const SizedBox(height: 3),
                        Text(
                          "Booked by: ${userEmail ?? _shortUserId(userId!)}",
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textGrey.withOpacity(0.8),
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${booking.devotees}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                        color: AppColors.textDark,
                      ),
                    ),
                    Text(
                      'DEVOTEES',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.4,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: onToggleStatus,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: confirmed
                          ? AppColors.confirmedGreenBg
                          : AppColors.pendingOrangeBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      confirmed ? 'Confirmed' : 'Pending',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: confirmed
                            ? AppColors.confirmedGreen
                            : AppColors.pendingOrange,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}