import 'package:flutter/material.dart';
import '../../Model/adminmodel/adminmodel.dart';
import '../../utils/AppBackground.dart';


class BookingDetailScreen extends StatelessWidget {
  final Booking booking;
  const BookingDetailScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    final confirmed = booking.status == BookingStatus.confirmed;
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    final date = booking.dateTime;
    final hour12 = date.hour % 12 == 0 ? 12 : date.hour % 12;
    final dateStr =
        '${date.day} ${months[date.month - 1]} ${date.year}, ${hour12.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}';

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('Bookings'),
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_customize_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.id,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: AppColors.maroon,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 6),
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
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 22,
                        backgroundColor: AppColors.maroon,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            booking.bookedBy.isEmpty
                                ? '—'
                                : booking.bookedBy,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textGrey),
                          ),
                          Text(
                            booking.poojaName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.maroon,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Divider(height: 32),
                  _DetailRow(label: 'Date & Time', value: dateStr),
                  _DetailRow(
                      label: 'Devotees', value: '${booking.devotees}'),
                  _DetailRow(
                      label: 'Booking By',
                      value: booking.bookedBy.isEmpty
                          ? '—'
                          : booking.bookedBy),
                  _DetailRow(
                      label: 'Phone',
                      value: booking.phone.isEmpty ? '—' : booking.phone),
                  _DetailRow(
                      label: 'Amount',
                      value: booking.amount == 0
                          ? '—'
                          : '₹${booking.amount.toStringAsFixed(0)}'),
                  _DetailRow(
                      label: 'Payment',
                      value:
                          booking.paymentMode.isEmpty ? '—' : booking.paymentMode),
                  _DetailRow(
                      label: 'Transaction ID',
                      value: booking.transactionId.isEmpty
                          ? '—'
                          : booking.transactionId),
                  _DetailRow(
                      label: 'Special Request', value: booking.specialRequest),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.print_outlined,
                        color: AppColors.maroon),
                    label: const Text('Print',
                        style: TextStyle(color: AppColors.maroon)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(color: AppColors.maroon),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined,
                        color: AppColors.maroon),
                    label: const Text('Share',
                        style: TextStyle(color: AppColors.maroon)),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(color: AppColors.maroon),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            ElevatedButton(
              onPressed: () {},
              child: const Text('View Devotees'),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
          Text(
            value,
            style: const TextStyle(
                fontWeight: FontWeight.w600, fontSize: 13.5),
          ),
        ],
      ),
    );
  }
}
