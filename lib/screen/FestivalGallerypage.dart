import 'package:flutter/material.dart';

import '../Model/usermodel/Gallery models.dart';
import 'Gallery repository.dart';
import 'gallery_page.dart';



/// The Festival detail content: hero image with a date badge, title +
/// Malayalam subtitle, duration/location chips, and the About / Daily
/// rituals / Highlights sections — all fetched from `festival_info/main`
/// in Firestore.
///
/// Used by GalleryScreen's Festivals tab. [onViewGallery], if provided,
/// flips the Festivals tab over to its photo grid in place (no
/// Navigator.pop, so UserHomePage's Scaffold/bottom nav bar stays put).
class FestivalContent extends StatelessWidget {
  final VoidCallback? onViewGallery;

  const FestivalContent({super.key, this.onViewGallery});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FestivalInfo>(
      future: GalleryRepository.instance.fetchFestivalInfo(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 60),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
            child: Center(
              child: Text(
                'Couldn\'t load festival info: ${snapshot.error}',
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.redAccent, fontSize: 12),
              ),
            ),
          );
        }

        final info = snapshot.data!;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Hero photo with a date-range badge overlaid top-left.
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Stack(
                  children: [
                    Image.network(
                      info.heroImageUrl,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return Container(height: 150, color: AppColors.cardGrey);
                      },
                      errorBuilder: (_, __, ___) => Container(
                        height: 150,
                        color: AppColors.cardGrey,
                        child: const Icon(Icons.broken_image_outlined, color: AppColors.maroon),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.55),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          info.dateRangeLabel,
                          style: const TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Title + Malayalam subtitle, centered.
              Text(
                info.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.maroon,
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                info.malayalamTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.maroon,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),

              // Duration + location chips.
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildChip(Icons.event_note_outlined, info.duration),
                  const SizedBox(width: 8),
                  _buildChip(Icons.location_on_outlined, info.location),
                ],
              ),
              const SizedBox(height: 20),

              // About / Daily rituals / Highlights — driven entirely by
              // info.sections from Firestore.
              for (final section in info.sections)
                _buildFestivalSection(
                  icon: section.icon,
                  title: section.title,
                  body: section.body,
                ),
              const SizedBox(height: 8),

              // View Gallery button — flips the Festivals tab to its
              // photo grid in place via the callback.
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onViewGallery,
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
      },
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.cardGrey,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13, color: AppColors.textDark),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(fontSize: 10, color: AppColors.textDark),
          ),
        ],
      ),
    );
  }

  Widget _buildFestivalSection({
    required IconData icon,
    required String title,
    required String body,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
          ),
          const SizedBox(height: 6),
          Text(
            body,
            style: const TextStyle(
              fontSize: 12.5,
              height: 1.5,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }
}