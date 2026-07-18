import 'package:flutter/material.dart';
import '../Model/usermodel/profilrModels.dart';
import '../main.dart';
import '../utils/AppBackground.dart';
import 'Status badge.dart';

class BookingCard extends StatelessWidget {
  final BookingItem item;
  final bool showChevron;

  const BookingCard({super.key, required this.item, this.showChevron = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withOpacity(0.05)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),
                    if (item.price != null)
                      Text(
                        item.price!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: AppColors.maroon,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.calendar_today,
                        size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(item.date,
                        style: const TextStyle(
                            fontSize: 11.5, color: AppColors.textMuted)),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    const Icon(Icons.access_time,
                        size: 12, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(item.time,
                        style: const TextStyle(
                            fontSize: 11.5, color: AppColors.textMuted)),
                  ],
                ),
                const SizedBox(height: 8),
                StatusBadge(status: item.status),
              ],
            ),
          ),
          if (showChevron)
            const Icon(Icons.chevron_right, color: AppColors.textMuted),
        ],
      ),
    );
  }
}