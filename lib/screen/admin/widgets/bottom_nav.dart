import 'package:flutter/material.dart';

import '../../../utils/AppBackground.dart';

/// Reusable bottom nav bar for admin pages: Home, Pooja, Booking,
/// Gallery, Profile.
///
/// This is a standalone widget (not tied to any one screen), so any admin
/// page can drop it in as its own `bottomNavigationBar` — just pass the
/// index that page represents as [selectedIndex] and handle navigation
/// in [onTap].
///
/// Example usage in a page's Scaffold:
/// ```dart
/// bottomNavigationBar: AdminBottomNavBar(
///   selectedIndex: 0, // 0 = Home, 1 = Pooja, 2 = Booking, 3 = Gallery, 4 = Profile
///   onTap: (index) {
///     // navigate to the screen for that index
///   },
/// ),
/// ```
class AdminBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const AdminBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.home_rounded, label: 'Home'),
    (icon: Icons.local_fire_department_rounded, label: 'Pooja'),
    (icon: Icons.calendar_month_rounded, label: 'Booking'),
    (icon: Icons.photo_library_rounded, label: 'Gallery'),
    (icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 12),
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.creamCard,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_items.length, (index) {
            final item = _items[index];
            final selected = index == selectedIndex;

            return _AdminNavItem(
              icon: item.icon,
              label: item.label,
              selected: selected,
              onTap: () => onTap(index),
            );
          }),
        ),
      ),
    );
  }
}

class _AdminNavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _AdminNavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: selected ? AppColors.maroon : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                size: 20,
                color: selected ? Colors.white : AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: selected ? AppColors.maroon : AppColors.textGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}