// import 'package:flutter/material.dart';
//
// import '../Model/usermodel/Gallery models.dart';
// import 'BookingDetailsPage.dart';
// import 'EventContent.dart';
// import 'FestivalGallerypage.dart';
// import 'Gallery repository.dart';
// import 'My Bookings page.dart';
// import 'Pooja Details page.dart';
// import 'ProfilePage.dart';
// import 'TempleContent.dart';
// import 'homecontent.dart';
//
// /// Colors used across the screen — matches the maroon/gold temple theme.
// class AppColors {
//   static const maroon = Color(0xFF6B1414);
//   static const maroonDark = Color(0xFF4A0E0E);
//   static const gold = Color(0xFFD4AF6A);
//   static const bg = Color(0xFFF7F5F3);
//   static const cardGrey = Color(0xFFF1EEEC);
//   static const textDark = Color(0xFF2A2A2A);
// }
//
// /// NOTE: GalleryScreen is used as a TAB inside UserHomePage's
// /// IndexedStack (see user_home_page.dart). It deliberately does NOT
// /// build its own Scaffold or bottom nav bar — UserHomePage owns the
// /// single shared Scaffold + bottom nav bar for the whole app. Adding a
// /// Scaffold/AppBottomNav here would duplicate that nav bar on screen.
// class GalleryScreen extends StatefulWidget {
//   const GalleryScreen({super.key});
//
//   @override
//   State<GalleryScreen> createState() => _GalleryScreenState();
// }
//
// class _GalleryScreenState extends State<GalleryScreen> {
//   int _categoryIndex = 0;
//   int _mediaTabIndex = 0;
//
//   final _repo = GalleryRepository.instance;
//
//   final List<_CategoryTab> _categories = const [
//     _CategoryTab(icon: Icons.grid_view_rounded, label: 'All', key: null),
//     _CategoryTab(icon: Icons.account_balance, label: 'Temple', key: 'temple'),
//     _CategoryTab(icon: Icons.celebration, label: 'Festivals', key: 'festivals'),
//     _CategoryTab(icon: Icons.groups, label: 'Events', key: 'events'),
//   ];
//
//   // Maps a category label to the gallery page it should push, if any.
//   // "All" has no entry — it never pushes, only flips the IndexedStack.
//   static final Map<String, WidgetBuilder> _galleryPageBuilders = {
//     'Temple': (_) => const GalleryTemplePage(),
//     'Festivals': (_) => const GalleryFestivalPage(),
//     'Events': (_) => const GalleryEventPage(),
//   };
//
//   Future<void> _onCategoryTap(int i, _CategoryTab cat) async {
//     final pageBuilder = _galleryPageBuilders[cat.label];
//
//     if (pageBuilder == null) {
//       // "All" — no navigation involved, just switch tabs immediately.
//       setState(() => _categoryIndex = i);
//       return;
//     }
//
//     // Don't setState(_categoryIndex = i) before the push — see note in
//     // the previous version. Only updates once a result comes back,
//     // either from "View Gallery" buttons or the in-page category tabs.
//     final result = await Navigator.push<int>(
//       context,
//       MaterialPageRoute(builder: pageBuilder),
//     );
//     if (result != null) setState(() => _categoryIndex = result);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Plain content, no Scaffold — this is a tab body inside
//     // UserHomePage's shared Scaffold/IndexedStack.
//     return SafeArea(
//       bottom: false,
//       child: Column(
//         children: [
//           _buildHeader(),
//           _buildCategoryTabs(),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: const EdgeInsets.only(bottom: 16),
//               child: IndexedStack(
//                 index: _categoryIndex,
//                 children: [
//                   _buildAllContent(),
//                   _buildCategoryGrid('temple', 'Temple', Icons.account_balance),
//                   _buildCategoryGrid('festivals', 'Festivals', Icons.celebration),
//                   _buildCategoryGrid('events', 'Events', Icons.groups),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// Photo grid for a single category tab (Temple / Festivals / Events),
//   /// streamed live from `gallery_photos` where category == [categoryKey].
//   Widget _buildCategoryGrid(String categoryKey, String title, IconData icon) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
//           child: Row(
//             children: [
//               Icon(icon, color: AppColors.maroon, size: 18),
//               const SizedBox(width: 8),
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: AppColors.textDark,
//                 ),
//               ),
//             ],
//           ),
//         ),
//         StreamBuilder<List<GalleryMediaItem>>(
//           stream: _repo.watchPhotos(category: categoryKey),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return const _GridLoading();
//             }
//             if (snapshot.hasError) {
//               return _GridError(message: '${snapshot.error}');
//             }
//             final photos = snapshot.data ?? const [];
//             if (photos.isEmpty) {
//               return const _GridEmpty(message: 'No photos yet.');
//             }
//             return _MasonryPhotoGrid(urls: photos.map((p) => p.url).toList());
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.maroon, AppColors.maroonDark],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(28),
//           bottomRight: Radius.circular(28),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: const [
//                   Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
//                   SizedBox(width: 12),
//                   Text(
//                     'Gallery',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white70, width: 1.2),
//                 ),
//                 child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           const Text(
//             'SREE KALLERI KUTTICHATHAN KSHETHRAM',
//             style: TextStyle(
//               color: AppColors.gold,
//               fontSize: 11,
//               letterSpacing: 1.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Container(width: 24, height: 1, color: AppColors.gold.withOpacity(0.6)),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 6),
//                 child: Icon(Icons.diamond_outlined, color: AppColors.gold, size: 10),
//               ),
//               Container(width: 24, height: 1, color: AppColors.gold.withOpacity(0.6)),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildCategoryTabs() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//       child: Row(
//         children: List.generate(_categories.length, (i) {
//           final selected = i == _categoryIndex;
//           final cat = _categories[i];
//           return Expanded(
//             child: GestureDetector(
//               onTap: () => _onCategoryTap(i, cat),
//               child: Container(
//                 margin: EdgeInsets.only(right: i == _categories.length - 1 ? 0 : 8),
//                 padding: const EdgeInsets.symmetric(vertical: 12),
//                 decoration: BoxDecoration(
//                   color: selected ? AppColors.maroon : Colors.white,
//                   borderRadius: BorderRadius.circular(14),
//                   border: selected ? null : Border.all(color: Colors.black12),
//                 ),
//                 child: Column(
//                   children: [
//                     Icon(cat.icon, size: 20, color: selected ? Colors.white : AppColors.maroon),
//                     const SizedBox(height: 4),
//                     Text(
//                       cat.label,
//                       style: TextStyle(
//                         fontSize: 11,
//                         fontWeight: FontWeight.w600,
//                         color: selected ? Colors.white : AppColors.textDark,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
//
//   Widget _buildAllContent() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         _buildFeaturedAlbum(),
//         _buildMediaTabs(),
//         _mediaTabIndex == 0 ? _buildAllPhotos() : _buildAllVideos(),
//       ],
//     );
//   }
//
//   /// Featured album banner, fetched once from `featured_album/main`.
//   Widget _buildFeaturedAlbum() {
//     return FutureBuilder<FeaturedAlbum>(
//       future: _repo.fetchFeaturedAlbum(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Container(
//               height: 220,
//               decoration: BoxDecoration(
//                 color: AppColors.cardGrey,
//                 borderRadius: BorderRadius.circular(18),
//               ),
//               child: const Center(child: CircularProgressIndicator()),
//             ),
//           );
//         }
//         if (snapshot.hasError || !snapshot.hasData) {
//           return const SizedBox.shrink();
//         }
//         final album = snapshot.data!;
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(18),
//             child: Stack(
//               children: [
//                 Image.network(
//                   album.coverImageUrl,
//                   height: 220,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, progress) {
//                     if (progress == null) return child;
//                     return Container(height: 220, color: AppColors.cardGrey);
//                   },
//                   errorBuilder: (_, __, ___) => Container(
//                     height: 220,
//                     color: AppColors.cardGrey,
//                     child: const Icon(Icons.broken_image_outlined, color: AppColors.maroon),
//                   ),
//                 ),
//                 Container(
//                   height: 220,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.bottomCenter,
//                       end: Alignment.topCenter,
//                       colors: [Colors.black.withOpacity(0.75), Colors.transparent],
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   left: 16,
//                   right: 16,
//                   bottom: 16,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         children: const [
//                           Icon(Icons.star, color: AppColors.gold, size: 14),
//                           SizedBox(width: 4),
//                           Text(
//                             'FEATURED ALBUM',
//                             style: TextStyle(
//                               color: AppColors.gold,
//                               fontSize: 11,
//                               fontWeight: FontWeight.w700,
//                               letterSpacing: 0.6,
//                             ),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         album.title,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       const SizedBox(height: 2),
//                       Text(
//                         '${album.photoCount} Photos • ${album.videoCount} Videos',
//                         style: const TextStyle(color: Colors.white70, fontSize: 12),
//                       ),
//                       const SizedBox(height: 10),
//                       Container(
//                         padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
//                         decoration: BoxDecoration(
//                           border: Border.all(color: AppColors.gold),
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: const [
//                             Text(
//                               'VIEW ALBUM',
//                               style: TextStyle(
//                                 color: AppColors.gold,
//                                 fontSize: 11,
//                                 fontWeight: FontWeight.w700,
//                                 letterSpacing: 0.5,
//                               ),
//                             ),
//                             SizedBox(width: 6),
//                             Icon(Icons.arrow_forward, color: AppColors.gold, size: 14),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildMediaTabs() {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
//       child: Row(
//         children: [
//           _mediaTabButton(0, Icons.image_outlined, 'Photos'),
//           const SizedBox(width: 24),
//           _mediaTabButton(1, Icons.videocam_outlined, 'Videos'),
//         ],
//       ),
//     );
//   }
//
//   Widget _mediaTabButton(int index, IconData icon, String label) {
//     final selected = index == _mediaTabIndex;
//     return GestureDetector(
//       onTap: () => setState(() => _mediaTabIndex = index),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Icon(icon, size: 18, color: selected ? AppColors.maroon : Colors.grey),
//               const SizedBox(width: 6),
//               Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.w600,
//                   color: selected ? AppColors.maroon : Colors.grey,
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Container(
//             height: 2,
//             width: 60,
//             color: selected ? AppColors.maroon : Colors.transparent,
//           ),
//         ],
//       ),
//     );
//   }
//
//   /// "All" tab photo grid — every photo across all categories, streamed
//   /// live from `gallery_photos` (no category filter).
//   Widget _buildAllPhotos() {
//     return StreamBuilder<List<GalleryMediaItem>>(
//       stream: _repo.watchPhotos(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const _GridLoading();
//         }
//         if (snapshot.hasError) return _GridError(message: '${snapshot.error}');
//         final photos = snapshot.data ?? const [];
//         if (photos.isEmpty) return const _GridEmpty(message: 'No photos yet.');
//         return _MasonryPhotoGrid(urls: photos.map((p) => p.url).toList());
//       },
//     );
//   }
//
//   /// "All" tab video grid — same idea, from `gallery_videos`.
//   Widget _buildAllVideos() {
//     return StreamBuilder<List<GalleryMediaItem>>(
//       stream: _repo.watchVideos(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const _GridLoading();
//         }
//         if (snapshot.hasError) return _GridError(message: '${snapshot.error}');
//         final videos = snapshot.data ?? const [];
//         if (videos.isEmpty) return const _GridEmpty(message: 'No videos yet.');
//         return _MasonryVideoGrid(videos: videos);
//       },
//     );
//   }
// }
//
// /// 3-column masonry-style layout for photo URLs, same visual shape as
// /// the original hardcoded grid.
// class _MasonryPhotoGrid extends StatelessWidget {
//   final List<String> urls;
//   const _MasonryPhotoGrid({required this.urls});
//
//   @override
//   Widget build(BuildContext context) {
//     final columns = [<String>[], <String>[], <String>[]];
//     for (int i = 0; i < urls.length; i++) {
//       columns[i % 3].add(urls[i]);
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: columns.map((colUrls) {
//           return Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: Column(
//                 children: colUrls.map((url) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(10),
//                       child: Image.network(
//                         url,
//                         fit: BoxFit.cover,
//                         loadingBuilder: (context, child, progress) {
//                           if (progress == null) return child;
//                           return AspectRatio(
//                             aspectRatio: 1,
//                             child: Container(color: AppColors.cardGrey),
//                           );
//                         },
//                         errorBuilder: (_, __, ___) => AspectRatio(
//                           aspectRatio: 1,
//                           child: Container(
//                             color: AppColors.cardGrey,
//                             child: const Icon(Icons.broken_image_outlined,
//                                 color: AppColors.maroon, size: 18),
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class _MasonryVideoGrid extends StatelessWidget {
//   final List<GalleryMediaItem> videos;
//   const _MasonryVideoGrid({required this.videos});
//
//   @override
//   Widget build(BuildContext context) {
//     final columns = [<GalleryMediaItem>[], <GalleryMediaItem>[], <GalleryMediaItem>[]];
//     for (int i = 0; i < videos.length; i++) {
//       columns[i % 3].add(videos[i]);
//     }
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: columns.map((colItems) {
//           return Expanded(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 4),
//               child: Column(
//                 children: colItems.map((item) {
//                   final thumb = item.thumbnailUrl ?? item.url;
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 8),
//                     child: GestureDetector(
//                       onTap: () {},
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Stack(
//                           alignment: Alignment.center,
//                           children: [
//                             Image.network(
//                               thumb,
//                               fit: BoxFit.cover,
//                               errorBuilder: (_, __, ___) => AspectRatio(
//                                 aspectRatio: 1,
//                                 child: Container(color: AppColors.cardGrey),
//                               ),
//                             ),
//                             Positioned.fill(
//                               child: Container(color: Colors.black.withOpacity(0.25)),
//                             ),
//                             Container(
//                               padding: const EdgeInsets.all(6),
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.45),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: const Icon(
//                                 Icons.play_arrow_rounded,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           );
//         }).toList(),
//       ),
//     );
//   }
// }
//
// class _GridLoading extends StatelessWidget {
//   const _GridLoading();
//   @override
//   Widget build(BuildContext context) {
//     return const Padding(
//       padding: EdgeInsets.symmetric(vertical: 40),
//       child: Center(child: CircularProgressIndicator()),
//     );
//   }
// }
//
// class _GridEmpty extends StatelessWidget {
//   final String message;
//   const _GridEmpty({required this.message});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 40),
//       child: Center(
//         child: Text(message, style: const TextStyle(color: Colors.grey)),
//       ),
//     );
//   }
// }
//
// class _GridError extends StatelessWidget {
//   final String message;
//   const _GridError({required this.message});
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
//       child: Center(
//         child: Text(
//           'Couldn\'t load: $message',
//           textAlign: TextAlign.center,
//           style: const TextStyle(color: Colors.redAccent, fontSize: 12),
//         ),
//       ),
//     );
//   }
// }
//
// class _CategoryTab {
//   final IconData icon;
//   final String label;
//   final String? key; // Firestore category value; null for "All"
//   const _CategoryTab({required this.icon, required this.label, required this.key});
// }
//
// /// NOTE: these three detail pages (Temple / Festival / Event) are pushed
// /// via Navigator.push from GalleryScreen's category tabs — they're real
// /// separate routes, so keeping their own Scaffold here is fine. They no
// /// longer have a bottomNavigationBar, since tapping a category tab
// /// inside them just pops back to GalleryScreen (which is already a tab
// /// inside UserHomePage's single shared nav bar) via
// /// Navigator.pop(context, i) in _buildCategoryTabsFor below.
// class GalleryTemplePage extends StatefulWidget {
//   const GalleryTemplePage({super.key});
//
//   @override
//   State<GalleryTemplePage> createState() => _GalleryTemplePageState();
// }
//
// class _GalleryTemplePageState extends State<GalleryTemplePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             _buildGalleryDetailHeader(
//               subtitle: 'SRI KALLERI KALICHAMUNDI KSHETHRAM',
//             ),
//             _buildCategoryTabsFor(context, 'Temple'),
//             const Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.only(bottom: 16),
//                 child: TempleContent(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class GalleryFestivalPage extends StatefulWidget {
//   const GalleryFestivalPage({super.key});
//
//   @override
//   State<GalleryFestivalPage> createState() => _GalleryFestivalPageState();
// }
//
// class _GalleryFestivalPageState extends State<GalleryFestivalPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             _buildGalleryDetailHeader(
//               subtitle: 'SREE KALLERI KUTTICHATHAN KSHETHRAM',
//             ),
//             _buildCategoryTabsFor(context, 'Festivals'),
//             const Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.only(bottom: 16),
//                 child: FestivalContent(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class GalleryEventPage extends StatefulWidget {
//   const GalleryEventPage({super.key});
//
//   @override
//   State<GalleryEventPage> createState() => _GalleryEventPageState();
// }
//
// class _GalleryEventPageState extends State<GalleryEventPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         bottom: false,
//         child: Column(
//           children: [
//             _buildGalleryDetailHeader(
//               subtitle: 'SREE KALLERI KUTTICHATHAN KSHETHRAM',
//             ),
//             _buildCategoryTabsFor(context, 'Events'),
//             const Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.only(bottom: 16),
//                 child: EventContent(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// Widget _buildGalleryDetailHeader({required String subtitle}) {
//   return Builder(
//     builder: (context) => Container(
//       width: double.infinity,
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [AppColors.maroon, AppColors.maroonDark],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(28),
//           bottomRight: Radius.circular(28),
//         ),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
//                   ),
//                   const SizedBox(width: 12),
//                   const Text(
//                     'Gallery',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white70, width: 1.2),
//                 ),
//                 child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
//               ),
//             ],
//           ),
//           const SizedBox(height: 6),
//           Text(
//             subtitle,
//             style: const TextStyle(
//               color: AppColors.gold,
//               fontSize: 11,
//               letterSpacing: 1.0,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             children: [
//               Container(width: 24, height: 1, color: AppColors.gold.withOpacity(0.6)),
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 6),
//                 child: Icon(Icons.diamond_outlined, color: AppColors.gold, size: 10),
//               ),
//               Container(width: 24, height: 1, color: AppColors.gold.withOpacity(0.6)),
//             ],
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// /// Category tab strip shown inside a detail page (Temple / Festival /
// /// Event). Tapping a different category pops back to GalleryScreen with
// /// that category's index (0 All, 1 Temple, 2 Festivals, 3 Events) so its
// /// tab strip and IndexedStack land on the right place.
// Widget _buildCategoryTabsFor(BuildContext context, String activeLabel) {
//   final tabs = const [
//     _CategoryTab(icon: Icons.grid_view_rounded, label: 'All', key: null),
//     _CategoryTab(icon: Icons.account_balance, label: 'Temple', key: 'temple'),
//     _CategoryTab(icon: Icons.celebration, label: 'Festivals', key: 'festivals'),
//     _CategoryTab(icon: Icons.groups, label: 'Events', key: 'events'),
//   ];
//
//   return Padding(
//     padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
//     child: Row(
//       children: List.generate(tabs.length, (i) {
//         final selected = tabs[i].label == activeLabel;
//         final cat = tabs[i];
//         return Expanded(
//           child: GestureDetector(
//             onTap: () {
//               if (cat.label == activeLabel) return;
//               Navigator.pop(context, i);
//             },
//             child: Container(
//               margin: EdgeInsets.only(right: i == tabs.length - 1 ? 0 : 8),
//               padding: const EdgeInsets.symmetric(vertical: 12),
//               decoration: BoxDecoration(
//                 color: selected ? AppColors.maroon : Colors.white,
//                 borderRadius: BorderRadius.circular(14),
//                 border: selected ? null : Border.all(color: Colors.black12),
//               ),
//               child: Column(
//                 children: [
//                   Icon(cat.icon, size: 20, color: selected ? Colors.white : AppColors.maroon),
//                   const SizedBox(height: 4),
//                   Text(
//                     cat.label,
//                     style: TextStyle(
//                       fontSize: 11,
//                       fontWeight: FontWeight.w600,
//                       color: selected ? Colors.white : AppColors.textDark,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     ),
//   );
// }
import 'package:flutter/material.dart';

import '../Model/usermodel/Gallery models.dart';
import 'BookingDetailsPage.dart';
import 'EventContent.dart';
import 'FestivalGallerypage.dart';
import 'Gallery repository.dart';
import 'My Bookings page.dart';
import 'Pooja Details page.dart';
import 'ProfilePage.dart';
import 'TempleContent.dart';
import 'homecontent.dart';

/// Colors used across the screen — matches the maroon/gold temple theme.
class AppColors {
  static const maroon = Color(0xFF6B1414);
  static const maroonDark = Color(0xFF4A0E0E);
  static const gold = Color(0xFFD4AF6A);
  static const bg = Color(0xFFF7F5F3);
  static const cardGrey = Color(0xFFF1EEEC);
  static const textDark = Color(0xFF2A2A2A);
}

/// NOTE: GalleryScreen is used as a TAB inside UserHomePage's
/// IndexedStack (see user_home_page.dart). It deliberately does NOT
/// build its own Scaffold or bottom nav bar — UserHomePage owns the
/// single shared Scaffold + bottom nav bar for the whole app. Adding a
/// Scaffold/AppBottomNav here would duplicate that nav bar on screen.
///
/// IMPORTANT: Temple / Festivals / Events NO LONGER use Navigator.push.
/// Pushing a new MaterialPageRoute covered the whole screen — including
/// UserHomePage's Scaffold and bottom nav bar — which is why the nav bar
/// used to disappear when opening those tabs. Now everything (detail
/// content AND photo grid) is swapped in place inside this screen's own
/// IndexedStack, so UserHomePage's Scaffold/nav bar is never covered.
class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int _categoryIndex = 0;
  int _mediaTabIndex = 0;

  // Per-category: true = showing the info/detail content (Temple/Festival/
  // Event text + "View Gallery" button), false = showing that category's
  // photo grid. Defaults to the detail view whenever a category is
  // freshly selected.
  final Map<String, bool> _showDetail = {
    'temple': true,
    'festivals': true,
    'events': true,
  };

  final _repo = GalleryRepository.instance;

  final List<_CategoryTab> _categories = const [
    _CategoryTab(icon: Icons.grid_view_rounded, label: 'All', key: null),
    _CategoryTab(icon: Icons.account_balance, label: 'Temple', key: 'temple'),
    _CategoryTab(icon: Icons.celebration, label: 'Festivals', key: 'festivals'),
    _CategoryTab(icon: Icons.groups, label: 'Events', key: 'events'),
  ];

  /// Tapping the tab you're already on toggles between the info/detail
  /// content and the photo grid for that category. Tapping a different
  /// tab switches to it and resets it to the detail view. This all just
  /// flips local state — no Navigator.push, so UserHomePage's shared
  /// Scaffold/bottom nav bar is never covered up.
  void _onCategoryTap(int i, _CategoryTab cat) {
    setState(() {
      if (i == _categoryIndex && cat.key != null) {
        _showDetail[cat.key!] = !(_showDetail[cat.key!] ?? true);
      } else {
        _categoryIndex = i;
        if (cat.key != null) _showDetail[cat.key!] = true;
      }
    });
  }

  /// Called by the "View Gallery" button inside TempleContent /
  /// FestivalContent / EventContent to flip that category over to its
  /// photo grid, in place.
  void _showGridFor(String key) {
    setState(() => _showDetail[key] = false);
  }

  @override
  Widget build(BuildContext context) {
    // Plain content, no Scaffold — this is a tab body inside
    // UserHomePage's shared Scaffold/IndexedStack.
    return SafeArea(
      bottom: false,
      child: Column(
        children: [
          _buildHeader(),
          _buildCategoryTabs(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              child: IndexedStack(
                index: _categoryIndex,
                children: [
                  _buildAllContent(),
                  _buildTempleTab(),
                  _buildFestivalsTab(),
                  _buildEventsTab(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTempleTab() {
    if (_showDetail['temple'] ?? true) {
      return TempleContent(onViewGallery: () => _showGridFor('temple'));
    }
    return _buildCategoryGrid('temple', 'Temple', Icons.account_balance);
  }

  Widget _buildFestivalsTab() {
    if (_showDetail['festivals'] ?? true) {
      return FestivalContent(onViewGallery: () => _showGridFor('festivals'));
    }
    return _buildCategoryGrid('festivals', 'Festivals', Icons.celebration);
  }

  Widget _buildEventsTab() {
    if (_showDetail['events'] ?? true) {
      return EventContent(onViewGallery: () => _showGridFor('events'));
    }
    return _buildCategoryGrid('events', 'Events', Icons.groups);
  }

  /// Photo grid for a single category tab (Temple / Festivals / Events),
  /// streamed live from `gallery_photos` where category == [categoryKey].
  Widget _buildCategoryGrid(String categoryKey, String title, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Row(
            children: [
              Icon(icon, color: AppColors.maroon, size: 18),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const Spacer(),
              // Lets the user jump back to the info/detail view without
              // needing to double-tap the category tab above.
              TextButton.icon(
                onPressed: () => setState(() => _showDetail[categoryKey] = true),
                icon: const Icon(Icons.info_outline, size: 16, color: AppColors.maroon),
                label: const Text(
                  'View Info',
                  style: TextStyle(fontSize: 12, color: AppColors.maroon),
                ),
              ),
            ],
          ),
        ),
        StreamBuilder<List<GalleryMediaItem>>(
          stream: _repo.watchPhotos(category: categoryKey),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const _GridLoading();
            }
            if (snapshot.hasError) {
              return _GridError(message: '${snapshot.error}');
            }
            final photos = snapshot.data ?? const [];
            if (photos.isEmpty) {
              return const _GridEmpty(message: 'No photos yet.');
            }
            return _MasonryPhotoGrid(urls: photos.map((p) => p.url).toList());
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.maroon, AppColors.maroonDark],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
                  SizedBox(width: 12),
                  Text(
                    'Gallery',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white70, width: 1.2),
                ),
                child: const Icon(Icons.notifications_none, color: Colors.white, size: 20),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Text(
            'SREE KALLERI KUTTICHATHAN KSHETHRAM',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 11,
              letterSpacing: 1.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(width: 24, height: 1, color: AppColors.gold.withOpacity(0.6)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6),
                child: Icon(Icons.diamond_outlined, color: AppColors.gold, size: 10),
              ),
              Container(width: 24, height: 1, color: AppColors.gold.withOpacity(0.6)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      child: Row(
        children: List.generate(_categories.length, (i) {
          final selected = i == _categoryIndex;
          final cat = _categories[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => _onCategoryTap(i, cat),
              child: Container(
                margin: EdgeInsets.only(right: i == _categories.length - 1 ? 0 : 8),
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: selected ? AppColors.maroon : Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  border: selected ? null : Border.all(color: Colors.black12),
                ),
                child: Column(
                  children: [
                    Icon(cat.icon, size: 20, color: selected ? Colors.white : AppColors.maroon),
                    const SizedBox(height: 4),
                    Text(
                      cat.label,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildAllContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFeaturedAlbum(),
        _buildMediaTabs(),
        _mediaTabIndex == 0 ? _buildAllPhotos() : _buildAllVideos(),
      ],
    );
  }

  /// Featured album banner, fetched once from `featured_album/main`.
  Widget _buildFeaturedAlbum() {
    return FutureBuilder<FeaturedAlbum>(
      future: _repo.fetchFeaturedAlbum(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 220,
              decoration: BoxDecoration(
                color: AppColors.cardGrey,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return const SizedBox.shrink();
        }
        final album = snapshot.data!;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(18),
            child: Stack(
              children: [
                Image.network(
                  album.coverImageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Container(height: 220, color: AppColors.cardGrey);
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 220,
                    color: AppColors.cardGrey,
                    child: const Icon(Icons.broken_image_outlined, color: AppColors.maroon),
                  ),
                ),
                Container(
                  height: 220,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Colors.black.withOpacity(0.75), Colors.transparent],
                    ),
                  ),
                ),
                Positioned(
                  left: 16,
                  right: 16,
                  bottom: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: const [
                          Icon(Icons.star, color: AppColors.gold, size: 14),
                          SizedBox(width: 4),
                          Text(
                            'FEATURED ALBUM',
                            style: TextStyle(
                              color: AppColors.gold,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.6,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        album.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${album.photoCount} Photos • ${album.videoCount} Videos',
                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.gold),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Text(
                              'VIEW ALBUM',
                              style: TextStyle(
                                color: AppColors.gold,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(Icons.arrow_forward, color: AppColors.gold, size: 14),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMediaTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      child: Row(
        children: [
          _mediaTabButton(0, Icons.image_outlined, 'Photos'),
          const SizedBox(width: 24),
          _mediaTabButton(1, Icons.videocam_outlined, 'Videos'),
        ],
      ),
    );
  }

  Widget _mediaTabButton(int index, IconData icon, String label) {
    final selected = index == _mediaTabIndex;
    return GestureDetector(
      onTap: () => setState(() => _mediaTabIndex = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: selected ? AppColors.maroon : Colors.grey),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: selected ? AppColors.maroon : Colors.grey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Container(
            height: 2,
            width: 60,
            color: selected ? AppColors.maroon : Colors.transparent,
          ),
        ],
      ),
    );
  }

  /// "All" tab photo grid — every photo across all categories, streamed
  /// live from `gallery_photos` (no category filter).
  Widget _buildAllPhotos() {
    return StreamBuilder<List<GalleryMediaItem>>(
      stream: _repo.watchPhotos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _GridLoading();
        }
        if (snapshot.hasError) return _GridError(message: '${snapshot.error}');
        final photos = snapshot.data ?? const [];
        if (photos.isEmpty) return const _GridEmpty(message: 'No photos yet.');
        return _MasonryPhotoGrid(urls: photos.map((p) => p.url).toList());
      },
    );
  }

  /// "All" tab video grid — same idea, from `gallery_videos`.
  Widget _buildAllVideos() {
    return StreamBuilder<List<GalleryMediaItem>>(
      stream: _repo.watchVideos(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _GridLoading();
        }
        if (snapshot.hasError) return _GridError(message: '${snapshot.error}');
        final videos = snapshot.data ?? const [];
        if (videos.isEmpty) return const _GridEmpty(message: 'No videos yet.');
        return _MasonryVideoGrid(videos: videos);
      },
    );
  }
}

/// 3-column masonry-style layout for photo URLs, same visual shape as
/// the original hardcoded grid.
class _MasonryPhotoGrid extends StatelessWidget {
  final List<String> urls;
  const _MasonryPhotoGrid({required this.urls});

  @override
  Widget build(BuildContext context) {
    final columns = [<String>[], <String>[], <String>[]];
    for (int i = 0; i < urls.length; i++) {
      columns[i % 3].add(urls[i]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns.map((colUrls) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: colUrls.map((url) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        url,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return AspectRatio(
                            aspectRatio: 1,
                            child: Container(color: AppColors.cardGrey),
                          );
                        },
                        errorBuilder: (_, __, ___) => AspectRatio(
                          aspectRatio: 1,
                          child: Container(
                            color: AppColors.cardGrey,
                            child: const Icon(Icons.broken_image_outlined,
                                color: AppColors.maroon, size: 18),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _MasonryVideoGrid extends StatelessWidget {
  final List<GalleryMediaItem> videos;
  const _MasonryVideoGrid({required this.videos});

  @override
  Widget build(BuildContext context) {
    final columns = [<GalleryMediaItem>[], <GalleryMediaItem>[], <GalleryMediaItem>[]];
    for (int i = 0; i < videos.length; i++) {
      columns[i % 3].add(videos[i]);
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: columns.map((colItems) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                children: colItems.map((item) {
                  final thumb = item.thumbnailUrl ?? item.url;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: GestureDetector(
                      onTap: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.network(
                              thumb,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => AspectRatio(
                                aspectRatio: 1,
                                child: Container(color: AppColors.cardGrey),
                              ),
                            ),
                            Positioned.fill(
                              child: Container(color: Colors.black.withOpacity(0.25)),
                            ),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.45),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.play_arrow_rounded,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _GridLoading extends StatelessWidget {
  const _GridLoading();
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 40),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _GridEmpty extends StatelessWidget {
  final String message;
  const _GridEmpty({required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Text(message, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class _GridError extends StatelessWidget {
  final String message;
  const _GridError({required this.message});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
      child: Center(
        child: Text(
          'Couldn\'t load: $message',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.redAccent, fontSize: 12),
        ),
      ),
    );
  }
}

class _CategoryTab {
  final IconData icon;
  final String label;
  final String? key; // Firestore category value; null for "All"
  const _CategoryTab({required this.icon, required this.label, required this.key});
}

// NOTE: GalleryTemplePage, GalleryFestivalPage, GalleryEventPage,
// _buildGalleryDetailHeader, and _buildCategoryTabsFor have all been
// removed. They existed only to support Navigator.push-ing to separate
// routes, which is what covered UserHomePage's Scaffold/bottom nav bar.
// Temple/Festival/Event content now renders directly inside this
// screen's IndexedStack via _buildTempleTab / _buildFestivalsTab /
// _buildEventsTab above.