import 'package:flutter/material.dart';
import '../../Model/adminmodel/adminmodel.dart';
import '../../utils/AppBackground.dart';

import 'add_event_screen.dart';

class EventScreen extends StatelessWidget {
  const EventScreen({super.key});

  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  String _fmt(DateTime d) => '${d.day} ${_months[d.month - 1]}';

  @override
  Widget build(BuildContext context) {
    final events = MockData.events;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        title: const Text('Event'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: events.length,
        separatorBuilder: (_, __) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final e = events[index];
          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey.shade100),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    width: 56,
                    height: 56,
                    color: AppColors.maroon.withOpacity(0.1),
                    child: const Icon(Icons.event, color: AppColors.maroon),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${_fmt(e.startDate)} - ${_fmt(e.endDate)} ${e.endDate.year}',
                        style: TextStyle(
                            fontSize: 12, color: AppColors.textGrey),
                      ),
                      const SizedBox(height: 4),
                      Text.rich(
                        TextSpan(
                          text: 'Registrations: ',
                          style: TextStyle(
                              fontSize: 12, color: AppColors.textGrey),
                          children: [
                            TextSpan(
                              text: '${e.registrations}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_vert, color: Colors.grey),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const AddEventScreen()),
            );
          },
          icon: const Icon(Icons.add, size: 18),
          label: const Text('Add Event'),
        ),
      ),
    );
  }
}
