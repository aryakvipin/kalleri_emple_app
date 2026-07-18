import 'package:flutter/material.dart';
import '../../Model/adminmodel/adminmodel.dart';
import '../../utils/AppBackground.dart';


class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  IconData _iconFor(NotificationType type) {
    switch (type) {
      case NotificationType.booking:
        return Icons.event_available_rounded;
      case NotificationType.donation:
        return Icons.volunteer_activism_rounded;
      case NotificationType.event:
        return Icons.calendar_month_rounded;
      case NotificationType.pooja:
        return Icons.temple_hindu_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final notifications = MockData.notifications;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(title: const Text('Notifications')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(20),
              itemCount: notifications.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final n = notifications[index];
                return Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.creamCard,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(_iconFor(n.type),
                            color: AppColors.gold, size: 20),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  n.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14),
                                ),
                                Text(
                                  n.timeAgo,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: AppColors.textGrey),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              n.message,
                              style: TextStyle(
                                  fontSize: 12.5,
                                  color: AppColors.textGrey,
                                  height: 1.3),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.done_all_rounded, size: 18),
              label: const Text('MARK ALL AS READ'),
            ),
          ),
        ],
      ),
    );
  }
}
