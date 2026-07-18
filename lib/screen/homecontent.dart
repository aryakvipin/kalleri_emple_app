import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'Donation screen.dart';
import 'EventContent.dart';
import 'Festival gallery section.dart';
import 'My Bookings page.dart';
import 'most_booked_section.dart';
import 'nav_controller.dart';


/// ASSUMED FIRESTORE SCHEMA — adjust field/collection names below if
/// yours differ, everything is isolated to the StreamBuilders so it's a
/// quick swap.
///
/// users/{uid}                 -> fullName
/// templeInfo/status  (single doc)
///     isOpen (bool), darshanTime (String), openTime (String),
///     closingTime (String), specialDarshan (String), address (String),
///     phone (String), email (String), facebookUrl (String),
///     instagramUrl (String), youtubeUrl (String)
/// events              (collection)
///     title (String), date (Timestamp), startTime (String),
///     endTime (String), location (String), image (String, asset path
///     or network URL)
/// upcomingPoojas      (collection)
///     name (String), malayalam (String), date (Timestamp),
///     image (String), amount (num)
/// festivals           (collection)
///     title (String), malayalamTitle (String), description (String),
///     dateRange (String), image (String), isActive (bool)
/// gallery_photos      (collection)
///     url (String), createdAt (Timestamp)
/// mostBooked/main     (single doc) -> see most_booked_section.dart
///     items (array<{title, malayalam, image, amount}>)
class HomeContentPage extends StatefulWidget {
  const HomeContentPage({super.key});

  static const Color primaryColor = Color(0xFF750B0B);
  static const Color darkRed = Color(0xFF570606);
  static const Color lightBackground = Color(0xFFFFFCFA);

  @override
  State<HomeContentPage> createState() => _HomeContentPageState();
}

class _HomeContentPageState extends State<HomeContentPage> {
  late final Future<String> _usernameFuture;

  @override
  void initState() {
    super.initState();
    _usernameFuture = _fetchUsername();
  }

  Future<String> _fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return "Devotee";

