import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/AppBackground.dart';

class BookingSuccessScreen extends StatelessWidget {
  final String donationId;
  final String categoryLabel;
  final IconData categoryIcon;
  final String amount;
  final String date;
  final String timeSlot;

  const BookingSuccessScreen({
    super.key,
    required this.donationId,
    required this.categoryLabel,
    required this.categoryIcon,
    required this.amount,
    required this.date,
    required this.timeSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 24),
              _buildSuccessIcon(),
              const SizedBox(height: 20),
              const Text(
                'Booking confirm!',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Booking confirm has been successfully booked',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textGrey,
                ),
              ),
              const SizedBox(height: 24),
              _buildDonationIdCard(context),
              const SizedBox(height: 16),
              _buildDonationDetailCard(),
              const SizedBox(height: 16),
              _buildBlessingCard(),
              const Spacer(),
              _buildBottomButtons(context),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Container(
      width: 84,
      height: 84,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.green, width: 3),
      ),
      child: const Icon(Icons.check, color: Colors.green, size: 44),
    );
  }

  Widget _buildDonationIdCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.maroon,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          Text(
            'Booking Confirmed!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.75),
              fontSize: 11,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                donationId,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () {
                  Clipboard.setData(ClipboardData(text: donationId));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Booking Confirmed! ID copied'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                child: const Icon(
                  Icons.copy_rounded,
                  color: Colors.white70,
                  size: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDonationDetailCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.lightPink,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(categoryIcon, color: AppColors.maroon, size: 26),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  categoryLabel,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 12, color: AppColors.textGrey),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 12, color: AppColors.textGrey),
                    const SizedBox(width: 6),
                    Text(
                      timeSlot,
                      style: const TextStyle(fontSize: 12, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBlessingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.lightPink,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Icon(Icons.self_improvement, color: AppColors.maroon, size: 20),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              'May Kuttichathan Swami bless you and your familyFF with '
                  'peace, prosperity and happiness.',
              style: TextStyle(
                fontSize: 12.5,
                color: AppColors.textDark,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: AppColors.maroon),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // TODO: navigate to donations list/history screen.
              },
              child: const Text(
                'View Donations',
                style: TextStyle(
                  color: AppColors.maroon,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: SizedBox(
            height: 50,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.maroon,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}