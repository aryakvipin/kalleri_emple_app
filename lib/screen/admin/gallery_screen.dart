import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kalleri_emple_app/screen/admin/widgets/bottom_nav.dart';

import '../../../utils/AppBackground.dart';
import 'Add event page.dart';
import 'Add media page.dart';
import 'add_pooja_screen.dart';
import 'bookings_screen.dart';
import 'profile_screen.dart';

/// ASSUMED FIRESTORE SCHEMA — adjust field/collection names if yours
/// differ, it's all isolated to the StreamBuilders below.
///
/// gallery (collection) — written by AddMediaPage
///     imageUrl (String), thumbnailUrl (String, video only),
///     type ('photo' | 'video'), category ('temple' | 'festivals' |
///     'events'), order (num)
/// events  (collection) — written by AddEventPage
///     title (String), startDate (Timestamp), endDate (Timestamp),
///     description (String), bannerUrl (String?)
///
/// Matches the rest of the admin screens' pattern (DashboardScreen,
/// BookingsScreen, AddPoojaScreen, etc.): an `embedded` flag decides
/// whether this widget draws its own Scaffold + bottom nav (standalone,
/// pushed via Navigator — the current DashboardScreen behavior) or just
/// its bare content (for if you later embed it inside some other shell).
class AdminGalleryPage extends StatefulWidget {
  final bool embedded;

  const AdminGalleryPage({super.key, this.embedded = true});

  @override
  State<AdminGalleryPage> createState() => _AdminGalleryPageState();
}

class _AdminGalleryPageState extends State<AdminGalleryPage> {
  int _sectionIndex = 0; // 0 = Gallery, 1 = Events
  int _mediaTabIndex = 0; // 0 = Images, 1 = Videos

  // This page represents index 3 (Gallery) in the bottom nav.
  static const int _navIndex = 3;

  void _onNavTap(int index) {
    if (index == _navIndex) return;

    switch (index) {
      case 0:
      // Dashboard is the root of the admin stack — pop back to it
      // rather than pushing a new instance on top.
        Navigator.of(context).popUntil((route) => route.isFirst);
        break;
      case 1:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AddPoojaScreen(embedded: false)),
        );
        break;
      case 2:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const BookingsScreen(embedded: false)),
        );
        break;
      case 4:
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const AdminProfileScreen(embedded: false)),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final content = SafeArea(
      bottom: widget.embedded,
      child: Column(
        children: [
          _buildHeader(),
          _buildSectionToggle(),
          Expanded(
            child: _sectionIndex == 0
                ? _buildGallerySection()
                : _buildEventsSection(),
          ),
        ],
      ),
    );

    if (widget.embedded) {
      return content;
    }

    return Scaffold(
      body: content,
      bottomNavigationBar: AdminBottomNavBar(
        selectedIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.maroon, Color(0xFF4A0E0E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Row(
        children: [
          if (!widget.embedded)
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 18),
            ),
          if (!widget.embedded) const SizedBox(width: 14),
          const Expanded(
            child: Text(
              'Gallery',
              style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white70, width: 1.2),
            ),
            child: const Icon(Icons.notifications_none, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionToggle() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          _toggleButton(icon: Icons.grid_view_rounded, index: 0),
          const SizedBox(width: 10),
          _toggleButton(icon: Icons.auto_awesome, index: 1),
        ],
      ),
    );
  }

  Widget _toggleButton({required IconData icon, required int index}) {
    final selected = _sectionIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _sectionIndex = index),
      child: Container(
        width: 48,
        height: 42,
        decoration: BoxDecoration(
          color: selected ? AppColors.maroon : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: selected ? null : Border.all(color: Colors.black12),
        ),
        child: Icon(icon, color: selected ? Colors.white : AppColors.maroon, size: 20),
      ),
    );
  }

  Widget _buildGallerySection() {
    return Column(
      children: [
        _buildMediaTabs(),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 20),
            child: _buildMediaGrid(),
          ),
        ),
        _buildActionButton(
          label: '+ Upload Media',
          onTap: () async {
            final saved = await Navigator.push<bool>(
              context,
              MaterialPageRoute(builder: (_) => const AddMediaPage()),
            );
            if (saved == true && mounted) setState(() {});
          },
        ),
      ],
    );
  }

  Widget _buildEventsSection() {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('events')
                .orderBy('startDate', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snapshot.data!.docs;
              if (docs.isEmpty) {
                return const Center(
                  child: Text('No events yet.', style: TextStyle(color: Colors.grey)),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                itemCount: docs.length,
                itemBuilder: (context, i) {
                  final data = docs[i].data() as Map<String, dynamic>;
                  final title = (data['title'] as String?) ?? 'Untitled event';
                  final start = (data['startDate'] as Timestamp?)?.toDate();
                  final end = (data['endDate'] as Timestamp?)?.toDate();
                  final banner = data['bannerUrl'] as String?;

                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    clipBehavior: Clip.antiAlias,
                    child: ListTile(
                      leading: (banner != null && banner.isNotEmpty)
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(banner, width: 48, height: 48, fit: BoxFit.cover),
                      )
                          : Container(
                        width: 48,
                        height: 48,
                        color: AppColors.creamCard,
                        child: Icon(Icons.event, color: AppColors.maroon),
                      ),
                      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                      subtitle: (start != null && end != null)
                          ? Text('${_shortDate(start)} - ${_shortDate(end)}')
                          : null,
                    ),
                  );
                },
              );
            },
          ),
        ),
        _buildActionButton(
          label: '+ Add Event',
          onTap: () async {
            final saved = await Navigator.push<bool>(
              context,
              MaterialPageRoute(builder: (_) => const AddEventPage()),
            );
            if (saved == true && mounted) setState(() {});
          },
        ),
      ],
    );
  }

  String _shortDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${date.day} ${months[date.month - 1]}';
  }

  Widget _buildMediaTabs() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: Row(
        children: [
          _mediaTabButton('Images', 0),
          const SizedBox(width: 24),
          _mediaTabButton('Videos', 1),
        ],
      ),
    );
  }

  Widget _mediaTabButton(String label, int index) {
    final selected = _mediaTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _mediaTabIndex = index),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: selected ? AppColors.maroon : Colors.grey,
            ),
          ),
          const SizedBox(height: 6),
          Container(height: 2, width: 50, color: selected ? AppColors.maroon : Colors.transparent),
        ],
      ),
    );
  }

  Widget _buildMediaGrid() {
    final type = _mediaTabIndex == 0 ? 'photo' : 'video';

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('gallery')
          .where('type', isEqualTo: type)
          .orderBy('order')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final docs = snapshot.data!.docs;
        if (docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 40),
            child: Center(child: Text('No media yet.', style: TextStyle(color: Colors.grey))),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.15,
            ),
            itemBuilder: (context, i) {
              final data = docs[i].data() as Map<String, dynamic>;
              final url = type == 'video'
                  ? ((data['thumbnailUrl'] as String?) ?? (data['imageUrl'] as String?) ?? '')
                  : ((data['imageUrl'] as String?) ?? '');

              return ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: url.isNotEmpty
                    ? Image.network(
                  url,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(color: AppColors.creamCard),
                )
                    : Container(color: AppColors.creamCard),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildActionButton({required String label, required VoidCallback onTap}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.maroon,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            elevation: 0,
          ),
          child: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700)),
        ),
      ),
    );
  }
}