    try {
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      final name = doc.data()?['fullName'] as String?;

      if (name != null && name.trim().isNotEmpty) {
        return name.trim();
      }

      return "Devotee";
    } catch (e) {
      return "Devotee";
    }
  }

  /// Switches the bottom-nav shell (UserHomePage) to the "Pooja" tab
  /// (index 1) instead of pushing a new route, so the bottom nav bar
  /// stays visible. Used by every "Book" / "Book Now" / "Pooja Booking"
  /// action on this page.
  void _goToPoojaTab() {
    Get.find<NavController>().changeIndex(1);
  }

  /// Switches the bottom-nav shell to the "Gallery" tab. Update the
  /// index below if your NavController orders tabs differently.
  void _goToGalleryTab() {
    Get.find<NavController>().changeIndex(2);
  }

  void _goToEvents() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const EventContent()),
    );
  }

  void _goToDonations() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const Donationpage()),
    );
  }

  /// Opens the full "Most Booked" list — see most_booked_page.dart.
  void _goToMostBooked() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) =>  MyBookingsPage()),
    );
  }

  String _formatEventDate(DateTime date) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return "${months[date.month - 1]} ${date.day}, ${date.year} - "
        "${_formatTime(date)}";
  }

  String _formatTime(DateTime date) {
    final hour24 = date.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = hour24 < 12 ? "AM" : "PM";
    return "${hour12.toString().padLeft(2, '0')}:$minute $period";
  }

  String _formatPrice(dynamic amount) {
    if (amount is num) return "₹${amount.toInt()}";
    if (amount is String) return amount;
    return "-";
  }

  /// Loads an image from a network URL if the string looks like one,
  /// otherwise treats it as a bundled asset path.
  Widget _remoteImage(
      String path, {
        required double width,
        required double height,
        BorderRadius? radius,
      }) {
    final image = (path.startsWith('http'))
        ? Image.network(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _imageFallback(width, height),
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _imageFallback(width, height, loading: true);
      },
    )
        : Image.asset(
      path,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => _imageFallback(width, height),
    );

    if (radius == null) return image;
    return ClipRRect(borderRadius: radius, child: image);
  }

  Widget _imageFallback(double width, double height, {bool loading = false}) {
    return Container(
      width: width,
      height: height,
      color: HomeContentPage.primaryColor.withOpacity(.08),
      alignment: Alignment.center,
      child: loading
          ? SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: HomeContentPage.primaryColor,
        ),
      )
          : Icon(Icons.temple_hindu, color: HomeContentPage.primaryColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 35),
        child: Column(
          children: [
            _header(),
            Transform.translate(
              offset: const Offset(0, -25),
              child: Column(
                children: [
                  _templeOpenCard(),
                  const SizedBox(height: 8),
                  _quickAccess(),
                  const SizedBox(height: 17),
                  _todayEvents(),
                  const SizedBox(height: 17),
                  _upcomingPooja(),
                  const SizedBox(height: 17),
                  _templeTimings(),
                  const SizedBox(height: 22),
                  MostBookedSection(),
                  const SizedBox(height: 22),
                  FestivalGallerySection(
                    onGalleryViewAll: _goToGalleryTab,
                    onBookPooja: _goToPoojaTab,
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return SizedBox(
      height: 190,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "assets/images/Group 64.png",
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
              color: HomeContentPage.primaryColor,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.20),
                  Colors.black.withOpacity(.05),
                ],
              ),
            ),
          ),
          Positioned(
            top: 24,
            left: 16,
            child: FutureBuilder<String>(
              future: _usernameFuture,
              builder: (context, snapshot) {
                final name = snapshot.data ?? "Devotee";

                return RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      color: Colors.white,
                      height: 1.05,
                    ),
                    children: [
                      const TextSpan(
                        text: "Welcome 🙏\n",
                        style: TextStyle(fontSize: 16),
                      ),
                      TextSpan(
                        text: name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 22,
            right: 16,
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white),
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Live open/closed status + darshan hours from
  /// templeInfo/status. Falls back to "Temple Open" copy while loading
  /// or if the doc is missing, so the layout never breaks.
  Widget _templeOpenCard() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('templeInfo')
          .doc('status')
          .snapshots(),
      builder: (context, snapshot) {
        final data = snapshot.data?.data() as Map<String, dynamic>?;

        final isOpen = (data?['isOpen'] as bool?) ?? true;
        final darshanTime =
            (data?['darshanTime'] as String?) ?? "3:30 PM – 9:00 PM";

        return Container(
          height: 61,
          margin: const EdgeInsets.symmetric(horizontal: 18),
          padding: const EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
            color: HomeContentPage.primaryColor,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 5,
                backgroundColor: isOpen ? Colors.green : Colors.grey,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isOpen ? "Temple Open" : "Temple Closed",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "Darshan $darshanTime",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                color: Colors.white,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _quickAccess() {
    final items = [
      [Icons.temple_hindu_outlined, "Pooja Booking", _goToPoojaTab],
      [Icons.volunteer_activism_outlined, "Donations", _goToDonations],
      [Icons.calendar_month_outlined, "Events", _goToEvents],
      [Icons.photo_library_outlined, "Gallery", _goToGalleryTab],
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("Quick Access"),
          const SizedBox(height: 8),
          Row(
            children: List.generate(
              items.length,
                  (index) {
                final onTap = items[index][2] as void Function();
                return Expanded(
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(10),
                    child: Column(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: HomeContentPage.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            items[index][0] as IconData,
                            color: Colors.white,
                            size: 19,
                          ),
                        ),
                        const SizedBox(height: 4),
                        FittedBox(
                          child: Text(
                            items[index][1] as String,
                            style: const TextStyle(fontSize: 9),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Shows the next event scheduled for today, from the `events`
  /// collection. Hides the section entirely if there's nothing today.
  Widget _todayEvents() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('events')
            .where('date', isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
            .where('date', isLessThan: Timestamp.fromDate(endOfDay))
            .orderBy('date')
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const SizedBox.shrink();
          }

          final data =
          snapshot.data!.docs.first.data() as Map<String, dynamic>;
          final title = (data['title'] as String?) ?? "Event";
          final startTime = (data['startTime'] as String?) ?? "";
          final endTime = (data['endTime'] as String?) ?? "";
          final location = (data['location'] as String?) ?? "";
          final image = (data['image'] as String?) ??
              "assets/images/kalleri_02 1.png";
          final dateTs = data['date'] as Timestamp?;
          final day = dateTs?.toDate().day.toString() ?? "-";
          final month = dateTs != null
              ? [
            "JAN", "FEB", "MAR", "APR", "MAY", "JUN",
            "JUL", "AUG", "SEP", "OCT", "NOV", "DEC",
          ][dateTs.toDate().month - 1]
              : "";

          return Column(
            children: [
              _sectionHeader("Today's Events", onViewAll: _goToEvents),
              const SizedBox(height: 6),
              Container(
                height: 87,
                padding: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: HomeContentPage.darkRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 43,
                      height: 62,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(7),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            month,
                            style: const TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            day,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 5),
                          if (startTime.isNotEmpty)
                            Row(
                              children: [
                                const Icon(
                                  Icons.access_time,
                                  color: Colors.white70,
                                  size: 11,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  "$startTime - $endTime",
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          if (location.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on_outlined,
                                  color: Colors.white70,
                                  size: 11,
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  location,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 9,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),
                    _remoteImage(
                      image,
                      width: 72,
                      height: 72,
                      radius: BorderRadius.circular(7),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Next 2 scheduled poojas (date >= now) from `upcomingPoojas`,
  /// soonest first.
  Widget _upcomingPooja() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('upcomingPoojas')
            .where('date', isGreaterThanOrEqualTo: Timestamp.now())
            .orderBy('date')
            .limit(2)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox.shrink();
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Column(
              children: [
                _sectionHeader("Upcoming Pooja", onViewAll: _goToPoojaTab),
                const SizedBox(height: 7),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "No upcoming poojas scheduled.",
                    style: TextStyle(color: Colors.grey, fontSize: 11),
                  ),
                ),
              ],
            );
          }

          return Column(
            children: [
              _sectionHeader("Upcoming Pooja", onViewAll: _goToPoojaTab),
              const SizedBox(height: 7),
              for (int i = 0; i < docs.length; i++) ...[
                if (i > 0) const SizedBox(height: 10),
                Builder(builder: (context) {
                  final data = docs[i].data() as Map<String, dynamic>;
                  final dateTs = data['date'] as Timestamp?;

                  return _poojaItem(
                    image: (data['image'] as String?) ??
                        "assets/images/img11.png",
                    title: (data['name'] as String?) ?? "Pooja",
                    malayalamTitle: (data['malayalam'] as String?) ?? "",
                    date: dateTs != null
                        ? _formatEventDate(dateTs.toDate())
                        : "-",
                    price: _formatPrice(data['amount']),
                  );
                }),
              ],
            ],
          );
        },
      ),
    );
  }

  Widget _poojaItem({
    required String image,
    required String title,
    required String malayalamTitle,
    required String date,
    required String price,
  }) {
    return SizedBox(
      height: 69,
      child: Row(
        children: [
          _remoteImage(
            image,
            width: 78,
            height: 67,
            radius: BorderRadius.circular(7),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (malayalamTitle.isNotEmpty)
                  Text(
                    malayalamTitle,
                    style: const TextStyle(fontSize: 10),
                  ),
                const SizedBox(height: 3),
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 8,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 48,
            height: 22,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                elevation: 0,
                padding: EdgeInsets.zero,
                backgroundColor: HomeContentPage.primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: _goToPoojaTab,
              child: const Text(
                "BOOK",
                style: TextStyle(fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Open/closing/special-darshan hours, from the same
  /// templeInfo/status doc used by _templeOpenCard.
  Widget _templeTimings() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('templeInfo')
            .doc('status')
            .snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data?.data() as Map<String, dynamic>?;

          final openTime = (data?['openTime'] as String?) ?? "04:30 AM";
          final closingTime =
              (data?['closingTime'] as String?) ?? "09:30 PM";
          final specialDarshan =
              (data?['specialDarshan'] as String?) ?? "05:00-08:00\nAM";

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionTitle("Temple Timings"),
              const SizedBox(height: 9),
              Row(
                children: [
                  Expanded(
                    child: _TimingCard(
                      title: "OPEN TIME",
                      time: openTime,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: _TimingCard(
                      title: "CLOSING TIME",
                      time: closingTime,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Expanded(
                    child: _TimingCard(
                      title: "SPECIAL DARSHAN",
                      time: specialDarshan,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  /// Address / contact / social section at the very bottom of Home.
  /// Reads from the same templeInfo/status doc used elsewhere — add
  /// `address`, `phone`, `email`, `facebookUrl`, `instagramUrl`, and
  /// `youtubeUrl` fields there if they're not already present. Each
  /// row/icon only shows up if its field is non-empty, so nothing dead
  /// or blank gets rendered.
  // Widget _footer() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 14),
  //     child: StreamBuilder<DocumentSnapshot>(
  //       stream: FirebaseFirestore.instance
  //           .collection('templeInfo')
  //           .doc('status')
  //           .snapshots(),
  //       builder: (context, snapshot) {
  //         final data = snapshot.data?.data() as Map<String, dynamic>?;
  //
  //         final address = (data?['address'] as String?) ??
  //             "Sree Kalleri Kuttichathan Kshethram, Villiyappally, Vadakara, Kozhikode";
  //         final phone = (data?['phone'] as String?) ?? "";
  //         final email = (data?['email'] as String?) ?? "";
  //         final facebookUrl = (data?['facebookUrl'] as String?) ?? "";
  //         final instagramUrl = (data?['instagramUrl'] as String?) ?? "";
  //         final youtubeUrl = (data?['youtubeUrl'] as String?) ?? "";
  //
  //         return Container(
  //           width: double.infinity,
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             color: HomeContentPage.primaryColor.withOpacity(.05),
  //             borderRadius: BorderRadius.circular(14),
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               Row(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Icon(Icons.location_on_outlined,
  //                       size: 16, color: HomeContentPage.primaryColor),
  //                   const SizedBox(width: 8),
  //                   Expanded(
  //                     child: Text(
  //                       address,
  //                       style: const TextStyle(fontSize: 11, height: 1.4),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               if (phone.isNotEmpty) ...[
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.call_outlined,
  //                         size: 16, color: HomeContentPage.primaryColor),
  //                     const SizedBox(width: 8),
  //                     Text(phone, style: const TextStyle(fontSize: 11)),
  //                   ],
  //                 ),
  //               ],
  //               if (email.isNotEmpty) ...[
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   children: [
  //                     Icon(Icons.email_outlined,
  //                         size: 16, color: HomeContentPage.primaryColor),
  //                     const SizedBox(width: 8),
  //                     Text(email, style: const TextStyle(fontSize: 11)),
  //                   ],
  //                 ),
  //               ],
  //               if (facebookUrl.isNotEmpty ||
  //                   instagramUrl.isNotEmpty ||
  //                   youtubeUrl.isNotEmpty) ...[
  //                 const SizedBox(height: 14),
  //                 Row(
  //                   children: [
  //                     if (facebookUrl.isNotEmpty)
  //                       _socialIcon(Icons.facebook, facebookUrl),
  //                     if (instagramUrl.isNotEmpty) ...[
  //                       const SizedBox(width: 10),
  //                       _socialIcon(Icons.camera_alt_outlined, instagramUrl),
  //                     ],
  //                     if (youtubeUrl.isNotEmpty) ...[
  //                       const SizedBox(width: 10),
  //                       _socialIcon(Icons.play_circle_outline, youtubeUrl),
  //                     ],
  //                   ],
  //                 ),
  //               ],
  //               const SizedBox(height: 14),
  //               Center(
  //                 child: Text(
  //                   "© ${DateTime.now().year} Sree Kalleri Kuttichathan Kshethram",
  //                   style: const TextStyle(fontSize: 9, color: Colors.grey),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         );
  //       },
  //     ),
  //   );
  // }

  Widget _socialIcon(IconData icon, String url) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        // TODO: launch `url` — add the url_launcher package and call
        // launchUrl(Uri.parse(url)) here if it isn't wired up already.
      },
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: HomeContentPage.primaryColor,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: HomeContentPage.primaryColor,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
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
              color: HomeContentPage.primaryColor,
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

class _TimingCard extends StatelessWidget {
  final String title;
  final String time;

  const _TimingCard({
    required this.title,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 78,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.05),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.access_time,
            color: HomeContentPage.primaryColor,
            size: 14,
          ),
          const SizedBox(height: 5),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 8,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            time,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: HomeContentPage.primaryColor,
              fontSize: 9,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}