// import 'package:flutter/material.dart';
// import 'package:kalleri_emple_app/utils/AppBackground.dart';
// import 'BookingDetailsPage.dart';
// import 'My Bookings page.dart';
// import 'Pooja Details page.dart';
// import 'ProfilePage.dart';
// import 'gallery_page.dart' hide AppColors;
// import 'homecontent.dart' hide AppColors;
//
// class UserHomePage extends StatefulWidget {
//   final String username;
//   const UserHomePage({super.key, required this.username});
//   @override
//   State<UserHomePage> createState() => _UserHomePageState();
// }
//
// class _UserHomePageState extends State<UserHomePage> {
//   int selectedIndex = 0;
//
//   final List<Widget> pages = [
//     const HomeContentPage(),
//     const PoojaDetailsPage(),
//     MyBookingsPage(),
//     const GalleryScreen(),
//     ProfileScreen (),];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//
//       body: IndexedStack(
//         index: selectedIndex,
//         children: pages,
//       ),
//
//       bottomNavigationBar: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(20),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.18),
//               blurRadius: 12,
//               offset: const Offset(0, -2),
//             ),
//           ],
//         ),
//         child: BottomNavigationBar(
//           currentIndex: selectedIndex,
//           onTap: (index) {
//             setState(() {
//               selectedIndex = index;
//             });
//           },
//           type: BottomNavigationBarType.fixed,
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           selectedItemColor: AppColors.maroon,
//           unselectedItemColor: AppColors.textDark,
//           selectedFontSize: 9,
//           unselectedFontSize: 9,
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home_outlined),
//               activeIcon: Icon(Icons.home),
//               label: "Home",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.local_fire_department_outlined),
//               label: "Pooja",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.calendar_month_outlined),
//               label: "Booking",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.image_outlined),
//               label: "Gallery",
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.person_outline),
//               label: "Profile",
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kalleri_emple_app/utils/AppBackground.dart';
import 'BookingDetailsPage.dart';
import 'My Bookings page.dart';
import 'Pooja Details page.dart';

import 'ProfilePage.dart' hide AppColors;
import 'gallery_page.dart' hide AppColors;
import 'homecontent.dart';
import 'nav_controller.dart';

class UserHomePage extends StatefulWidget {
  final String username;
  const UserHomePage({super.key, required this.username});
  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  // Shared controller instead of a local `int selectedIndex` — this is
  // what lets other pages (e.g. the "Book New Pooja" button on
  // MyBookingsPage) switch tabs without pushing a new route.
  final NavController navController = Get.put(NavController());

  final List<Widget> pages = [
     HomeContentPage(),
    const PoojaDetailsPage(),
    MyBookingsPage(),
     GalleryScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: Obx(
            () => IndexedStack(
          index: navController.selectedIndex.value,
          children: pages,
        ),
      ),

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(.18),
              blurRadius: 12,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: Obx(
              () => BottomNavigationBar(
            currentIndex: navController.selectedIndex.value,
            onTap: navController.changeIndex,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            backgroundColor: Colors.transparent,
            selectedItemColor: AppColors.maroon,
            unselectedItemColor: AppColors.textDark,
            selectedFontSize: 9,
            unselectedFontSize: 9,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                activeIcon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.local_fire_department_outlined),
                label: "Pooja",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month_outlined),
                label: "Booking",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image_outlined),
                label: "Gallery",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: "Profile",
              ),
            ],
          ),
        ),
      ),
    );
  }
}