import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

/// Bundles the Festival banner, Gallery grid, and the bottom
/// "Book Pooja Now" promo card into one reusable section — pulled out
/// of HomeContentPage into its own file (same pattern as
/// MostBookedSection) so it can be reused or edited independently.
///
/// Reads from the same collections HomeContentPage was already using:
///   festivals       (isActive == true) -> title, malayalamTitle,
///                    description, dateRange, image
///   gallery_photos  (ordered by createdAt) -> url
class FestivalGallerySection extends StatelessWidget {
  final VoidCallback onGalleryViewAll;
  final VoidCallback onBookPooja;

  const FestivalGallerySection({
    super.key,
    required this.onGalleryViewAll,
    required this.onBookPooja,
  });

  static const Color primaryColor = Color(0xFF750B0B);
  static const Color darkRed = Color(0xFF570606);

  Widget _remoteImage(
      String path, {
        required double width,
        required double height,
        BorderRadius? radius,
      }) {
    final fallback = Container(
      width: width,
      height: height,
      color: primaryColor.withOpacity(.08),
      child: Icon(Icons.temple_hindu, color: primaryColor),
    );

    final image = path.startsWith('http')
        ? Image.network(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    )
        : Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );

    if (radius == null) return image;
    return ClipRRect(borderRadius: radius, child: image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _festivalCard(),
        const SizedBox(height: 27),
        _gallery(),
        const SizedBox(height: 27),
        _bottomBookingCard(),
      ],
    );
  }

  static const String _fallbackTitle = "KUTTICHATHAN VELLAT";
  static const String _fallbackMalayalamTitle = "കുട്ടിച്ചാത്തൻ വെള്ളാട്ട് 2026";
  static const String _fallbackDateRange = "May 19 - May 25, 2026";
  static const String _fallbackDescription =
      "കുട്ടിച്ചാത്തൻ വെള്ളാട്ട് ഒരു പ്രധാന ക്ഷേത്ര ആചാരമാണ്. ഭക്തർക്ക് "
      "പ്രത്യേക പൂജകളിലും ക്ഷേത്ര ചടങ്ങുകളിലും പങ്കെടുക്കാം.";
  static const String _fallbackFestivalImage = "assets/images/kalleri_7 3.png";

  static const List<String> _fallbackGalleryImages = [
    "assets/images/kalleri01 2.png",
    "assets/images/kalleri04 1.png",
    "assets/images/kalleri_1 1.png",
    "assets/images/img11.png",
    "assets/images/kalleri_03 1.png",
    "assets/images/kalleri_7 3.png",
  ];

  /// The currently-active festival banner, from `festivals` where
  /// isActive == true. Falls back to placeholder content matching the
  /// reference design while loading / if none is active, instead of
  /// hiding the card — so the layout never looks incomplete.
  Widget _festivalCard() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('festivals')
          .where('isActive', isEqualTo: true)
          .limit(1)
          .snapshots(),
      builder: (context, snapshot) {
        final hasLiveDoc =
            snapshot.hasData && snapshot.data!.docs.isNotEmpty;

        final data = hasLiveDoc
            ? snapshot.data!.docs.first.data() as Map<String, dynamic>
            : null;

        final title = (data?['title'] as String?) ?? _fallbackTitle;
        final malayalamTitle =
            (data?['malayalamTitle'] as String?) ?? _fallbackMalayalamTitle;
        final dateRange =
            (data?['dateRange'] as String?) ?? _fallbackDateRange;
        final description =
            (data?['description'] as String?) ?? _fallbackDescription;
        final image =
            (data?['image'] as String?) ?? _fallbackFestivalImage;

        return Container(
          height: 222,
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF4B0303),
                Color(0xFF760909),
              ],
            ),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                right: 75,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (malayalamTitle.isNotEmpty)
                      Text(
                        malayalamTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    const SizedBox(height: 8),
                    Text(
                      dateRange,
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 10,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 9,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: SizedBox(
                  height: 27,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: const BorderSide(color: Colors.white54),
                    ),
                    onPressed: () {},
                    child: const Text(
                      "VIEW DETAILS",
                      style: TextStyle(fontSize: 8),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                child: _remoteImage(
                  image,
                  width: 70,
                  height: 80,
                  radius: BorderRadius.circular(8),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Latest gallery images, from `gallery_photos` ordered by
  /// `createdAt`. Falls back to placeholder photos matching the
  /// reference design if the collection is empty, instead of hiding
  /// the section — so the layout never looks incomplete.
  Widget _gallery() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('gallery_photos')
            .orderBy('createdAt', descending: true)
            .limit(6)
            .snapshots(),
        builder: (context, snapshot) {
          final liveDocs = snapshot.data?.docs ?? const [];
          final usingFallback = liveDocs.isEmpty;
          final int tileCount =
          usingFallback ? _fallbackGalleryImages.length : liveDocs.length;

          return Column(
            children: [
              _sectionHeader("Gallery", onViewAll: onGalleryViewAll),
              const SizedBox(height: 7),
              GridView.builder(
                itemCount: tileCount,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 7,
                  crossAxisSpacing: 7,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final imageUrl = usingFallback
                      ? _fallbackGalleryImages[index]
                      : ((liveDocs[index].data()
                  as Map<String, dynamic>)['url'] as String? ??
                      "");

                  return _remoteImage(
                    imageUrl,
                    width: double.infinity,
                    height: double.infinity,
                    radius: BorderRadius.circular(7),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _bottomBookingCard() {
    return Container(
      height: 76,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: darkRed,
        borderRadius: BorderRadius.circular(9),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(7),
            child: Image.asset(
              "assets/images/lamp.jpg",
              width: 67,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                width: 67,
                height: 60,
                color: Colors.white.withOpacity(.15),
                child: const Icon(Icons.local_fire_department,
                    color: Colors.white, size: 24),
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              "Can't find what you're looking for?\n"
                  "Book poojas, participate in temple events.",
              style: TextStyle(
                color: Colors.white,
                fontSize: 9,
              ),
            ),
          ),
          SizedBox(
            width: 70,
            height: 25,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
                backgroundColor: Colors.white,
                foregroundColor: primaryColor,
              ),
              onPressed: onBookPooja,
              child: const Text(
                "Book Pooja Now",
                style: TextStyle(fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, {VoidCallback? onViewAll}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: primaryColor,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        TextButton(
          onPressed: onViewAll ?? () {},
          style: TextButton.styleFrom(
            minimumSize: Size.zero,
            padding: EdgeInsets.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text(
            "View All >",
            style: TextStyle(
              color: Colors.black,
              fontSize: 9,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}