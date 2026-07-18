// import 'package:flutter/material.dart';
//
// import '../../utils/AppBackground.dart';
//
// class SettingsScreen extends StatelessWidget {
//   const SettingsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cream,
//       appBar: AppBar(title: const Text('Devotee Settings')),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(20),
//               children: [
//                 _SettingsTile(
//                   icon: Icons.settings_outlined,
//                   label: 'General Settings',
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 12),
//                 _SettingsTile(
//                   icon: Icons.payments_outlined,
//                   label: 'Payment Settings',
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 12),
//                 _SettingsTile(
//                   icon: Icons.temple_hindu_outlined,
//                   label: 'Pooja Settings',
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 12),
//                 _SettingsTile(
//                   icon: Icons.notifications_outlined,
//                   label: 'Notification Settings',
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 20),
//                 Row(
//                   children: [
//                     Expanded(child: Divider(color: Colors.grey.shade300)),
//                     const Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 8),
//                       child: Icon(Icons.star_border,
//                           size: 16, color: AppColors.textGrey),
//                     ),
//                     Expanded(child: Divider(color: Colors.grey.shade300)),
//                   ],
//                 ),
//                 const SizedBox(height: 20),
//                 _SettingsTile(
//                   icon: Icons.description_outlined,
//                   label: 'Privacy Policy',
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 12),
//                 _SettingsTile(
//                   icon: Icons.gavel_outlined,
//                   label: 'Terms & Conditions',
//                   onTap: () {},
//                 ),
//                 const SizedBox(height: 24),
//                 Center(
//                   child: Text(
//                     'App Version v1.0.0',
//                     style: TextStyle(
//                         fontSize: 12, color: AppColors.textGrey),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: ElevatedButton.icon(
//               onPressed: () {},
//               icon: const Icon(Icons.logout, size: 18),
//               label: const Text('Logout'),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class _SettingsTile extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final VoidCallback onTap;
//
//   const _SettingsTile({
//     required this.icon,
//     required this.label,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//         decoration: BoxDecoration(
//           color: AppColors.creamCard,
//           borderRadius: BorderRadius.circular(14),
//         ),
//         child: Row(
//           children: [
//             Container(
//               padding: const EdgeInsets.all(8),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Icon(icon, size: 18, color: AppColors.maroon),
//             ),
//             const SizedBox(width: 14),
//             Expanded(
//               child: Text(label,
//                   style: const TextStyle(fontWeight: FontWeight.w600)),
//             ),
//             const Icon(Icons.chevron_right, color: AppColors.textGrey),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/AppBackground.dart';
import '../loginscreen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _logout(BuildContext context) async {
    // Simple confirm dialog so a stray tap doesn't sign the admin out
    // by accident.
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('You\'ll need to sign in again to access the admin dashboard.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Log out'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await FirebaseAuth.instance.signOut();

    if (!context.mounted) return;

    // Clear the entire admin nav stack (Dashboard, Gallery, etc.) so
    // pressing back after logging out doesn't land the admin back on
    // a dashboard they're no longer authenticated for.
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) =>  LoginPage()),
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AppBar(title: const Text('Devotee Settings')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _SettingsTile(
                  icon: Icons.settings_outlined,
                  label: 'General Settings',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.payments_outlined,
                  label: 'Payment Settings',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.temple_hindu_outlined,
                  label: 'Pooja Settings',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.notifications_outlined,
                  label: 'Notification Settings',
                  onTap: () {},
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(Icons.star_border,
                          size: 16, color: AppColors.textGrey),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 20),
                _SettingsTile(
                  icon: Icons.description_outlined,
                  label: 'Privacy Policy',
                  onTap: () {},
                ),
                const SizedBox(height: 12),
                _SettingsTile(
                  icon: Icons.gavel_outlined,
                  label: 'Terms & Conditions',
                  onTap: () {},
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    'App Version v1.0.0',
                    style: TextStyle(
                        fontSize: 12, color: AppColors.textGrey),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton.icon(
              onPressed: () => _logout(context),
              icon: const Icon(Icons.logout, size: 18),
              label: const Text('Logout'),
            ),
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

  const _SettingsTile({
    required this.icon,
    required this.label,
    required this.onTap,
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
            const Icon(Icons.chevron_right, color: AppColors.textGrey),
          ],
        ),
      ),
    );
  }
}
