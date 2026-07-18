import 'package:flutter/material.dart';

import 'gallery_page.dart';


/// The Temple detail content: hero image, title + Malayalam subtitle,
/// translate chip, and the About / Legend / Arrival / Beliefs sections.
///
/// Used by GalleryScreen's Temple tab. [onViewGallery], if provided, is
/// wired to a "View Gallery" style action by the parent — call it to
/// flip the Temple tab over to its photo grid, in place (no
/// Navigator.push, so UserHomePage's Scaffold/bottom nav bar stays put).
class TempleContent extends StatelessWidget {
  final VoidCallback? onViewGallery;

  const TempleContent({super.key, this.onViewGallery});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Hero photo of the temple.
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              'assets/images/kalleri_7 4.png',
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),

          // Title + Malayalam subtitle, centered.
          const Text(
            'SREE KALLERI KUTTICHATHAN KSHETHRAM',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.maroon,
              fontSize: 15,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.3,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'ശ്രീ കല്ലേരി കുട്ടിച്ചാത്തൻ ക്ഷേത്രം',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.maroon,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),

          // Translate chip.
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.cardGrey,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.translate, size: 14, color: AppColors.textDark),
                  SizedBox(width: 6),
                  Text(
                    'Translate Malayalam',
                    style: TextStyle(fontSize: 11, color: AppColors.textDark),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),

          _TempleSection(
            icon: Icons.info_outline,
            title: 'About the Temple',
            body:
            'Kalleri Kuttichathan Temple, located at Villiyappally near '
                'Vadakara in Kozhikode district, is an ancient and '
                'spiritually powerful temple dedicated to Vishnumaya '
                'Kuttichathan, revered as the divine protector of the Kali '
                'Yuga, the temple is one of the most prominent Kuttichathan '
                'worship centers in North Kerala. Devotees from all '
                'communities visit the temple seeking blessings, peace, '
                'and relief from life\'s challenges.',
          ),
          _TempleSection(
            icon: Icons.auto_stories_outlined,
            title: 'Legend',
            body:
            'Incarnation of Vishnumaya. The temple is dedicated to '
                'Vishnumaya Kuttichathan, believed to be the divine son of '
                'Lord Shiva and Goddess Parvati, who appeared in the form '
                'of tribal hunters (Kiratha). His divine presence is '
                'worshipped here with deep faith and devotion.',
          ),
          _TempleSection(
            icon: Icons.place_outlined,
            title: 'Arrival at Kalleri',
            body:
            'According to local belief, centuries ago, the Lord chose '
                'Kalleri as His sacred abode to bless devotees. The '
                'temple\'s rituals and traditional worship have been '
                'preserved and performed for generations by prominent '
                'families of the Thiyya community.',
          ),
          _TempleSection(
            icon: Icons.favorite_border,
            title: 'Beliefs & Significance',
            body:
            'Devotees believe that sincere worship at this temple '
                'brings protection from evil, prosperity, and fulfillment '
                'of wishes. Special poojas and festivals are conducted '
                'through the year, drawing devotees from across the '
                'region.',
          ),
          const SizedBox(height: 8),

          // View Gallery button — flips the Temple tab to its photo grid
          // in place via the callback (no Navigator.pop involved).
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
  }
}

/// Reusable "icon + title + paragraph" section used by TempleContent
/// above (About / Legend / Arrival / Beliefs).
class _TempleSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String body;

  const _TempleSection({
    required this.icon,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
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