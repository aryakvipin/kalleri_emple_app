
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import 'BookingDetailsPage.dart';
//
// class PoojaDetailsPage extends StatefulWidget {
//   const PoojaDetailsPage({super.key});
//
//   @override
//   State<PoojaDetailsPage> createState() => _PoojaDetailsPageState();
// }
//
// class _PoojaDetailsPageState extends State<PoojaDetailsPage> {
//   bool showMore = false;
//   String searchQuery = "";
//
//   final TextEditingController searchController = TextEditingController();
//
//   final Color brown = const Color(0xFF713C3A);
//   final Color darkBrown = const Color(0xFF4E2928);
//   final Color lightBackground = const Color(0xFFF8F5F1);
//
//   @override
//   void dispose() {
//     searchController.dispose();
//     super.dispose();
//   }
//
//   /// Formats a Firestore price value (num or String) into a display
//   /// string like "₹12,000". If it's already a String (e.g. "₹12,000"),
//   /// it's used as-is.
//   String _formatPrice(dynamic price) {
//     if (price is String) return price;
//
//     if (price is num) {
//       final intPart = price.toInt();
//       final str = intPart.toString();
//       final buffer = StringBuffer();
//       final length = str.length;
//
//       for (int i = 0; i < length; i++) {
//         final posFromEnd = length - i;
//         buffer.write(str[i]);
//         if (posFromEnd > 3 && (posFromEnd - 3) % 2 == 0) {
//           buffer.write(',');
//         }
//       }
//
//       return "₹${buffer.toString()}";
//     }
//
//     return "-";
//   }
//
//   /// Extracts a clean integer amount from a Firestore price value, so it
//   /// can be used for real math on the booking page. Handles the value
//   /// already being a number, or a string like "₹12,000" (strips the
//   /// currency symbol and thousands separators).
//   int _parseRawPrice(dynamic price) {
//     if (price is num) return price.toInt();
//
//     if (price is String) {
//       final digitsOnly = price.replaceAll(RegExp(r'[^0-9]'), '');
//       if (digitsOnly.isEmpty) return 0;
//       return int.tryParse(digitsOnly) ?? 0;
//     }
//
//     return 0;
//   }
//
//   /// Fetches how many times each pooja (by name) has been booked, by
//   /// counting documents in the `booking` collection grouped by
//   /// `poojaName`. Used to sort the pooja list so the most-booked pooja
//   /// appears first.
//   Future<Map<String, int>> _fetchBookingCounts() async {
//     final snapshot =
//     await FirebaseFirestore.instance.collection('booking').get();
//
//     final counts = <String, int>{};
//
//     for (final doc in snapshot.docs) {
//       final data = doc.data();
//       final name = data['poojaName'] as String?;
//       if (name == null) continue;
//       counts[name] = (counts[name] ?? 0) + 1;
//     }
//
//     return counts;
//   }
//
//   /// Filters poojas by the current search query, matching against both
//   /// the English name and Malayalam name (case-insensitive).
//   List<Map<String, dynamic>> _applySearchFilter(
//       List<Map<String, dynamic>> poojas,
//       ) {
//     final query = searchQuery.trim().toLowerCase();
//     if (query.isEmpty) return poojas;
//
//     return poojas.where((pooja) {
//       final name = (pooja["name"] as String).toLowerCase();
//       final malayalam = (pooja["malayalam"] as String).toLowerCase();
//       return name.contains(query) || malayalam.contains(query);
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: lightBackground,
//       body: SafeArea(
//         child: Column(
//           children: [
//             /// HEADER + SEARCH AREA
//             _buildHeader(),
//
//             /// BODY — live pooja list from Firestore, ordered by
//             /// booking popularity (most-booked pooja on top), filtered
//             /// by the search box.
//             Expanded(
//               child: FutureBuilder<Map<String, int>>(
//                 future: _fetchBookingCounts(),
//                 builder: (context, countsSnapshot) {
//                   final bookingCounts = countsSnapshot.data ?? {};
//
//                   return StreamBuilder<QuerySnapshot>(
//                     stream: FirebaseFirestore.instance
//                         .collection('poojas')
//                         .snapshots(),
//                     builder: (context, poojaSnapshot) {
//                       if (poojaSnapshot.hasError) {
//                         return Center(
//                           child: Padding(
//                             padding: const EdgeInsets.all(20),
//                             child: Text(
//                               "Could not load poojas.\n${poojaSnapshot.error}",
//                               textAlign: TextAlign.center,
//                             ),
//                           ),
//                         );
//                       }
//
//                       if (!poojaSnapshot.hasData) {
//                         return const Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       }
//
//                       // Convert Firestore docs into the same map shape
//                       // the UI below expects (name, malayalam, price,
//                       // popular), plus the live booking count and a
//                       // clean numeric price for use on the booking page.
//                       final poojas = poojaSnapshot.data!.docs.map((doc) {
//                         final data = doc.data() as Map<String, dynamic>;
//                         final name = (data['name'] as String?) ?? "Pooja";
//                         final rawPrice = data['price'];
//
//                         return {
//                           "id": doc.id,
//                           "name": name,
//                           "malayalam": (data['malayalam'] as String?) ?? "",
//                           "price": _formatPrice(rawPrice),
//                           "rawPrice": _parseRawPrice(rawPrice),
//                           "popular": (data['popular'] as bool?) ?? false,
//                           "bookingCount": bookingCounts[name] ?? 0,
//                         };
//                       }).toList();
//
//                       // Most-booked pooja first. Ties fall back to the
//                       // "popular" flag, then alphabetical for stability.
//                       poojas.sort((a, b) {
//                         final countCompare = (b["bookingCount"] as int)
//                             .compareTo(a["bookingCount"] as int);
//                         if (countCompare != 0) return countCompare;
//
//                         final popularCompare = (b["popular"] as bool ? 1 : 0)
//                             .compareTo(a["popular"] as bool ? 1 : 0);
//                         if (popularCompare != 0) return popularCompare;
//
//                         return (a["name"] as String)
//                             .compareTo(b["name"] as String);
//                       });
//
//                       final filteredPoojas = _applySearchFilter(poojas);
//                       final visiblePoojas = showMore
//                           ? filteredPoojas
//                           : filteredPoojas.take(6).toList();
//
//                       return Column(
//                         children: [
//                           /// SECTION TITLE
//                           Padding(
//                             padding:
//                             const EdgeInsets.fromLTRB(22, 14, 22, 8),
//                             child: Row(
//                               children: [
//                                 const Text(
//                                   "✦",
//                                   style: TextStyle(
//                                     color: Color(0xFFD6AE62),
//                                     fontSize: 16,
//                                   ),
//                                 ),
//                                 const SizedBox(width: 8),
//                                 const Text(
//                                   "Popular Poojas",
//                                   style: TextStyle(
//                                     fontFamily: "serif",
//                                     fontSize: 21,
//                                     fontWeight: FontWeight.w600,
//                                     color: Color(0xFF563B39),
//                                   ),
//                                 ),
//                                 const Spacer(),
//                                 const Text(
//                                   "••",
//                                   style: TextStyle(
//                                     color: Color(0xFFD4AE68),
//                                     fontSize: 18,
//                                     letterSpacing: 3,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//
//                           /// POOJA LIST
//                           Expanded(
//                             child: visiblePoojas.isEmpty
//                                 ? Center(
//                               child: Text(
//                                 searchQuery.isEmpty
//                                     ? "No poojas found."
//                                     : "No poojas match \"$searchQuery\".",
//                                 style: const TextStyle(
//                                     color: Colors.grey),
//                               ),
//                             )
//                                 : ListView.builder(
//                               padding: const EdgeInsets.symmetric(
//                                   horizontal: 18),
//                               itemCount: visiblePoojas.length,
//                               itemBuilder: (context, index) {
//                                 return _buildPoojaItem(
//                                   visiblePoojas[index],
//                                 );
//                               },
//                             ),
//                           ),
//
//                           /// SEE MORE
//                           if (filteredPoojas.length > 6)
//                             InkWell(
//                               onTap: () {
//                                 setState(() {
//                                   showMore = !showMore;
//                                 });
//                               },
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.symmetric(vertical: 8),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       showMore ? "See Less" : "See More",
//                                       style: const TextStyle(
//                                         color: Color(0xFF654443),
//                                         fontSize: 15,
//                                         fontWeight: FontWeight.w600,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 6),
//                                     Icon(
//                                       showMore
//                                           ? Icons.keyboard_arrow_up
//                                           : Icons.keyboard_arrow_down,
//                                       size: 20,
//                                       color: brown,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       );
//                     },
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF8D311C),
//             Color(0xFF673333),
//             Color(0xFF563131),
//           ],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(35),
//           bottomRight: Radius.circular(35),
//         ),
//       ),
//       child: Column(
//         children: [
//           const SizedBox(height: 16),
//
//           /// TITLE ROW
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 18),
//             child: Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                   child: const Icon(
//                     Icons.chevron_left,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//                 const SizedBox(width: 6),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: const [
//                       Text(
//                         "Pooja Details",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 23,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       SizedBox(height: 2),
//                       Text(
//                         "പൂജകളും വഴിപാടുകളും",
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   width: 43,
//                   height: 43,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: Colors.white,
//                       width: 1.4,
//                     ),
//                   ),
//                   child: const Icon(
//                     Icons.notifications_none_rounded,
//                     color: Colors.white,
//                     size: 25,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           const SizedBox(height: 24),
//
//           /// SEARCH FILTER BOX — replaces the old All/Today/Upcoming tabs.
//           Padding(
//             padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
//             child: Container(
//               height: 52,
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFF7F5F3),
//                 borderRadius: BorderRadius.circular(26),
//               ),
//               child: Row(
//                 children: [
//                   Icon(Icons.search, color: brown, size: 20),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: TextField(
//                       controller: searchController,
//                       onChanged: (value) {
//                         setState(() {
//                           searchQuery = value;
//                           showMore = true;
//                         });
//                       },
//                       decoration: const InputDecoration(
//                         hintText: "Search poojas...",
//                         hintStyle: TextStyle(
//                           color: Color(0xFF9C8B88),
//                           fontSize: 14,
//                         ),
//                         border: InputBorder.none,
//                         isCollapsed: true,
//                       ),
//                       style: const TextStyle(
//                         color: Color(0xFF4F3A39),
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   if (searchQuery.isNotEmpty)
//                     GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           searchController.clear();
//                           searchQuery = "";
//                         });
//                       },
//                       child: Icon(
//                         Icons.close_rounded,
//                         color: brown,
//                         size: 18,
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildPoojaItem(Map<String, dynamic> pooja) {
//     return InkWell(
//       borderRadius: BorderRadius.circular(16),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => TempleBookingPage(
//               poojaId: pooja["id"] as String,
//               poojaName: pooja["name"] as String,
//               malayalamName: pooja["malayalam"] as String,
//               pricePerDevotee: pooja["amount"] as int,
//             ),
//           ),
//         );
//       },
//       child: Container(
//         constraints: const BoxConstraints(
//           minHeight: 76,
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//         child: Row(
//           children: [
//             /// IMAGE
//             ClipOval(
//               child: Image.asset(
//                 "assets/images/pooja.jpg",
//                 width: 53,
//                 height: 53,
//                 fit: BoxFit.cover,
//
//                 /// prevents crash if image is missing
//                 errorBuilder: (
//                     BuildContext context,
//                     Object error,
//                     StackTrace? stackTrace,
//                     ) {
//                   return Container(
//                     width: 53,
//                     height: 53,
//                     color: const Color(0xFFE2D8D2),
//                     child: Icon(
//                       Icons.temple_hindu,
//                       color: brown,
//                     ),
//                   );
//                 },
//               ),
//             ),
//
//             const SizedBox(width: 13),
//
//             /// DETAILS
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     pooja["name"],
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Color(0xFF533B3A),
//                       fontSize: 16.5,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   const SizedBox(height: 1),
//                   Text(
//                     pooja["malayalam"],
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: const TextStyle(
//                       color: Color(0xFF8D7E7A),
//                       fontSize: 10.5,
//                     ),
//                   ),
//                   if (pooja["popular"] == true)
//                     Padding(
//                       padding: const EdgeInsets.only(top: 2),
//                       child: Row(
//                         children: const [
//                           Icon(
//                             Icons.radio_button_unchecked,
//                             color: Color(0xFFD56A4E),
//                             size: 11,
//                           ),
//                           SizedBox(width: 3),
//                           Text(
//                             "POPULAR",
//                             style: TextStyle(
//                               color: Color(0xFFD56A4E),
//                               fontSize: 9,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                 ],
//               ),
//             ),
//
//             const SizedBox(width: 8),
//
//             /// PRICE + ARROW
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Text(
//                   pooja["price"],
//                   style: const TextStyle(
//                     color: Color(0xFF4F3A39),
//                     fontSize: 16.5,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 const Icon(
//                   Icons.chevron_right,
//                   size: 20,
//                   color: Color(0xFFB2A5A1),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'BookingDetailsPage.dart';

class PoojaDetailsPage extends StatefulWidget {
  const PoojaDetailsPage({super.key});

  @override
  State<PoojaDetailsPage> createState() => _PoojaDetailsPageState();
}

class _PoojaDetailsPageState extends State<PoojaDetailsPage> {
  bool showMore = false;
  String searchQuery = "";

  final TextEditingController searchController = TextEditingController();

  final Color brown = const Color(0xFF713C3A);
  final Color darkBrown = const Color(0xFF4E2928);
  final Color lightBackground = const Color(0xFFF8F5F1);

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// Formats a Firestore amount value (num or String) into a display
  /// string like "₹500". If it's already a String (e.g. "₹500"), it's
  /// used as-is.
  String _formatPrice(dynamic amount) {
    if (amount is String) return amount;

    if (amount is num) {
      final intPart = amount.toInt();
      final str = intPart.toString();
      final buffer = StringBuffer();
      final length = str.length;

      for (int i = 0; i < length; i++) {
        final posFromEnd = length - i;
        buffer.write(str[i]);
        if (posFromEnd > 3 && (posFromEnd - 3) % 2 == 0) {
          buffer.write(',');
        }
      }

      return "₹${buffer.toString()}";
    }

    return "-";
  }

  /// Extracts a clean integer amount from a Firestore amount value, so it
  /// can be used for real math on the booking page. Handles the value
  /// already being a number, or a string like "₹500" (strips the
  /// currency symbol and thousands separators).
  int _parseRawPrice(dynamic amount) {
    if (amount is num) return amount.toInt();

    if (amount is String) {
      final digitsOnly = amount.replaceAll(RegExp(r'[^0-9]'), '');
      if (digitsOnly.isEmpty) return 0;
      return int.tryParse(digitsOnly) ?? 0;
    }

    return 0;
  }

  /// Fetches how many times each pooja (by name) has been booked, by
  /// counting documents in the `booking` collection grouped by
  /// `poojaName`. Used to sort the pooja list so the most-booked pooja
  /// appears first.
  Future<Map<String, int>> _fetchBookingCounts() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('booking').get();

    final counts = <String, int>{};

    for (final doc in snapshot.docs) {
      final data = doc.data();
      final name = data['poojaName'] as String?;
      if (name == null) continue;
      counts[name] = (counts[name] ?? 0) + 1;
    }

    return counts;
  }

  /// Filters poojas by the current search query, matching against the
  /// pooja name (case-insensitive).
  List<Map<String, dynamic>> _applySearchFilter(
      List<Map<String, dynamic>> poojas,
      ) {
    final query = searchQuery.trim().toLowerCase();
    if (query.isEmpty) return poojas;

    return poojas.where((pooja) {
      final name = (pooja["name"] as String).toLowerCase();
      return name.contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackground,
      body: SafeArea(
        child: Column(
          children: [
            /// HEADER + SEARCH AREA
            _buildHeader(),

            /// BODY — live pooja list from Firestore, ordered by
            /// booking popularity (most-booked pooja on top), filtered
            /// by the search box.
            Expanded(
              child: FutureBuilder<Map<String, int>>(
                future: _fetchBookingCounts(),
                builder: (context, countsSnapshot) {
                  final bookingCounts = countsSnapshot.data ?? {};

                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('poojas')
                        .snapshots(),
                    builder: (context, poojaSnapshot) {
                      if (poojaSnapshot.hasError) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Text(
                              "Could not load poojas.\n${poojaSnapshot.error}",
                              textAlign: TextAlign.center,
                            ),
                          ),
                        );
                      }

                      if (!poojaSnapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      // Convert Firestore docs into the map shape the UI
                      // below expects. Your schema stores fields as:
                      // name, amount, category, duration, description,
                      // activeStatus, createdAt — there is no separate
                      // English/Malayalam split and no "popular" flag
                      // yet, so those are defaulted below.
                      final poojas = poojaSnapshot.data!.docs
                          .where((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        // Skip poojas that have been deactivated, if the
                        // field is present.
                        return (data['activeStatus'] as bool?) ?? true;
                      })
                          .map((doc) {
                        final data = doc.data() as Map<String, dynamic>;
                        final name = (data['name'] as String?) ?? "Pooja";
                        final rawAmount = data['amount'];

                        return {
                          "id": doc.id,
                          "name": name,
                          "category": (data['category'] as String?) ?? "",
                          "duration": (data['duration'] as String?) ?? "",
                          "description":
                          (data['description'] as String?) ?? "",
                          "price": _formatPrice(rawAmount),
                          "rawPrice": _parseRawPrice(rawAmount),
                          "popular": (data['popular'] as bool?) ?? false,
                          "bookingCount": bookingCounts[name] ?? 0,
                        };
                      }).toList();

                      // Most-booked pooja first. Ties fall back to the
                      // "popular" flag, then alphabetical for stability.
                      poojas.sort((a, b) {
                        final countCompare = (b["bookingCount"] as int)
                            .compareTo(a["bookingCount"] as int);
                        if (countCompare != 0) return countCompare;

                        final popularCompare = (b["popular"] as bool ? 1 : 0)
                            .compareTo(a["popular"] as bool ? 1 : 0);
                        if (popularCompare != 0) return popularCompare;

                        return (a["name"] as String)
                            .compareTo(b["name"] as String);
                      });

                      final filteredPoojas = _applySearchFilter(poojas);
                      final visiblePoojas = showMore
                          ? filteredPoojas
                          : filteredPoojas.take(6).toList();

                      return Column(
                        children: [
                          /// SECTION TITLE
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(22, 14, 22, 8),
                            child: Row(
                              children: [
                                const Text(
                                  "✦",
                                  style: TextStyle(
                                    color: Color(0xFFD6AE62),
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  "Popular Poojas",
                                  style: TextStyle(
                                    fontFamily: "serif",
                                    fontSize: 21,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF563B39),
                                  ),
                                ),
                                const Spacer(),
                                const Text(
                                  "••",
                                  style: TextStyle(
                                    color: Color(0xFFD4AE68),
                                    fontSize: 18,
                                    letterSpacing: 3,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// POOJA LIST
                          Expanded(
                            child: visiblePoojas.isEmpty
                                ? Center(
                              child: Text(
                                searchQuery.isEmpty
                                    ? "No poojas found."
                                    : "No poojas match \"$searchQuery\".",
                                style: const TextStyle(
                                    color: Colors.grey),
                              ),
                            )
                                : ListView.builder(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 18),
                              itemCount: visiblePoojas.length,
                              itemBuilder: (context, index) {
                                return _buildPoojaItem(
                                  visiblePoojas[index],
                                );
                              },
                            ),
                          ),

                          /// SEE MORE
                          if (filteredPoojas.length > 6)
                            InkWell(
                              onTap: () {
                                setState(() {
                                  showMore = !showMore;
                                });
                              },
                              child: Padding(
                                padding:
                                const EdgeInsets.symmetric(vertical: 8),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      showMore ? "See Less" : "See More",
                                      style: const TextStyle(
                                        color: Color(0xFF654443),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 6),
                                    Icon(
                                      showMore
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_down,
                                      size: 20,
                                      color: brown,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
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

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF8D311C),
            Color(0xFF673333),
            Color(0xFF563131),
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(35),
          bottomRight: Radius.circular(35),
        ),
      ),
      child: Column(
        children: [
          const SizedBox(height: 16),

          /// TITLE ROW
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Pooja Details",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        "പൂജകളും വഴിപാടുകളും",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 43,
                  height: 43,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 1.4,
                    ),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          /// SEARCH FILTER BOX — replaces the old All/Today/Upcoming tabs.
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F5F3),
                borderRadius: BorderRadius.circular(26),
              ),
              child: Row(
                children: [
                  Icon(Icons.search, color: brown, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                          showMore = true;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Search poojas...",
                        hintStyle: TextStyle(
                          color: Color(0xFF9C8B88),
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                        isCollapsed: true,
                      ),
                      style: const TextStyle(
                        color: Color(0xFF4F3A39),
                        fontSize: 14,
                      ),
                    ),
                  ),
                  if (searchQuery.isNotEmpty)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          searchController.clear();
                          searchQuery = "";
                        });
                      },
                      child: Icon(
                        Icons.close_rounded,
                        color: brown,
                        size: 18,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoojaItem(Map<String, dynamic> pooja) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TempleBookingPage(
              poojaId: pooja["id"] as String,
              poojaName: pooja["name"] as String,
              pricePerDevotee: pooja["rawPrice"] as int, malayalamName: '',
            ),
          ),
        );
      },
      child: Container(
        constraints: const BoxConstraints(
          minHeight: 76,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Row(
          children: [
            /// IMAGE
            ClipOval(
              child: Image.asset(
                "assets/images/pooja.jpg",
                width: 53,
                height: 53,
                fit: BoxFit.cover,

                /// prevents crash if image is missing
                errorBuilder: (
                    BuildContext context,
                    Object error,
                    StackTrace? stackTrace,
                    ) {
                  return Container(
                    width: 53,
                    height: 53,
                    color: const Color(0xFFE2D8D2),
                    child: Icon(
                      Icons.temple_hindu,
                      color: brown,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(width: 13),

            /// DETAILS
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pooja["name"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF533B3A),
                      fontSize: 16.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  if ((pooja["duration"] as String).isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 1),
                      child: Text(
                        pooja["duration"],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Color(0xFF8D7E7A),
                          fontSize: 10.5,
                        ),
                      ),
                    ),
                  if (pooja["popular"] == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Row(
                        children: const [
                          Icon(
                            Icons.radio_button_unchecked,
                            color: Color(0xFFD56A4E),
                            size: 11,
                          ),
                          SizedBox(width: 3),
                          Text(
                            "POPULAR",
                            style: TextStyle(
                              color: Color(0xFFD56A4E),
                              fontSize: 9,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            /// PRICE + ARROW
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  pooja["price"],
                  style: const TextStyle(
                    color: Color(0xFF4F3A39),
                    fontSize: 16.5,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                const Icon(
                  Icons.chevron_right,
                  size: 20,
                  color: Color(0xFFB2A5A1),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}