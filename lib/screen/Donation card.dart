import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Model representing a single donation entry, backed by a Firestore doc.
///
/// Expected Firestore document shape (collection: "donations"):
/// {
///   "userId": "abc123",              // optional, used to scope the query
///   "title": "Annadanam",
///   "icon": "restaurant",            // one of the keys in _iconMap below
///   "dateTime": "25 Jun 2025, Saturday\n10:00 AM - 6:00 PM",
///   "amount": 501,                   // number, formatted as ₹ in the UI
///   "status": "CONFIRMED",
///   "createdAt": Timestamp
/// }
class Donation {
  final String id;
  final String title;
  final IconData icon;
  final String dateTime;
  final num amount;
  final String status;

  const Donation({
    required this.id,
    required this.title,
    required this.icon,
    required this.dateTime,
    required this.amount,
    required this.status,
  });

  static const Map<String, IconData> _iconMap = {
    'restaurant': Icons.restaurant,
    'foundation': Icons.foundation,
    'temple': Icons.temple_hindu,
    'favorite': Icons.favorite,
    'volunteer': Icons.volunteer_activism,
  };

  factory Donation.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};
    return Donation(
      id: doc.id,
      title: (data['title'] as String?) ?? 'Donation',
      icon: _iconMap[data['icon'] as String?] ?? Icons.favorite,
      dateTime: (data['dateTime'] as String?) ?? '',
      amount: (data['amount'] as num?) ?? 0,
      status: (data['status'] as String?) ?? 'PENDING',
    );
  }

  String get formattedAmount => '₹${amount.toStringAsFixed(0)}';
}

class DonationsdetailsPage extends StatelessWidget {
  /// Pass the signed-in user's id to scope donations to that user.
  /// Leave null to show all donations in the collection.
  final String? userId;

  const DonationsdetailsPage({super.key, this.userId});

  static const Color primaryMaroon = Color(0xFF6E1423);
  static const Color confirmedColor = Color(0xFFF2A93B);

  Query<Map<String, dynamic>> get _donationsQuery {
    Query<Map<String, dynamic>> query = FirebaseFirestore.instance
        .collection('donations')
        .orderBy('createdAt', descending: true);
    if (userId != null) {
      query = query.where('userId', isEqualTo: userId);
    }
    return query;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F5F2),
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: _donationsQuery.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Something went wrong: ${snapshot.error}'),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Center(child: Text('No donations yet.'));
                }
                final donations =
                docs.map((d) => Donation.fromFirestore(d)).toList();
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: donations.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _DonationCard(donation: donations[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 12,
        bottom: 20,
        left: 16,
        right: 16,
      ),
      decoration: const BoxDecoration(
        color: primaryMaroon,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.of(context).maybePop(),
            borderRadius: BorderRadius.circular(20),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(Icons.arrow_back, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Donations',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'All your contributions in one place',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _DonationCard extends StatelessWidget {
  final Donation donation;

  const _DonationCard({required this.donation});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: DonationsdetailsPage.primaryMaroon.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              donation.icon,
              color: DonationsdetailsPage.primaryMaroon,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  donation.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                if (donation.dateTime.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    donation.dateTime,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ],
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: DonationsdetailsPage.confirmedColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    donation.status,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFB5790F),
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Text(
            donation.formattedAmount,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}