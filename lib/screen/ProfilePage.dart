import 'package:flutter/material.dart';
import 'My Bookings page.dart';
import 'profile_header.dart'; // <- your ProfileHeader widget (adjust path to match your project, e.g. '../widgets/profile_header.dart')

/// ============================================================
/// TEMPLE APP - PROFILE SCREEN
/// ============================================================
/// Uses your existing `ProfileHeader` widget for the top section
/// (maroon gradient, back arrow, title, notification bell, avatar,
/// name/subtitle, quote card), plus:
///  - "My Temple Journey" stats card (Poojas / Donations)
///  - "My Bookings" / "Donations" quick action buttons
///  - "Daily Darshan" banner
///  - Settings-style list (Notifications, Help & Support, Logout)
///  - Bottom navigation bar (Home, Pooja, Booking, Gallery, Profile)
///
/// Drop this file into your `lib/` folder and use `ProfileScreen`
/// as a route. The bottom nav calls `onNavTap(index)` so you can
/// plug it into your existing navigation/routing logic (e.g. to
/// take the user back Home when index == 0).
///
/// NOTE: this file defines its own `AppProfileColors` (not `AppColors`)
/// so it doesn't collide with the `AppColors` class already defined in
/// your `main.dart` that `ProfileHeader` relies on. Feel free to delete
/// `AppProfileColors` below and reference your real `AppColors` instead,
/// once you confirm it has matching fields (gold, textMuted, etc).
/// ============================================================

// ---- Colors used by the sections below the header. ----
// Your project's `AppColors` (from main.dart) already provides
// `maroon`, `maroonDark`, and `textDark` — reuse those where you can,
// this class just fills in the rest so this file compiles standalone.
class AppProfileColors {
  static const maroonDark = Color(0xFF3D0A12);
  static const maroonMid = Color(0xFF6E1420);
  static const maroonLight = Color(0xFFB5202E);
  static const gold = Color(0xFFE0A63A);
  static const cardBg = Color(0xFFFFFFFF);
  static const pageBg = Color(0xFFF7F3F0);
  static const textDark = Color(0xFF2A1B1B);
  static const textMuted = Color(0xFF8C7A78);
  static const logoutRed = Color(0xFFC0392B);
}

class ProfileScreen extends StatefulWidget {
  /// Called whenever a bottom-nav item is tapped, with its index:
  /// 0 = Home, 1 = Pooja, 2 = Booking, 3 = Gallery, 4 = Profile.
  /// Wire this to your existing navigation (e.g. Navigator.pushReplacement
  /// to the Home screen when index == 0).
  final ValueChanged<int>? onNavTap;

  final String userName;
  final String blessingQuote;
  final String avatarUrl;
  final int poojaCount;
  final String donationsAmount;

  const ProfileScreen({
    super.key,
    this.onNavTap,
    this.userName = 'Devotee Thiruvathira',
    this.blessingQuote = '"May Lord Kurichathan bless your path."',
    this.avatarUrl =
    'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?w=200',
    this.poojaCount = 24,
    this.donationsAmount = '₹15.2k',
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Profile tab is active by default on this screen.
  int _currentIndex = 4;

  void _handleNavTap(int index) {
    setState(() => _currentIndex = index);
    widget.onNavTap?.call(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppProfileColors.pageBg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileHeader(
                      name: widget.userName,
                      subtitle: 'Thiruvathira',
                      quote: widget.blessingQuote,
                      avatarUrl: widget.avatarUrl,
                    ),
                    Transform.translate(
                      offset: const Offset(0, -28),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _JourneyCard(
                              poojaCount: widget.poojaCount,
                              donations: widget.donationsAmount,
                            ),
                            const SizedBox(height: 14),
                            Row(
                              children: [
                                Expanded(
                                  child: _QuickActionButton(
                                    icon: Icons.event_note_rounded,
                                    label: 'My\nBookings',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>  MyBookingsPage()),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: _QuickActionButton(
                                    icon: Icons.volunteer_activism_rounded,
                                    label: 'Donations',
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const DonationsScreen()),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            const _DailyDarshanBanner(),
                            const SizedBox(height: 18),
                            _SettingsList(),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

/// ---------------- My Temple Journey card ----------------
class _JourneyCard extends StatelessWidget {
  final int poojaCount;
  final String donations;

  const _JourneyCard({required this.poojaCount, required this.donations});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppProfileColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Temple Journey',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppProfileColors.textDark,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: _StatItem(value: '$poojaCount', label: 'Poojas'),
              ),
              Container(width: 1, height: 34, color: Colors.black12),
              Expanded(
                child: _StatItem(value: donations, label: 'Donations'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppProfileColors.maroonMid,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(fontSize: 12.5, color: AppProfileColors.textMuted),
        ),
      ],
    );
  }
}

/// ---------------- Quick action buttons ----------------
class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppProfileColors.cardBg,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppProfileColors.maroonMid, size: 24),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w500,
                color: AppProfileColors.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ---------------- Daily Darshan banner ----------------
class _DailyDarshanBanner extends StatelessWidget {
  const _DailyDarshanBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [AppProfileColors.maroonDark, AppProfileColors.maroonLight],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Daily Darshan',
                  style: TextStyle(
                    color: AppProfileColors.gold,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  "Today's Blessing",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Your devotion brings peace',
                  style: TextStyle(color: Colors.white70, fontSize: 11.5),
                ),
              ],
            ),
          ),
          Icon(Icons.temple_hindu_rounded,
              color: Colors.white.withOpacity(0.85), size: 34),
        ],
      ),
    );
  }
}

/// ---------------- Settings list ----------------
class _SettingsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppProfileColors.cardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _SettingsTile(
            icon: Icons.edit,
            label: 'Edit Profile',
            onTap: () {},
          ),
          _SettingsTile(
            icon: Icons.notifications_none_rounded,
            label: 'Notifications',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _SettingsTile(
            icon: Icons.help_outline_rounded,
            label: 'Help & Support',
            onTap: () {},
          ),
          const Divider(height: 1, indent: 16, endIndent: 16),
          _SettingsTile(
            icon: Icons.logout_rounded,
            label: 'Logout',
            onTap: () {},
            isDestructive: true,
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? AppProfileColors.logoutRed : AppProfileColors.textDark;
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: color, size: 21),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
          color: color,
        ),
      ),
      trailing: isDestructive
          ? null
          : const Icon(Icons.chevron_right_rounded,
          color: AppProfileColors.textMuted),
    );
  }
}

/// ---------------- Bottom Navigation Bar ----------------
/// Reusable across the app: pass `currentIndex` and `onTap`.
/// Index 0 (Home) should route back to your existing Home screen.
