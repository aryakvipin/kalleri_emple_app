import 'package:flutter/material.dart';
import '../../utils/AppBackground.dart';
import 'settings_screen.dart';
import 'change_password_screen.dart';

class AdminProfileScreen extends StatelessWidget {
  final bool embedded;
  const AdminProfileScreen({super.key, this.embedded = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(
        automaticallyImplyLeading: !embedded,
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 28),
              decoration: BoxDecoration(
                color: AppColors.creamCard,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 42,
                        backgroundColor: AppColors.maroon,
                        child: Icon(Icons.person,
                            size: 44, color: Colors.white),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: AppColors.gold,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.verified,
                              size: 16, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Admin',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'ADMINISTRATOR',
                    style: TextStyle(
                      color: AppColors.gold,
                      fontWeight: FontWeight.w700,
                      fontSize: 12,
                      letterSpacing: 0.6,
                    ),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.email_outlined,
                          size: 15, color: AppColors.textGrey),
                      SizedBox(width: 6),
                      Text('admin@kuttichathan.com',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textGrey)),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.phone_outlined,
                          size: 15, color: AppColors.textGrey),
                      SizedBox(width: 6),
                      Text('+91 98765 43210',
                          style: TextStyle(
                              fontSize: 13, color: AppColors.textGrey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            _ProfileTile(
              icon: Icons.person_outline,
              label: 'Edit Profile',
              onTap: () {},
            ),
            const SizedBox(height: 12),
            _ProfileTile(
              icon: Icons.language,
              label: 'Language',
              trailing: 'English',
              onTap: () {},
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (_) => const ChangePasswordScreen()),
                );
              },
              child: const Text('CHANGE PASSWORD'),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? trailing;
  final VoidCallback onTap;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.creamCard,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: AppColors.maroon),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(label,
                  style: const TextStyle(fontWeight: FontWeight.w600)),
            ),
            if (trailing != null)
              Text(trailing!,
                  style: TextStyle(color: AppColors.textGrey, fontSize: 13)),
            const SizedBox(width: 6),
            const Icon(Icons.chevron_right, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
