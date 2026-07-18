import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'nav_controller.dart';

class MyBookingsPage extends StatelessWidget {

  MyBookingsPage({super.key});

  String formatDate(DateTime date) {
    const weekdays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun",
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
    ];
    return "${date.day.toString().padLeft(2, '0')} "
        "${months[date.month - 1]} ${date.year}, "
        "${weekdays[date.weekday - 1]}";
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: const Color(0xffFAF8F3),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(
                  left: 18, right: 18, top: 20, bottom: 28),
              decoration: const BoxDecoration(
                color: Color(0xff6B1111),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.arrow_back_ios,
                          color: Colors.white, size: 18),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "My Bookings",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 5),
                            Text(
                              "SREE KALLERI KUTTICHATHAN KSHETHRAM",
                              style: TextStyle(
                                  color: Colors.amber,
                                  fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 42,
                        width: 42,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            shape: BoxShape.circle),
                        child: const Icon(Icons.notifications_none,
                            color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
            ),

            // BOOKINGS LIST — pulled live from the `booking` collection,
            // scoped to this user's email.
            //
            // NOTE: sorting by `createdAt` is done client-side (below)
            // instead of using Firestore's .orderBy(), because combining
            // .where('userEmail', ...) with .orderBy('createdAt', ...)
            // requires a composite index in Firestore. Sorting here in
            // Dart avoids needing to create that index manually.
            Expanded(
              child: user == null
                  ? const Center(
                child: Text("Please log in to view your bookings."),
              )
                  : StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('booking')
                    .where('userEmail', isEqualTo: user.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          "Could not load your bookings.\n${snapshot.error}",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  }

                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final docs = snapshot.data!.docs.toList();

                  // Sort newest-first by createdAt, client-side.
                  docs.sort((a, b) {
                    final aTs =
                    (a.data() as Map<String, dynamic>)['createdAt']
                    as Timestamp?;
                    final bTs =
                    (b.data() as Map<String, dynamic>)['createdAt']
                    as Timestamp?;

                    if (aTs == null && bTs == null) return 0;
                    if (aTs == null) return 1;
                    if (bTs == null) return -1;

                    return bTs.compareTo(aTs);
                  });

                  return ListView.builder(
                    padding: const EdgeInsets.all(16),
                    // +1 slot for the "Book New Pooja" tile, plus one
                    // more when there are no bookings so the empty
                    // message gets its own slot above that tile.
                    itemCount: docs.length + (docs.isEmpty ? 2 : 1),
                    itemBuilder: (context, index) {
                      if (docs.isEmpty && index == 0) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Center(
                            child: Text(
                              "No bookings yet.",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      }

                      // Last item is always the "Book New Pooja" tile.
                      if (index ==
                          docs.length + (docs.isEmpty ? 1 : 0)) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.amber.shade700,
                                style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                    Icons.volunteer_activism_outlined,
                                    color: Colors.brown),
                                const SizedBox(width: 8),
                                TextButton(
                                  onPressed: () {
                                    // Switch to the "Pooja" tab (index 1)
                                    // inside the existing UserHomePage
                                    // shell instead of pushing a new
                                    // route — this is what keeps the
                                    // bottom nav bar visible.
                                    Get.find<NavController>()
                                        .changeIndex(1);
                                  },
                                  child: const Text(
                                    "Book New Pooja",
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }

                      final data =
                      docs[index].data() as Map<String, dynamic>;

                      final title =
                          (data['poojaName'] as String?) ?? "Pooja";
                      final time =
                          (data['bookingTime'] as String?) ?? "-";
                      final totalAmount = data['totalAmount'];
                      final price = totalAmount != null
                          ? "₹$totalAmount"
                          : "-";
                      final bookingDateTs =
                      data['bookingDate'] as Timestamp?;
                      final date = bookingDateTs != null
                          ? formatDate(bookingDateTs.toDate())
                          : "-";
                      final status =
                      ((data['status'] as String?) ?? 'pending')
                          .toUpperCase();

                      return Card(
                        elevation: 2,
                        margin: const EdgeInsets.only(bottom: 15),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(18),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                  BorderRadius.circular(10),
                                  child: Image.asset(
                                    "assets/images/1.png",
                                    width: 85,
                                    height: 85,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) =>
                                        Container(
                                          width: 85,
                                          height: 85,
                                          color: Colors.brown
                                              .withOpacity(0.08),
                                          child: const Icon(
                                              Icons.temple_hindu,
                                              color: Colors.brown),
                                        ),
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              title,
                                              style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          Text(
                                            price,
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                fontSize: 18),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.calendar_today,
                                              size: 16,
                                              color: Colors.grey),
                                          const SizedBox(width: 5),
                                          Text(date),
                                        ],
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.access_time,
                                              size: 16,
                                              color: Colors.grey),
                                          const SizedBox(width: 5),
                                          Text(time),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets
                                                .symmetric(
                                                horizontal: 12,
                                                vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors
                                                    .amber.shade100,
                                                borderRadius:
                                                BorderRadius
                                                    .circular(20)),
                                            child: Text(
                                              status,
                                              style: const TextStyle(
                                                  color: Colors.brown,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                          ),
                                          const Spacer(),
                                          const Icon(
                                            Icons.chevron_right,
                                            color: Colors.grey,
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}