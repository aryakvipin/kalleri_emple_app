import 'package:flutter/material.dart';

import '../Model/usermodel/Gallery models.dart';
import 'Gallery repository.dart';
import 'gallery_page.dart';



/// The Events detail content: a date-calendar strip up top, then event
/// cards grouped under time-of-day section headers (Morning & Afternoon
/// Rituals, Evening Grandeur) — streamed live from the `events`
/// collection in Firestore, filtered by the selected day.
///
/// Used by GalleryScreen's Events tab. [onViewGallery], if provided,
/// flips the Events tab over to its photo grid in place (no
/// Navigator.pop, so UserHomePage's Scaffold/bottom nav bar stays put).
class EventContent extends StatefulWidget {
  final VoidCallback? onViewGallery;

  const EventContent({super.key, this.onViewGallery});

  @override
  State<EventContent> createState() => _EventContentState();
}

class _EventContentState extends State<EventContent> {
  int _selectedDayIndex = 1; // index into _days below

  // The calendar strip itself stays static UI (pick whichever 4 dates
  // your festival actually runs); `dayNum` is what's matched against the
  // `dayNum` field on each Firestore event doc.
  final List<Map<String, String>> _days = const [
    {'dayNum': '19', 'label': 'Sun'},
    {'dayNum': '20', 'label': 'Mon'},
    {'dayNum': '21', 'label': 'Tue'},
    {'dayNum': '22', 'label': 'Wed'},
  ];

  @override
  Widget build(BuildContext context) {
    final selectedDayNum = _days[_selectedDayIndex]['dayNum']!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCalendarStrip(),
          const SizedBox(height: 20),
          StreamBuilder<List<EventEntryModel>>(
            stream: GalleryRepository.instance.watchEvents(selectedDayNum),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      'Couldn\'t load events: ${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent, fontSize: 12),
                    ),
                  ),
                );
              }

              final events = snapshot.data ?? const [];
              final morning =
              events.where((e) => e.timeOfDay == 'morning').toList();
              final evening =
              events.where((e) => e.timeOfDay == 'evening').toList();

              if (events.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40),
                  child: Center(
                    child: Text(
                      'No events scheduled for this day yet.',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (morning.isNotEmpty) ...[
                    _buildSectionHeader(
                        Icons.wb_sunny_outlined, 'Morning & Afternoon Rituals'),
                    const SizedBox(height: 10),
                    ...morning.map(_buildEventCard),
                    const SizedBox(height: 12),
                  ],
                  if (evening.isNotEmpty) ...[
                    _buildSectionHeader(Icons.nights_stay_outlined, 'Evening Grandeur'),
                    const SizedBox(height: 10),
                    ...evening.map(_buildEventCard),
                  ],
                ],
              );
            },
          ),
          const SizedBox(height: 8),

          // View Gallery button — flips the Events tab to its photo grid
          // in place via the callback.
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: widget.onViewGallery,
              icon: const Icon(Icons.photo_library_outlined, size: 18),
              label: const Text('View Gallery'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.maroon,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildCalendarStrip() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.event_note_outlined, size: 16, color: AppColors.maroon),
            SizedBox(width: 6),
            Text(
              'Events Calendar',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.maroon,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: List.generate(_days.length, (i) {
            final selected = i == _selectedDayIndex;
            final day = _days[i];
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _selectedDayIndex = i),
                child: Container(
                  margin: EdgeInsets.only(right: i == _days.length - 1 ? 0 : 8),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.maroon : AppColors.cardGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      Text(
                        day['dayNum']!,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: selected ? Colors.white : AppColors.textDark,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        day['label']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: selected ? Colors.white70 : AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.maroon),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: AppColors.maroon,
          ),
        ),
      ],
    );
  }

  Widget _buildEventCard(EventEntryModel event) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(14),
                  topRight: Radius.circular(14),
                ),
                child: Image.network(
                  event.imageUrl,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(height: 100, color: AppColors.cardGrey);
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 100,
                    color: AppColors.cardGrey,
                    child: const Icon(Icons.broken_image_outlined, color: AppColors.maroon),
                  ),
                ),
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.gold,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    event.time,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.maroonDark,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  event.description,
                  style: const TextStyle(
                    fontSize: 11.5,
                    height: 1.4,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}