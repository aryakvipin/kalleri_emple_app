// import 'package:flutter/material.dart';
// import 'package:kalleri_emple_app/screen/admin/profile_screen.dart';
// import '../../utils/AppBackground.dart';
// import '../ProfilePage.dart';
// import 'add_pooja_screen.dart';
// import 'bookings_screen.dart';
// import 'dashboard_screen.dart';
// import 'gallery_screen.dart';
// import 'widgets/bottom_nav.dart';
//
//
// void main() {
//   runApp(const TempleAdminApp());
// }
//
// class TempleAdminApp extends StatelessWidget {
//   const TempleAdminApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Temple Admin',
//       debugShowCheckedModeBanner: false,
//       theme: AppTheme.theme,
//       home: const RootShell(),
//     );
//   }
// }
//
// /// Hosts the 5 primary tabs (Home / Pooja / Booking / Gallery / Profile)
// /// behind the shared bottom navigation bar, matching the screenshots.
// class RootShell extends StatefulWidget {
//   const RootShell({super.key});
//
//   @override
//   State<RootShell> createState() => _RootShellState();
// }
//
// class _RootShellState extends State<RootShell> {
//   int _index = 0;
//
//   final List<Widget> _tabs = [
//     const DashboardScreen(),
//     const AddPoojaScreen(embedded: true),
//     const BookingsScreen(embedded: true),
//     GalleryScreenpage(embedded: true),
//   const  AdminProfileScreen(embedded: true),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.cream,
//       body: SafeArea(
//         bottom: false,
//         child: IndexedStack(index: _index, children: _tabs),
//       ),
//       bottomNavigationBar: AppBottomNav(
//         currentIndex: _index,
//         onTap: (i) => setState(() => _index = i),
//       ),
//     );
//   }
// }
