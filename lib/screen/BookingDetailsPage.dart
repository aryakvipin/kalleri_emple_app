// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// //
// // // Adjust this import path to match where booking_success_screen.dart
// // // actually lives in your project structure.
// // import 'Booking success screen.dart';
// //
// // class TempleBookingPage extends StatefulWidget {
// //   const TempleBookingPage({super.key});
// //
// //   @override
// //   State<TempleBookingPage> createState() => _TempleBookingPageState();
// // }
// //
// // class _TempleBookingPageState extends State<TempleBookingPage> {
// //   static const Color brown = Color(0xFF6D3B3A);
// //   static const Color darkBrown = Color(0xFF542B2A);
// //   static const Color background = Color(0xFFFAF8F5);
// //   static const Color borderColor = Color(0xFFE5DEDA);
// //   static const Color textColor = Color(0xFF59413F);
// //   static const Color subTextColor = Color(0xFF918480);
// //
// //   int currentStep = 0;
// //
// //   late DateTime selectedDate;
// //
// //   String selectedTime = "04:00 PM";
// //   String? selectedNakshatram;
// //
// //   // Extra named devotees added one-by-one via the "Add Member" bottom sheet.
// //   final List<Map<String, String?>> additionalMembers = [];
// //
// //   int paymentMethod = 0;
// //
// //   bool isSavingBooking = false;
// //
// //   final TextEditingController nameController = TextEditingController();
// //
// //   final TextEditingController requestController = TextEditingController();
// //
// //   // Nakshatram list with Malayalam name shown in brackets.
// //   final Map<String, String> nakshatrams = {
// //     "Ashwathi": "അശ്വതി",
// //     "Bharani": "ഭരണി",
// //     "Karthika": "കാർത്തിക",
// //     "Rohini": "രോഹിണി",
// //     "Makayiram": "മകയിരം",
// //     "Thiruvathira": "തിരുവാതിര",
// //     "Punartham": "പുണർതം",
// //     "Pooyam": "പൂയം",
// //     "Ayilyam": "ആയില്യം",
// //     "Makam": "മകം",
// //     "Pooram": "പൂരം",
// //     "Uthram": "ഉത്രം",
// //     "Atham": "അത്തം",
// //     "Chithira": "ചിത്തിര",
// //     "Chothi": "ചോതി",
// //     "Vishakham": "വിശാഖം",
// //     "Anizham": "അനിഴം",
// //     "Thrikketta": "തൃക്കേട്ട",
// //     "Moolam": "മൂലം",
// //     "Pooradam": "പൂരാടം",
// //     "Uthradam": "ഉത്രാടം",
// //     "Thiruvonam": "തിരുവോണം",
// //     "Avittam": "അവിട്ടം",
// //     "Chathayam": "ചതയം",
// //     "Pooruruttathi": "പൂരുരുട്ടാതി",
// //     "Uthrattathi": "ഉത്രട്ടാതി",
// //     "Revathi": "രേവതി",
// //   };
// //
// //   String nakshatramLabel(String star) {
// //     final malayalam = nakshatrams[star];
// //     return malayalam == null ? star : "$star ($malayalam)";
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     selectedDate = DateTime.now();
// //   }
// //
// //   @override
// //   void dispose() {
// //     nameController.dispose();
// //     requestController.dispose();
// //     super.dispose();
// //   }
// //
// //   List<DateTime> get bookingDates {
// //     return List.generate(
// //       7,
// //           (index) => DateTime.now().add(Duration(days: index)),
// //     );
// //   }
// //
// //   bool sameDate(DateTime a, DateTime b) {
// //     return a.year == b.year && a.month == b.month && a.day == b.day;
// //   }
// //
// //   String weekDay(DateTime date) {
// //     const days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
// //     return days[date.weekday - 1];
// //   }
// //
// //   String formatCurrency(int amount) {
// //     final str = amount.toString();
// //     final buffer = StringBuffer();
// //     final length = str.length;
// //
// //     for (int i = 0; i < length; i++) {
// //       final posFromEnd = length - i;
// //       buffer.write(str[i]);
// //
// //       // Indian-style grouping: last 3 digits, then groups of 2.
// //       if (posFromEnd > 3 && (posFromEnd - 3) % 2 == 0) {
// //         buffer.write(',');
// //       }
// //     }
// //
// //     return buffer.toString();
// //   }
// //
// //   String formatDate(DateTime date) {
// //     return "${date.day.toString().padLeft(2, '0')}/"
// //         "${date.month.toString().padLeft(2, '0')}/"
// //         "${date.year}";
// //   }
// //
// //   Future<void> selectBookingDate() async {
// //     final result = await showDatePicker(
// //       context: context,
// //       initialDate: selectedDate,
// //       firstDate: DateTime.now(),
// //       lastDate: DateTime.now().add(const Duration(days: 365)),
// //     );
// //
// //     if (result != null) {
// //       setState(() {
// //         selectedDate = result;
// //       });
// //     }
// //   }
// //
// //   void continuePage() {
// //     if (currentStep == 0) {
// //       if (nameController.text.trim().isEmpty) {
// //         showMessage("Enter devotee name");
// //         return;
// //       }
// //
// //       if (selectedNakshatram == null) {
// //         showMessage("Select Nakshatram");
// //         return;
// //       }
// //     }
// //
// //     if (currentStep < 2) {
// //       setState(() {
// //         currentStep++;
// //       });
// //     }
// //   }
// //
// //   void previousPage() {
// //     if (currentStep > 0) {
// //       setState(() {
// //         currentStep--;
// //       });
// //     } else {
// //       Navigator.pop(context);
// //     }
// //   }
// //
// //   void showMessage(String message) {
// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(content: Text(message)),
// //     );
// //   }
// //
// //   int get devoteeCountThisBooking => additionalMembers.length;
// //
// //   // Total number of people this pooja is being booked for: the main
// //   // devotee (always 1) plus every additional member added.
// //   int get totalDevoteeCount => 1 + additionalMembers.length;
// //
// //   static const int poojaPricePerDevotee = 12000;
// //   static const int convenienceFee = 20;
// //
// //   int get poojaAmount => totalDevoteeCount * poojaPricePerDevotee;
// //
// //   int get totalAmount => poojaAmount + convenienceFee;
// //
// //   /// Saves this booking to the `booking` collection, tagged with the
// //   /// currently logged-in user's UID so it can be looked up per-user later
// //   /// (e.g. to total how many devotees a user has booked over time).
// //   Future<void> saveBooking() async {
// //     final user = FirebaseAuth.instance.currentUser;
// //
// //     if (user == null) {
// //       showMessage("Please log in again before paying.");
// //       return;
// //     }
// //
// //     setState(() => isSavingBooking = true);
// //
// //     // Payment method 0 = Cash on Delivery (pay at temple later, so the
// //     // booking stays pending until admin confirms). Any other method
// //     // (UPI, Card) is treated as paid upfront, so the booking is
// //     // confirmed immediately.
// //     final bookingStatus = paymentMethod == 0 ? 'pending' : 'confirmed';
// //
// //     try {
// //       final docRef = await FirebaseFirestore.instance.collection('booking').add({
// //         'userId': user.uid,
// //         'userEmail': user.email,
// //         'devoteeName': nameController.text.trim(),
// //         'nakshatram': selectedNakshatram,
// //         'additionalMembers': additionalMembers,
// //         'devoteeCount': devoteeCountThisBooking,
// //         'poojaName': "Kuttichathan Vellatt",
// //         'bookingDate': Timestamp.fromDate(selectedDate),
// //         'bookingTime': selectedTime,
// //         'specialRequest': requestController.text.trim(),
// //         'paymentMethod': paymentMethod,
// //         'status': bookingStatus,
// //         'devoteeTotalCount': totalDevoteeCount,
// //         'pricePerDevotee': poojaPricePerDevotee,
// //         'amount': poojaAmount,
// //         'convenienceFee': convenienceFee,
// //         'totalAmount': totalAmount,
// //         'createdAt': FieldValue.serverTimestamp(),
// //       });
// //
// //       if (!mounted) return;
// //
// //       // Navigate to the success screen with the real booking details.
// //       // BookingSuccessScreen auto-returns to Home after a couple of
// //       // seconds, so no extra action is needed here.
// //       Navigator.of(context).pushReplacement(
// //         MaterialPageRoute(
// //           builder: (_) => BookingSuccessScreen(
// //             donationId: docRef.id,
// //             categoryLabel: "Kuttichathan Vellatt",
// //             categoryIcon: Icons.temple_hindu,
// //             amount: "₹${formatCurrency(totalAmount)}",
// //             date: formatDate(selectedDate),
// //             timeSlot: selectedTime,
// //           ),
// //         ),
// //       );
// //     } catch (e) {
// //       if (!mounted) return;
// //       showMessage("Could not save booking. Please try again.");
// //     } finally {
// //       if (mounted) setState(() => isSavingBooking = false);
// //     }
// //   }
// //
// //   /// Total devotees booked by the logged-in user across all their past
// //   /// bookings (sum of `devoteeCount` on every `booking` doc with their uid).
// //   Stream<int> get totalDevoteesForUser {
// //     final user = FirebaseAuth.instance.currentUser;
// //
// //     if (user == null) {
// //       return Stream.value(0);
// //     }
// //
// //     return FirebaseFirestore.instance
// //         .collection('booking')
// //         .where('userId', isEqualTo: user.uid)
// //         .snapshots()
// //         .map((snapshot) {
// //       int total = 0;
// //       for (final doc in snapshot.docs) {
// //         final count = doc.data()['devoteeCount'];
// //         if (count is int) total += count;
// //       }
// //       return total;
// //     });
// //   }
// //
// //   /// Opens a bottom sheet with a small form (name + nakshatram) to add
// //   /// one more named devotee to this booking.
// //   void showAddMemberSheet() {
// //     final memberNameController = TextEditingController();
// //     String? memberNakshatram;
// //
// //     showModalBottomSheet(
// //       context: context,
// //       isScrollControlled: true,
// //       backgroundColor: Colors.transparent,
// //       builder: (sheetContext) {
// //         return StatefulBuilder(
// //           builder: (sheetContext, setSheetState) {
// //             return Padding(
// //               padding: EdgeInsets.only(
// //                 bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
// //               ),
// //               child: Container(
// //                 padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
// //                 decoration: const BoxDecoration(
// //                   color: Colors.white,
// //                   borderRadius: BorderRadius.only(
// //                     topLeft: Radius.circular(20),
// //                     topRight: Radius.circular(20),
// //                   ),
// //                 ),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Center(
// //                       child: Container(
// //                         width: 42,
// //                         height: 4,
// //                         margin: const EdgeInsets.only(bottom: 16),
// //                         decoration: BoxDecoration(
// //                           color: borderColor,
// //                           borderRadius: BorderRadius.circular(4),
// //                         ),
// //                       ),
// //                     ),
// //                     Text(
// //                       "Add Member",
// //                       style: TextStyle(
// //                         fontSize: 18,
// //                         fontWeight: FontWeight.w700,
// //                         color: textColor,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     inputLabel("Name *"),
// //                     const SizedBox(height: 7),
// //                     TextField(
// //                       controller: memberNameController,
// //                       decoration: inputDecoration(
// //                         "Enter member name",
// //                         Icons.person_outline,
// //                       ),
// //                     ),
// //                     const SizedBox(height: 16),
// //                     inputLabel("Nakshatram *"),
// //                     const SizedBox(height: 7),
// //                     DropdownButtonFormField<String>(
// //                       initialValue: memberNakshatram,
// //                       isExpanded: true,
// //                       hint: const Text("Select nakshatram"),
// //                       decoration: InputDecoration(
// //                         prefixIcon: const Icon(
// //                           Icons.star_border,
// //                           color: brown,
// //                         ),
// //                         filled: true,
// //                         fillColor: Colors.white,
// //                         enabledBorder: fieldBorder(),
// //                         focusedBorder: fieldBorder(color: brown, width: 1.4),
// //                       ),
// //                       items: nakshatrams.keys.map((star) {
// //                         return DropdownMenuItem(
// //                           value: star,
// //                           child: Text(nakshatramLabel(star)),
// //                         );
// //                       }).toList(),
// //                       onChanged: (value) {
// //                         setSheetState(() {
// //                           memberNakshatram = value;
// //                         });
// //                       },
// //                     ),
// //                     const SizedBox(height: 22),
// //                     SizedBox(
// //                       width: double.infinity,
// //                       height: 50,
// //                       child: ElevatedButton(
// //                         onPressed: () {
// //                           final name = memberNameController.text.trim();
// //
// //                           if (name.isEmpty) {
// //                             showMessage("Enter member name");
// //                             return;
// //                           }
// //
// //                           if (memberNakshatram == null) {
// //                             showMessage("Select member's Nakshatram");
// //                             return;
// //                           }
// //
// //                           setState(() {
// //                             additionalMembers.add({
// //                               'name': name,
// //                               'nakshatram': memberNakshatram,
// //                             });
// //                           });
// //
// //                           Navigator.pop(sheetContext);
// //                         },
// //                         style: ElevatedButton.styleFrom(
// //                           backgroundColor: brown,
// //                           foregroundColor: Colors.white,
// //                           elevation: 0,
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                         ),
// //                         child: const Text(
// //                           "Add",
// //                           style: TextStyle(
// //                             fontSize: 15,
// //                             fontWeight: FontWeight.w600,
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             );
// //           },
// //         );
// //       },
// //     );
// //   }
// //
// //   /// Renders the list of extra named devotees added so far, each with a
// //   /// remove button.
// //   Widget buildAdditionalMembersList() {
// //     if (additionalMembers.isEmpty) return const SizedBox.shrink();
// //
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         const SizedBox(height: 12),
// //         ...additionalMembers.asMap().entries.map((entry) {
// //           final index = entry.key;
// //           final member = entry.value;
// //           final star = member['nakshatram'];
// //
// //           return Container(
// //             margin: const EdgeInsets.only(bottom: 8),
// //             padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(9),
// //               border: Border.all(color: borderColor),
// //             ),
// //             child: Row(
// //               children: [
// //                 const Icon(Icons.person_outline, color: brown, size: 18),
// //                 const SizedBox(width: 10),
// //                 Expanded(
// //                   child: Column(
// //                     crossAxisAlignment: CrossAxisAlignment.start,
// //                     children: [
// //                       Text(
// //                         member['name'] ?? "",
// //                         style: const TextStyle(
// //                           color: textColor,
// //                           fontWeight: FontWeight.w600,
// //                           fontSize: 13,
// //                         ),
// //                       ),
// //                       Text(
// //                         star == null ? "-" : nakshatramLabel(star),
// //                         style: const TextStyle(
// //                           color: subTextColor,
// //                           fontSize: 11,
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 IconButton(
// //                   padding: EdgeInsets.zero,
// //                   constraints: const BoxConstraints(),
// //                   onPressed: () {
// //                     setState(() {
// //                       additionalMembers.removeAt(index);
// //                     });
// //                   },
// //                   icon: const Icon(
// //                     Icons.close,
// //                     color: subTextColor,
// //                     size: 18,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           );
// //         }),
// //       ],
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: background,
// //       body: SafeArea(
// //         child: Column(
// //           children: [
// //             buildHeader(),
// //             Expanded(
// //               child: AnimatedSwitcher(
// //                 duration: const Duration(milliseconds: 250),
// //                 child: SingleChildScrollView(
// //                   key: ValueKey(currentStep),
// //                   padding: const EdgeInsets.fromLTRB(20, 18, 20, 35),
// //                   child: currentStep == 0
// //                       ? buildDevoteePage()
// //                       : currentStep == 1
// //                       ? buildBookingPage()
// //                       : buildPaymentPage(),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // HEADER
// //   // ===========================================================================
// //
// //   Widget buildHeader() {
// //     return Container(
// //       decoration: const BoxDecoration(
// //         gradient: LinearGradient(
// //           begin: Alignment.topLeft,
// //           end: Alignment.bottomRight,
// //           colors: [Color(0xFF8D2F1C), Color(0xFF703331), darkBrown],
// //         ),
// //         borderRadius: BorderRadius.only(
// //           bottomLeft: Radius.circular(30),
// //           bottomRight: Radius.circular(30),
// //         ),
// //       ),
// //       child: Column(
// //         children: [
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(10, 14, 17, 10),
// //             child: Row(
// //               children: [
// //                 IconButton(
// //                   onPressed: previousPage,
// //                   icon: const Icon(
// //                     Icons.chevron_left,
// //                     color: Colors.white,
// //                     size: 30,
// //                   ),
// //                 ),
// //                 const Expanded(
// //                   child: Text(
// //                     "Booking Details",
// //                     style: TextStyle(
// //                       color: Colors.white,
// //                       fontSize: 21,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                 ),
// //                 Container(
// //                   width: 42,
// //                   height: 42,
// //                   decoration: BoxDecoration(
// //                     shape: BoxShape.circle,
// //                     border: Border.all(color: Colors.white70),
// //                   ),
// //                   child: const Icon(
// //                     Icons.notifications_none_rounded,
// //                     color: Colors.white,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Padding(
// //             padding: const EdgeInsets.fromLTRB(32, 3, 32, 15),
// //             child: Row(
// //               children: [
// //                 buildStep(0, "Devotee"),
// //                 Expanded(child: buildStepLine(1)),
// //                 buildStep(1, "Booking"),
// //                 Expanded(child: buildStepLine(2)),
// //                 buildStep(2, "Payment"),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget buildStep(int step, String title) {
// //     final bool completed = currentStep > step;
// //     final bool active = currentStep == step;
// //
// //     return Column(
// //       children: [
// //         Container(
// //           width: 31,
// //           height: 31,
// //           decoration: BoxDecoration(
// //             shape: BoxShape.circle,
// //             color: completed || active
// //                 ? const Color(0xFFF7F2ED)
// //                 : Colors.white24,
// //             border: Border.all(color: Colors.white54),
// //           ),
// //           child: completed
// //               ? const Icon(Icons.check, color: brown, size: 17)
// //               : Center(
// //             child: Text(
// //               "${step + 1}",
// //               style: TextStyle(
// //                 color: active ? brown : Colors.white54,
// //                 fontWeight: FontWeight.w700,
// //               ),
// //             ),
// //           ),
// //         ),
// //         const SizedBox(height: 5),
// //         Text(
// //           title,
// //           style: TextStyle(
// //             fontSize: 10,
// //             color: active || completed ? Colors.white : Colors.white54,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget buildStepLine(int targetStep) {
// //     final bool completed = currentStep >= targetStep;
// //
// //     return Container(
// //       height: 2,
// //       margin: const EdgeInsets.only(bottom: 17),
// //       color: completed ? Colors.white : Colors.white38,
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // STEP 1
// //   // ===========================================================================
// //
// //   Widget buildDevoteePage() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         buildPoojaCard(),
// //         const SizedBox(height: 24),
// //         Row(
// //           children: [
// //             sectionTitle("Select Date"),
// //             const Spacer(),
// //             InkWell(
// //               onTap: selectBookingDate,
// //               child: const Icon(
// //                 Icons.calendar_month_outlined,
// //                 color: brown,
// //               ),
// //             ),
// //           ],
// //         ),
// //         const SizedBox(height: 14),
// //         buildDateSelector(),
// //         const SizedBox(height: 26),
// //         sectionTitle("Time Slot"),
// //         const SizedBox(height: 14),
// //         Row(
// //           children: [
// //             Expanded(child: buildTimeSlot("04:00 PM")),
// //             const SizedBox(width: 12),
// //             Expanded(child: buildTimeSlot("08:00 PM")),
// //           ],
// //         ),
// //         const SizedBox(height: 28),
// //         sectionTitle("Devotee Details"),
// //         const SizedBox(height: 4),
// //         const Text(
// //           "Please provide devotee information for the booking",
// //           style: TextStyle(color: subTextColor, fontSize: 12),
// //         ),
// //         const SizedBox(height: 20),
// //         inputLabel("Devotee Name (വഴിപാടുകാരന്റെ പേര്) *"),
// //         const SizedBox(height: 7),
// //         TextField(
// //           controller: nameController,
// //           decoration: inputDecoration(
// //             "Enter devotee name",
// //             Icons.person_outline,
// //           ),
// //         ),
// //         const SizedBox(height: 20),
// //         inputLabel("Nakshatram (നക്ഷത്രം) *"),
// //         const SizedBox(height: 7),
// //         buildNakshatramDropdown(),
// //         const SizedBox(height: 32),
// //         buildContinueButton(),
// //       ],
// //     );
// //   }
// //
// //   Widget buildDateSelector() {
// //     final dates = bookingDates;
// //
// //     return SizedBox(
// //       height: 80,
// //       child: ListView.separated(
// //         scrollDirection: Axis.horizontal,
// //         itemCount: dates.length,
// //         separatorBuilder: (_, __) {
// //           return const SizedBox(width: 8);
// //         },
// //         itemBuilder: (context, index) {
// //           final date = dates[index];
// //           final selected = sameDate(date, selectedDate);
// //
// //           return GestureDetector(
// //             onTap: () {
// //               setState(() {
// //                 selectedDate = date;
// //               });
// //             },
// //             child: AnimatedContainer(
// //               duration: const Duration(milliseconds: 180),
// //               width: 59,
// //               decoration: BoxDecoration(
// //                 gradient: selected
// //                     ? const LinearGradient(
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                   colors: [Color(0xFF8B5553), brown],
// //                 )
// //                     : null,
// //                 color: selected ? null : const Color(0xFFF0ECE7),
// //                 borderRadius: BorderRadius.circular(10),
// //               ),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     weekDay(date),
// //                     style: TextStyle(
// //                       fontSize: 10,
// //                       color: selected ? Colors.white70 : subTextColor,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 4),
// //                   Text(
// //                     "${date.day}",
// //                     style: TextStyle(
// //                       fontSize: 21,
// //                       fontWeight: FontWeight.w600,
// //                       color: selected ? Colors.white : textColor,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget buildTimeSlot(String time) {
// //     final bool selected = selectedTime == time;
// //
// //     return GestureDetector(
// //       onTap: () {
// //         setState(() {
// //           selectedTime = time;
// //         });
// //       },
// //       child: Container(
// //         height: 67,
// //         padding: const EdgeInsets.symmetric(horizontal: 13),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(9),
// //           border: Border.all(
// //             color: selected ? brown : borderColor,
// //             width: selected ? 1.5 : 1,
// //           ),
// //         ),
// //         child: Row(
// //           children: [
// //             Expanded(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   const Text(
// //                     "EVENING",
// //                     style: TextStyle(fontSize: 9, color: subTextColor),
// //                   ),
// //                   const SizedBox(height: 3),
// //                   Text(
// //                     time,
// //                     style: const TextStyle(
// //                       fontWeight: FontWeight.w600,
// //                       color: textColor,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Container(
// //               width: 20,
// //               height: 20,
// //               decoration: BoxDecoration(
// //                 shape: BoxShape.circle,
// //                 border: Border.all(color: brown),
// //               ),
// //               child: selected
// //                   ? const Icon(Icons.check, size: 14, color: brown)
// //                   : null,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget buildNakshatramDropdown() {
// //     return DropdownButtonFormField<String>(
// //       initialValue: selectedNakshatram,
// //       isExpanded: true,
// //       hint: const Text("Select nakshatram"),
// //       decoration: InputDecoration(
// //         prefixIcon: const Icon(Icons.star_border, color: brown),
// //         filled: true,
// //         fillColor: Colors.white,
// //         enabledBorder: fieldBorder(),
// //         focusedBorder: fieldBorder(color: brown, width: 1.4),
// //       ),
// //       items: nakshatrams.keys.map((star) {
// //         return DropdownMenuItem(
// //           value: star,
// //           child: Text(nakshatramLabel(star)),
// //         );
// //       }).toList(),
// //       onChanged: (value) {
// //         setState(() {
// //           selectedNakshatram = value;
// //         });
// //       },
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // STEP 2
// //   // ===========================================================================
// //
// //   Widget buildBookingPage() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         buildPoojaCard(),
// //         const SizedBox(height: 28),
// //         sectionTitle("Booking Details"),
// //         const SizedBox(height: 4),
// //         const Text(
// //           "Confirm your preferred booking schedule",
// //           style: TextStyle(color: subTextColor, fontSize: 12),
// //         ),
// //         const SizedBox(height: 18),
// //         buildInfoBox(
// //           Icons.calendar_month_outlined,
// //           "Preferred Date",
// //           formatDate(selectedDate),
// //         ),
// //         const SizedBox(height: 12),
// //         buildInfoBox(Icons.access_time, "Preferred Time", selectedTime),
// //         const SizedBox(height: 28),
// //         sectionTitle("Devotees"),
// //         const SizedBox(height: 4),
// //         const Text(
// //           "Add each devotee for this booking",
// //           style: TextStyle(color: subTextColor, fontSize: 12),
// //         ),
// //         const SizedBox(height: 14),
// //         // Add a named extra devotee via bottom sheet.
// //         InkWell(
// //           onTap: showAddMemberSheet,
// //           borderRadius: BorderRadius.circular(9),
// //           child: Container(
// //             width: double.infinity,
// //             padding: const EdgeInsets.symmetric(vertical: 12),
// //             decoration: BoxDecoration(
// //               color: Colors.white,
// //               borderRadius: BorderRadius.circular(9),
// //               border: Border.all(color: brown, width: 1.2),
// //             ),
// //             child: const Row(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 Icon(Icons.add, color: brown, size: 18),
// //                 SizedBox(width: 6),
// //                 Text(
// //                   "Add Member",
// //                   style: TextStyle(
// //                     color: brown,
// //                     fontWeight: FontWeight.w600,
// //                     fontSize: 13,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //         buildAdditionalMembersList(),
// //         const SizedBox(height: 10),
// //         // Total devotees the logged-in user has booked so far (all bookings).
// //         StreamBuilder<int>(
// //           stream: totalDevoteesForUser,
// //           builder: (context, snapshot) {
// //             final total = snapshot.data;
// //
// //             if (total == null) return const SizedBox.shrink();
// //
// //             return Text(
// //               "Total devotees booked under your account so far: $total",
// //               style: const TextStyle(
// //                 color: subTextColor,
// //                 fontSize: 11,
// //                 fontStyle: FontStyle.italic,
// //               ),
// //             );
// //           },
// //         ),
// //         const SizedBox(height: 28),
// //         sectionTitle("Special Request"),
// //         const SizedBox(height: 4),
// //         const Text(
// //           "Add any special instructions (optional)",
// //           style: TextStyle(color: subTextColor, fontSize: 12),
// //         ),
// //         const SizedBox(height: 14),
// //         TextField(
// //           controller: requestController,
// //           maxLines: 5,
// //           maxLength: 250,
// //           decoration: InputDecoration(
// //             hintText: "Enter special request...",
// //             filled: true,
// //             fillColor: Colors.white,
// //             enabledBorder: fieldBorder(),
// //             focusedBorder: fieldBorder(color: brown, width: 1.4),
// //           ),
// //         ),
// //         const SizedBox(height: 25),
// //         buildContinueButton(),
// //       ],
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // STEP 3
// //   // ===========================================================================
// //
// //   Widget buildPaymentPage() {
// //     return Column(
// //       crossAxisAlignment: CrossAxisAlignment.start,
// //       children: [
// //         sectionTitle("Review Details"),
// //         const SizedBox(height: 16),
// //         buildReviewCard(),
// //         const SizedBox(height: 28),
// //         sectionTitle("Payment Method"),
// //         const SizedBox(height: 15),
// //         buildPaymentTile(
// //           0,
// //           Icons.payments_outlined,
// //           "Cash on Delivery",
// //           "Pay at the temple during the pooja",
// //         ),
// //         const SizedBox(height: 12),
// //         buildPaymentTile(
// //           1,
// //           Icons.account_balance_wallet_outlined,
// //           "UPI",
// //           "Google Pay, PhonePe, Paytm",
// //         ),
// //         const SizedBox(height: 28),
// //         sectionTitle("Payment Summary"),
// //         const SizedBox(height: 15),
// //         Container(
// //           padding: const EdgeInsets.all(17),
// //           decoration: BoxDecoration(
// //             color: Colors.white,
// //             borderRadius: BorderRadius.circular(10),
// //             border: Border.all(color: borderColor),
// //           ),
// //           child: Column(
// //             children: [
// //               buildSummaryRow(
// //                 "Pooja Amount ($totalDevoteeCount × ₹${formatCurrency(poojaPricePerDevotee)})",
// //                 "₹${formatCurrency(poojaAmount)}",
// //               ),
// //               const SizedBox(height: 12),
// //               buildSummaryRow(
// //                 "Convenience Fee",
// //                 "₹${formatCurrency(convenienceFee)}",
// //               ),
// //               const Divider(height: 28),
// //               buildSummaryRow(
// //                 "Total Amount",
// //                 "₹${formatCurrency(totalAmount)}",
// //                 bold: true,
// //               ),
// //             ],
// //           ),
// //         ),
// //         const SizedBox(height: 28),
// //         SizedBox(
// //           width: double.infinity,
// //           height: 54,
// //           child: ElevatedButton(
// //             onPressed: isSavingBooking ? null : saveBooking,
// //             style: ElevatedButton.styleFrom(
// //               backgroundColor: brown,
// //               foregroundColor: Colors.white,
// //               elevation: 0,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(8),
// //               ),
// //             ),
// //             child: isSavingBooking
// //                 ? const SizedBox(
// //               width: 22,
// //               height: 22,
// //               child: CircularProgressIndicator(
// //                 color: Colors.white,
// //                 strokeWidth: 2.4,
// //               ),
// //             )
// //                 : Text(
// //               paymentMethod == 0
// //                   ? "Confirm Booking (₹${formatCurrency(totalAmount)} at temple)"
// //                   : "Confirm & Pay ₹${formatCurrency(totalAmount)}",
// //               style: const TextStyle(
// //                 fontSize: 15,
// //                 fontWeight: FontWeight.w600,
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget buildReviewCard() {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(17),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: borderColor),
// //       ),
// //       child: Column(
// //         children: [
// //           buildReviewRow(
// //             "Devotee 1 Name",
// //             nameController.text,
// //           ),
// //           buildReviewRow(
// //             "Devotee 1 Nakshatram",
// //             selectedNakshatram == null
// //                 ? "-"
// //                 : nakshatramLabel(selectedNakshatram!),
// //           ),
// //           buildReviewRow(
// //             "Total Devotees",
// //             "$totalDevoteeCount",
// //           ),
// //           if (additionalMembers.isNotEmpty)
// //             ...additionalMembers.asMap().entries.expand((entry) {
// //               final devoteeNumber = entry.key + 2; // main devotee is 1
// //               final member = entry.value;
// //               final memberStar = member['nakshatram'];
// //
// //               return [
// //                 buildReviewRow(
// //                   "Devotee $devoteeNumber Name",
// //                   member['name'] ?? "-",
// //                 ),
// //                 buildReviewRow(
// //                   "Devotee $devoteeNumber Nakshatram",
// //                   memberStar == null ? "-" : nakshatramLabel(memberStar),
// //                 ),
// //               ];
// //             }),
// //           const Divider(height: 25),
// //           buildReviewRow("Pooja", "Kuttichathan Vellatt"),
// //           buildReviewRow("Date", formatDate(selectedDate)),
// //           buildReviewRow("Time", selectedTime),
// //           if (requestController.text.trim().isNotEmpty)
// //             buildReviewRow("Special Request", requestController.text),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget buildPaymentTile(
// //       int index,
// //       IconData icon,
// //       String title,
// //       String subtitle,
// //       ) {
// //     final bool selected = paymentMethod == index;
// //
// //     return InkWell(
// //       onTap: () {
// //         setState(() {
// //           paymentMethod = index;
// //         });
// //       },
// //       child: Container(
// //         padding: const EdgeInsets.all(13),
// //         decoration: BoxDecoration(
// //           color: Colors.white,
// //           borderRadius: BorderRadius.circular(9),
// //           border: Border.all(
// //             color: selected ? brown : borderColor,
// //             width: selected ? 1.4 : 1,
// //           ),
// //         ),
// //         child: Row(
// //           children: [
// //             Icon(icon, color: brown),
// //             const SizedBox(width: 13),
// //             Expanded(
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text(
// //                     title,
// //                     style: const TextStyle(
// //                       color: textColor,
// //                       fontWeight: FontWeight.w600,
// //                     ),
// //                   ),
// //                   const SizedBox(height: 2),
// //                   Text(
// //                     subtitle,
// //                     style: const TextStyle(
// //                       color: subTextColor,
// //                       fontSize: 11,
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             Radio<int>(
// //               value: index,
// //               groupValue: paymentMethod,
// //               activeColor: brown,
// //               onChanged: (value) {
// //                 setState(() {
// //                   paymentMethod = value!;
// //                 });
// //               },
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // ===========================================================================
// //   // COMMON WIDGETS
// //   // ===========================================================================
// //
// //   Widget buildPoojaCard() {
// //     return Row(
// //       children: [
// //         ClipOval(
// //           child: Image.asset(
// //             "assets/images/pooja.jpg",
// //             width: 50,
// //             height: 50,
// //             fit: BoxFit.cover,
// //             errorBuilder: (_, __, ___) {
// //               return Container(
// //                 width: 50,
// //                 height: 50,
// //                 color: const Color(0xFFE6DDD8),
// //                 child: const Icon(Icons.temple_hindu, color: brown),
// //               );
// //             },
// //           ),
// //         ),
// //         const SizedBox(width: 12),
// //         const Expanded(
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               Text(
// //                 "Kuttichathan Vellatt",
// //                 style: TextStyle(
// //                   color: textColor,
// //                   fontWeight: FontWeight.w700,
// //                   fontSize: 15,
// //                 ),
// //               ),
// //               Text(
// //                 "കുട്ടിച്ചാത്തൻ വെള്ളാട്ട്",
// //                 style: TextStyle(color: subTextColor, fontSize: 10),
// //               ),
// //               SizedBox(height: 2),
// //               Text(
// //                 "○ POPULAR",
// //                 style: TextStyle(color: Color(0xFFD56C50), fontSize: 9),
// //               ),
// //             ],
// //           ),
// //         ),
// //         const Text(
// //           "₹12,000 / person",
// //           style: TextStyle(
// //             color: textColor,
// //             fontSize: 14,
// //             fontWeight: FontWeight.w700,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget sectionTitle(String title) {
// //     return Text(
// //       title,
// //       style: const TextStyle(
// //         fontFamily: "serif",
// //         fontSize: 23,
// //         fontWeight: FontWeight.w600,
// //         color: textColor,
// //       ),
// //     );
// //   }
// //
// //   Widget inputLabel(String title) {
// //     return Text(
// //       title,
// //       style: const TextStyle(
// //         color: Color(0xFF665451),
// //         fontSize: 13,
// //         fontWeight: FontWeight.w500,
// //       ),
// //     );
// //   }
// //
// //   Widget buildField(IconData icon, String value) {
// //     return Container(
// //       width: double.infinity,
// //       height: 54,
// //       padding: const EdgeInsets.symmetric(horizontal: 14),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(8),
// //         border: Border.all(color: borderColor),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(icon, color: brown),
// //           const SizedBox(width: 11),
// //           Text(value, style: const TextStyle(color: subTextColor)),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget buildInfoBox(IconData icon, String title, String value) {
// //     return Container(
// //       width: double.infinity,
// //       padding: const EdgeInsets.all(15),
// //       decoration: BoxDecoration(
// //         color: Colors.white,
// //         borderRadius: BorderRadius.circular(9),
// //         border: Border.all(color: borderColor),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(icon, color: brown),
// //           const SizedBox(width: 13),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   title,
// //                   style: const TextStyle(
// //                     color: subTextColor,
// //                     fontSize: 11,
// //                   ),
// //                 ),
// //                 const SizedBox(height: 2),
// //                 Text(
// //                   value,
// //                   style: const TextStyle(
// //                     color: textColor,
// //                     fontWeight: FontWeight.w600,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget buildReviewRow(String title, String value) {
// //     return Padding(
// //       padding: const EdgeInsets.only(bottom: 11),
// //       child: Row(
// //         crossAxisAlignment: CrossAxisAlignment.start,
// //         children: [
// //           Expanded(
// //             child: Text(
// //               title,
// //               style: const TextStyle(color: subTextColor, fontSize: 12),
// //             ),
// //           ),
// //           const SizedBox(width: 15),
// //           Flexible(
// //             child: Text(
// //               value,
// //               textAlign: TextAlign.right,
// //               style: const TextStyle(
// //                 color: textColor,
// //                 fontWeight: FontWeight.w600,
// //                 fontSize: 12,
// //               ),
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// //
// //   Widget buildSummaryRow(String title, String value, {bool bold = false}) {
// //     return Row(
// //       children: [
// //         Expanded(
// //           child: Text(
// //             title,
// //             style: TextStyle(
// //               color: textColor,
// //               fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
// //               fontSize: bold ? 15 : 13,
// //             ),
// //           ),
// //         ),
// //         Text(
// //           value,
// //           style: TextStyle(
// //             color: textColor,
// //             fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
// //             fontSize: bold ? 16 : 13,
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// //
// //   Widget buildContinueButton() {
// //     return SizedBox(
// //       width: double.infinity,
// //       height: 54,
// //       child: ElevatedButton(
// //         onPressed: continuePage,
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: brown,
// //           foregroundColor: Colors.white,
// //           elevation: 0,
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(8),
// //           ),
// //         ),
// //         child: const Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               "Continue",
// //               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
// //             ),
// //             SizedBox(width: 8),
// //             Icon(Icons.arrow_forward, size: 18),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// //
// //   InputDecoration inputDecoration(String hint, IconData icon) {
// //     return InputDecoration(
// //       hintText: hint,
// //       hintStyle: const TextStyle(color: subTextColor, fontSize: 14),
// //       suffixIcon: Icon(icon, color: subTextColor),
// //       filled: true,
// //       fillColor: Colors.white,
// //       enabledBorder: fieldBorder(),
// //       focusedBorder: fieldBorder(color: brown, width: 1.4),
// //     );
// //   }
// //
// //   OutlineInputBorder fieldBorder({
// //     Color color = borderColor,
// //     double width = 1,
// //   }) {
// //     return OutlineInputBorder(
// //       borderRadius: BorderRadius.circular(8),
// //       borderSide: BorderSide(color: color, width: width),
// //     );
// //   }
// // }
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// // Adjust this import path to match where booking_success_screen.dart
// // actually lives in your project structure.
// import 'Booking success screen.dart';
//
// class TempleBookingPage extends StatefulWidget {
//   final String poojaId;
//   final String poojaName;
//   final String malayalamName;
//   final int pricePerDevotee;
//
//   const TempleBookingPage({
//     super.key,
//     required this.poojaId,
//     required this.poojaName,
//     required this.malayalamName,
//     required this.pricePerDevotee,
//   });
//
//   @override
//   State<TempleBookingPage> createState() => _TempleBookingPageState();
// }
//
// class _TempleBookingPageState extends State<TempleBookingPage> {
//   static const Color brown = Color(0xFF6D3B3A);
//   static const Color darkBrown = Color(0xFF542B2A);
//   static const Color background = Color(0xFFFAF8F5);
//   static const Color borderColor = Color(0xFFE5DEDA);
//   static const Color textColor = Color(0xFF59413F);
//   static const Color subTextColor = Color(0xFF918480);
//
//   int currentStep = 0;
//
//   late DateTime selectedDate;
//
//   String selectedTime = "04:00 PM";
//   String? selectedNakshatram;
//
//   // Extra named devotees added one-by-one via the "Add Member" bottom sheet.
//   final List<Map<String, String?>> additionalMembers = [];
//
//   int paymentMethod = 0;
//
//   bool isSavingBooking = false;
//
//   final TextEditingController nameController = TextEditingController();
//
//   final TextEditingController requestController = TextEditingController();
//
//   // Nakshatram list with Malayalam name shown in brackets.
//   final Map<String, String> nakshatrams = {
//     "Ashwathi": "അശ്വതി",
//     "Bharani": "ഭരണി",
//     "Karthika": "കാർത്തിക",
//     "Rohini": "രോഹിണി",
//     "Makayiram": "മകയിരം",
//     "Thiruvathira": "തിരുവാതിര",
//     "Punartham": "പുണർതം",
//     "Pooyam": "പൂയം",
//     "Ayilyam": "ആയില്യം",
//     "Makam": "മകം",
//     "Pooram": "പൂരം",
//     "Uthram": "ഉത്രം",
//     "Atham": "അത്തം",
//     "Chithira": "ചിത്തിര",
//     "Chothi": "ചോതി",
//     "Vishakham": "വിശാഖം",
//     "Anizham": "അനിഴം",
//     "Thrikketta": "തൃക്കേട്ട",
//     "Moolam": "മൂലം",
//     "Pooradam": "പൂരാടം",
//     "Uthradam": "ഉത്രാടം",
//     "Thiruvonam": "തിരുവോണം",
//     "Avittam": "അവിട്ടം",
//     "Chathayam": "ചതയം",
//     "Pooruruttathi": "പൂരുരുട്ടാതി",
//     "Uthrattathi": "ഉത്രട്ടാതി",
//     "Revathi": "രേവതി",
//   };
//
//   String nakshatramLabel(String star) {
//     final malayalam = nakshatrams[star];
//     return malayalam == null ? star : "$star ($malayalam)";
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     selectedDate = DateTime.now();
//   }
//
//   @override
//   void dispose() {
//     nameController.dispose();
//     requestController.dispose();
//     super.dispose();
//   }
//
//   List<DateTime> get bookingDates {
//     return List.generate(
//       7,
//           (index) => DateTime.now().add(Duration(days: index)),
//     );
//   }
//
//   bool sameDate(DateTime a, DateTime b) {
//     return a.year == b.year && a.month == b.month && a.day == b.day;
//   }
//
//   String weekDay(DateTime date) {
//     const days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
//     return days[date.weekday - 1];
//   }
//
//   String formatCurrency(int amount) {
//     final str = amount.toString();
//     final buffer = StringBuffer();
//     final length = str.length;
//
//     for (int i = 0; i < length; i++) {
//       final posFromEnd = length - i;
//       buffer.write(str[i]);
//
//       // Indian-style grouping: last 3 digits, then groups of 2.
//       if (posFromEnd > 3 && (posFromEnd - 3) % 2 == 0) {
//         buffer.write(',');
//       }
//     }
//
//     return buffer.toString();
//   }
//
//   String formatDate(DateTime date) {
//     return "${date.day.toString().padLeft(2, '0')}/"
//         "${date.month.toString().padLeft(2, '0')}/"
//         "${date.year}";
//   }
//
//   Future<void> selectBookingDate() async {
//     final result = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now(),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//     );
//
//     if (result != null) {
//       setState(() {
//         selectedDate = result;
//       });
//     }
//   }
//
//   void continuePage() {
//     if (currentStep == 0) {
//       if (nameController.text.trim().isEmpty) {
//         showMessage("Enter devotee name");
//         return;
//       }
//
//       if (selectedNakshatram == null) {
//         showMessage("Select Nakshatram");
//         return;
//       }
//     }
//
//     if (currentStep < 2) {
//       setState(() {
//         currentStep++;
//       });
//     }
//   }
//
//   void previousPage() {
//     if (currentStep > 0) {
//       setState(() {
//         currentStep--;
//       });
//     } else {
//       Navigator.pop(context);
//     }
//   }
//
//   void showMessage(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }
//
//   int get devoteeCountThisBooking => additionalMembers.length;
//
//   // Total number of people this pooja is being booked for: the main
//   // devotee (always 1) plus every additional member added.
//   int get totalDevoteeCount => 1 + additionalMembers.length;
//
//   static const int convenienceFee = 20;
//
//   int get poojaAmount => totalDevoteeCount * widget.pricePerDevotee;
//
//   int get totalAmount => poojaAmount + convenienceFee;
//
//   /// Saves this booking to the `booking` collection, tagged with the
//   /// currently logged-in user's UID so it can be looked up per-user later
//   /// (e.g. to total how many devotees a user has booked over time).
//   Future<void> saveBooking() async {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       showMessage("Please log in again before paying.");
//       return;
//     }
//
//     setState(() => isSavingBooking = true);
//
//     // Payment method 0 = Cash on Delivery (pay at temple later, so the
//     // booking stays pending until admin confirms). Any other method
//     // (UPI, Card) is treated as paid upfront, so the booking is
//     // confirmed immediately.
//     final bookingStatus = paymentMethod == 0 ? 'pending' : 'confirmed';
//
//     try {
//       final docRef = await FirebaseFirestore.instance.collection('booking').add({
//         'userId': user.uid,
//         'userEmail': user.email,
//         'devoteeName': nameController.text.trim(),
//         'nakshatram': selectedNakshatram,
//         'additionalMembers': additionalMembers,
//         'devoteeCount': devoteeCountThisBooking,
//         'poojaId': widget.poojaId,
//         'poojaName': widget.poojaName,
//         'bookingDate': Timestamp.fromDate(selectedDate),
//         'bookingTime': selectedTime,
//         'specialRequest': requestController.text.trim(),
//         'paymentMethod': paymentMethod,
//         'status': bookingStatus,
//         'devoteeTotalCount': totalDevoteeCount,
//         'pricePerDevotee': widget.pricePerDevotee,
//         'amount': poojaAmount,
//         'convenienceFee': convenienceFee,
//         'totalAmount': totalAmount,
//         'createdAt': FieldValue.serverTimestamp(),
//       });
//
//       if (!mounted) return;
//
//       // Navigate to the success screen with the real booking details.
//       // BookingSuccessScreen auto-returns to Home after a couple of
//       // seconds, so no extra action is needed here.
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (_) => BookingSuccessScreen(
//             donationId: docRef.id,
//             categoryLabel: widget.poojaName,
//             categoryIcon: Icons.temple_hindu,
//             amount: "₹${formatCurrency(totalAmount)}",
//             date: formatDate(selectedDate),
//             timeSlot: selectedTime,
//           ),
//         ),
//       );
//     } catch (e) {
//       if (!mounted) return;
//       showMessage("Could not save booking. Please try again.");
//     } finally {
//       if (mounted) setState(() => isSavingBooking = false);
//     }
//   }
//
//   /// Total devotees booked by the logged-in user across all their past
//   /// bookings (sum of `devoteeCount` on every `booking` doc with their uid).
//   Stream<int> get totalDevoteesForUser {
//     final user = FirebaseAuth.instance.currentUser;
//
//     if (user == null) {
//       return Stream.value(0);
//     }
//
//     return FirebaseFirestore.instance
//         .collection('booking')
//         .where('userId', isEqualTo: user.uid)
//         .snapshots()
//         .map((snapshot) {
//       int total = 0;
//       for (final doc in snapshot.docs) {
//         final count = doc.data()['devoteeCount'];
//         if (count is int) total += count;
//       }
//       return total;
//     });
//   }
//
//   /// Opens a bottom sheet with a small form (name + nakshatram) to add
//   /// one more named devotee to this booking.
//   void showAddMemberSheet() {
//     final memberNameController = TextEditingController();
//     String? memberNakshatram;
//
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       backgroundColor: Colors.transparent,
//       builder: (sheetContext) {
//         return StatefulBuilder(
//           builder: (sheetContext, setSheetState) {
//             return Padding(
//               padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
//               ),
//               child: Container(
//                 padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Center(
//                       child: Container(
//                         width: 42,
//                         height: 4,
//                         margin: const EdgeInsets.only(bottom: 16),
//                         decoration: BoxDecoration(
//                           color: borderColor,
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                       ),
//                     ),
//                     Text(
//                       "Add Member",
//                       style: TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.w700,
//                         color: textColor,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     inputLabel("Name *"),
//                     const SizedBox(height: 7),
//                     TextField(
//                       controller: memberNameController,
//                       decoration: inputDecoration(
//                         "Enter member name",
//                         Icons.person_outline,
//                       ),
//                     ),
//                     const SizedBox(height: 16),
//                     inputLabel("Nakshatram *"),
//                     const SizedBox(height: 7),
//                     DropdownButtonFormField<String>(
//                       initialValue: memberNakshatram,
//                       isExpanded: true,
//                       hint: const Text("Select nakshatram"),
//                       decoration: InputDecoration(
//                         prefixIcon: const Icon(
//                           Icons.star_border,
//                           color: brown,
//                         ),
//                         filled: true,
//                         fillColor: Colors.white,
//                         enabledBorder: fieldBorder(),
//                         focusedBorder: fieldBorder(color: brown, width: 1.4),
//                       ),
//                       items: nakshatrams.keys.map((star) {
//                         return DropdownMenuItem(
//                           value: star,
//                           child: Text(nakshatramLabel(star)),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setSheetState(() {
//                           memberNakshatram = value;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 22),
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           final name = memberNameController.text.trim();
//
//                           if (name.isEmpty) {
//                             showMessage("Enter member name");
//                             return;
//                           }
//
//                           if (memberNakshatram == null) {
//                             showMessage("Select member's Nakshatram");
//                             return;
//                           }
//
//                           setState(() {
//                             additionalMembers.add({
//                               'name': name,
//                               'nakshatram': memberNakshatram,
//                             });
//                           });
//
//                           Navigator.pop(sheetContext);
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: brown,
//                           foregroundColor: Colors.white,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: const Text(
//                           "Add",
//                           style: TextStyle(
//                             fontSize: 15,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//   }
//
//   /// Renders the list of extra named devotees added so far, each with a
//   /// remove button.
//   Widget buildAdditionalMembersList() {
//     if (additionalMembers.isEmpty) return const SizedBox.shrink();
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const SizedBox(height: 12),
//         ...additionalMembers.asMap().entries.map((entry) {
//           final index = entry.key;
//           final member = entry.value;
//           final star = member['nakshatram'];
//
//           return Container(
//             margin: const EdgeInsets.only(bottom: 8),
//             padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(9),
//               border: Border.all(color: borderColor),
//             ),
//             child: Row(
//               children: [
//                 const Icon(Icons.person_outline, color: brown, size: 18),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         member['name'] ?? "",
//                         style: const TextStyle(
//                           color: textColor,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                         ),
//                       ),
//                       Text(
//                         star == null ? "-" : nakshatramLabel(star),
//                         style: const TextStyle(
//                           color: subTextColor,
//                           fontSize: 11,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 IconButton(
//                   padding: EdgeInsets.zero,
//                   constraints: const BoxConstraints(),
//                   onPressed: () {
//                     setState(() {
//                       additionalMembers.removeAt(index);
//                     });
//                   },
//                   icon: const Icon(
//                     Icons.close,
//                     color: subTextColor,
//                     size: 18,
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ],
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: background,
//       body: SafeArea(
//         child: Column(
//           children: [
//             buildHeader(),
//             Expanded(
//               child: AnimatedSwitcher(
//                 duration: const Duration(milliseconds: 250),
//                 child: SingleChildScrollView(
//                   key: ValueKey(currentStep),
//                   padding: const EdgeInsets.fromLTRB(20, 18, 20, 35),
//                   child: currentStep == 0
//                       ? buildDevoteePage()
//                       : currentStep == 1
//                       ? buildBookingPage()
//                       : buildPaymentPage(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ===========================================================================
//   // HEADER
//   // ===========================================================================
//
//   Widget buildHeader() {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [Color(0xFF8D2F1C), Color(0xFF703331), darkBrown],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.fromLTRB(10, 14, 17, 10),
//             child: Row(
//               children: [
//                 IconButton(
//                   onPressed: previousPage,
//                   icon: const Icon(
//                     Icons.chevron_left,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//                 const Expanded(
//                   child: Text(
//                     "Booking Details",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 21,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ),
//                 Container(
//                   width: 42,
//                   height: 42,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(color: Colors.white70),
//                   ),
//                   child: const Icon(
//                     Icons.notifications_none_rounded,
//                     color: Colors.white,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.fromLTRB(32, 3, 32, 15),
//             child: Row(
//               children: [
//                 buildStep(0, "Devotee"),
//                 Expanded(child: buildStepLine(1)),
//                 buildStep(1, "Booking"),
//                 Expanded(child: buildStepLine(2)),
//                 buildStep(2, "Payment"),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildStep(int step, String title) {
//     final bool completed = currentStep > step;
//     final bool active = currentStep == step;
//
//     return Column(
//       children: [
//         Container(
//           width: 31,
//           height: 31,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             color: completed || active
//                 ? const Color(0xFFF7F2ED)
//                 : Colors.white24,
//             border: Border.all(color: Colors.white54),
//           ),
//           child: completed
//               ? const Icon(Icons.check, color: brown, size: 17)
//               : Center(
//             child: Text(
//               "${step + 1}",
//               style: TextStyle(
//                 color: active ? brown : Colors.white54,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 5),
//         Text(
//           title,
//           style: TextStyle(
//             fontSize: 10,
//             color: active || completed ? Colors.white : Colors.white54,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildStepLine(int targetStep) {
//     final bool completed = currentStep >= targetStep;
//
//     return Container(
//       height: 2,
//       margin: const EdgeInsets.only(bottom: 17),
//       color: completed ? Colors.white : Colors.white38,
//     );
//   }
//
//   // ===========================================================================
//   // STEP 1
//   // ===========================================================================
//
//   Widget buildDevoteePage() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildPoojaCard(),
//         const SizedBox(height: 24),
//         Row(
//           children: [
//             sectionTitle("Select Date"),
//             const Spacer(),
//             InkWell(
//               onTap: selectBookingDate,
//               child: const Icon(
//                 Icons.calendar_month_outlined,
//                 color: brown,
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 14),
//         buildDateSelector(),
//         const SizedBox(height: 26),
//         sectionTitle("Time Slot"),
//         const SizedBox(height: 14),
//         Row(
//           children: [
//             Expanded(child: buildTimeSlot("04:00 PM")),
//             const SizedBox(width: 12),
//             Expanded(child: buildTimeSlot("08:00 PM")),
//           ],
//         ),
//         const SizedBox(height: 28),
//         sectionTitle("Devotee Details"),
//         const SizedBox(height: 4),
//         const Text(
//           "Please provide devotee information for the booking",
//           style: TextStyle(color: subTextColor, fontSize: 12),
//         ),
//         const SizedBox(height: 20),
//         inputLabel("Devotee Name (വഴിപാടുകാരന്റെ പേര്) *"),
//         const SizedBox(height: 7),
//         TextField(
//           controller: nameController,
//           decoration: inputDecoration(
//             "Enter devotee name",
//             Icons.person_outline,
//           ),
//         ),
//         const SizedBox(height: 20),
//         inputLabel("Nakshatram (നക്ഷത്രം) *"),
//         const SizedBox(height: 7),
//         buildNakshatramDropdown(),
//         const SizedBox(height: 32),
//         buildContinueButton(),
//       ],
//     );
//   }
//
//   Widget buildDateSelector() {
//     final dates = bookingDates;
//
//     return SizedBox(
//       height: 80,
//       child: ListView.separated(
//         scrollDirection: Axis.horizontal,
//         itemCount: dates.length,
//         separatorBuilder: (_, __) {
//           return const SizedBox(width: 8);
//         },
//         itemBuilder: (context, index) {
//           final date = dates[index];
//           final selected = sameDate(date, selectedDate);
//
//           return GestureDetector(
//             onTap: () {
//               setState(() {
//                 selectedDate = date;
//               });
//             },
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 180),
//               width: 59,
//               decoration: BoxDecoration(
//                 gradient: selected
//                     ? const LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Color(0xFF8B5553), brown],
//                 )
//                     : null,
//                 color: selected ? null : const Color(0xFFF0ECE7),
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     weekDay(date),
//                     style: TextStyle(
//                       fontSize: 10,
//                       color: selected ? Colors.white70 : subTextColor,
//                     ),
//                   ),
//                   const SizedBox(height: 4),
//                   Text(
//                     "${date.day}",
//                     style: TextStyle(
//                       fontSize: 21,
//                       fontWeight: FontWeight.w600,
//                       color: selected ? Colors.white : textColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget buildTimeSlot(String time) {
//     final bool selected = selectedTime == time;
//
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedTime = time;
//         });
//       },
//       child: Container(
//         height: 67,
//         padding: const EdgeInsets.symmetric(horizontal: 13),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(9),
//           border: Border.all(
//             color: selected ? brown : borderColor,
//             width: selected ? 1.5 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const Text(
//                     "EVENING",
//                     style: TextStyle(fontSize: 9, color: subTextColor),
//                   ),
//                   const SizedBox(height: 3),
//                   Text(
//                     time,
//                     style: const TextStyle(
//                       fontWeight: FontWeight.w600,
//                       color: textColor,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               width: 20,
//               height: 20,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(color: brown),
//               ),
//               child: selected
//                   ? const Icon(Icons.check, size: 14, color: brown)
//                   : null,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget buildNakshatramDropdown() {
//     return DropdownButtonFormField<String>(
//       initialValue: selectedNakshatram,
//       isExpanded: true,
//       hint: const Text("Select nakshatram"),
//       decoration: InputDecoration(
//         prefixIcon: const Icon(Icons.star_border, color: brown),
//         filled: true,
//         fillColor: Colors.white,
//         enabledBorder: fieldBorder(),
//         focusedBorder: fieldBorder(color: brown, width: 1.4),
//       ),
//       items: nakshatrams.keys.map((star) {
//         return DropdownMenuItem(
//           value: star,
//           child: Text(nakshatramLabel(star)),
//         );
//       }).toList(),
//       onChanged: (value) {
//         setState(() {
//           selectedNakshatram = value;
//         });
//       },
//     );
//   }
//
//   // ===========================================================================
//   // STEP 2
//   // ===========================================================================
//
//   Widget buildBookingPage() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         buildPoojaCard(),
//         const SizedBox(height: 28),
//         sectionTitle("Booking Details"),
//         const SizedBox(height: 4),
//         const Text(
//           "Confirm your preferred booking schedule",
//           style: TextStyle(color: subTextColor, fontSize: 12),
//         ),
//         const SizedBox(height: 18),
//         buildInfoBox(
//           Icons.calendar_month_outlined,
//           "Preferred Date",
//           formatDate(selectedDate),
//         ),
//         const SizedBox(height: 12),
//         buildInfoBox(Icons.access_time, "Preferred Time", selectedTime),
//         const SizedBox(height: 28),
//         sectionTitle("Devotees"),
//         const SizedBox(height: 4),
//         const Text(
//           "Add each devotee for this booking",
//           style: TextStyle(color: subTextColor, fontSize: 12),
//         ),
//         const SizedBox(height: 14),
//         // Add a named extra devotee via bottom sheet.
//         InkWell(
//           onTap: showAddMemberSheet,
//           borderRadius: BorderRadius.circular(9),
//           child: Container(
//             width: double.infinity,
//             padding: const EdgeInsets.symmetric(vertical: 12),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(9),
//               border: Border.all(color: brown, width: 1.2),
//             ),
//             child: const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.add, color: brown, size: 18),
//                 SizedBox(width: 6),
//                 Text(
//                   "Add Member",
//                   style: TextStyle(
//                     color: brown,
//                     fontWeight: FontWeight.w600,
//                     fontSize: 13,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         buildAdditionalMembersList(),
//         const SizedBox(height: 10),
//         // Total devotees the logged-in user has booked so far (all bookings).
//         StreamBuilder<int>(
//           stream: totalDevoteesForUser,
//           builder: (context, snapshot) {
//             final total = snapshot.data;
//
//             if (total == null) return const SizedBox.shrink();
//
//             return Text(
//               "Total devotees booked under your account so far: $total",
//               style: const TextStyle(
//                 color: subTextColor,
//                 fontSize: 11,
//                 fontStyle: FontStyle.italic,
//               ),
//             );
//           },
//         ),
//         const SizedBox(height: 28),
//         sectionTitle("Special Request"),
//         const SizedBox(height: 4),
//         const Text(
//           "Add any special instructions (optional)",
//           style: TextStyle(color: subTextColor, fontSize: 12),
//         ),
//         const SizedBox(height: 14),
//         TextField(
//           controller: requestController,
//           maxLines: 5,
//           maxLength: 250,
//           decoration: InputDecoration(
//             hintText: "Enter special request...",
//             filled: true,
//             fillColor: Colors.white,
//             enabledBorder: fieldBorder(),
//             focusedBorder: fieldBorder(color: brown, width: 1.4),
//           ),
//         ),
//         const SizedBox(height: 25),
//         buildContinueButton(),
//       ],
//     );
//   }
//
//   // ===========================================================================
//   // STEP 3
//   // ===========================================================================
//
//   Widget buildPaymentPage() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         sectionTitle("Review Details"),
//         const SizedBox(height: 16),
//         buildReviewCard(),
//         const SizedBox(height: 28),
//         sectionTitle("Payment Method"),
//         const SizedBox(height: 15),
//         buildPaymentTile(
//           0,
//           Icons.payments_outlined,
//           "Cash on Delivery",
//           "Pay at the temple during the pooja",
//         ),
//         const SizedBox(height: 12),
//         buildPaymentTile(
//           1,
//           Icons.account_balance_wallet_outlined,
//           "UPI",
//           "Google Pay, PhonePe, Paytm",
//         ),
//         const SizedBox(height: 28),
//         sectionTitle("Payment Summary"),
//         const SizedBox(height: 15),
//         Container(
//           padding: const EdgeInsets.all(17),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             border: Border.all(color: borderColor),
//           ),
//           child: Column(
//             children: [
//               buildSummaryRow(
//                 "Pooja Amount ($totalDevoteeCount × ₹${formatCurrency(widget.pricePerDevotee)})",
//                 "₹${formatCurrency(poojaAmount)}",
//               ),
//               const SizedBox(height: 12),
//               buildSummaryRow(
//                 "Convenience Fee",
//                 "₹${formatCurrency(convenienceFee)}",
//               ),
//               const Divider(height: 28),
//               buildSummaryRow(
//                 "Total Amount",
//                 "₹${formatCurrency(totalAmount)}",
//                 bold: true,
//               ),
//             ],
//           ),
//         ),
//         const SizedBox(height: 28),
//         SizedBox(
//           width: double.infinity,
//           height: 54,
//           child: ElevatedButton(
//             onPressed: isSavingBooking ? null : saveBooking,
//             style: ElevatedButton.styleFrom(
//               backgroundColor: brown,
//               foregroundColor: Colors.white,
//               elevation: 0,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             child: isSavingBooking
//                 ? const SizedBox(
//               width: 22,
//               height: 22,
//               child: CircularProgressIndicator(
//                 color: Colors.white,
//                 strokeWidth: 2.4,
//               ),
//             )
//                 : Text(
//               paymentMethod == 0
//                   ? "Confirm Booking (₹${formatCurrency(totalAmount)} at temple)"
//                   : "Confirm & Pay ₹${formatCurrency(totalAmount)}",
//               style: const TextStyle(
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildReviewCard() {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(17),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: borderColor),
//       ),
//       child: Column(
//         children: [
//           buildReviewRow(
//             "Devotee 1 Name",
//             nameController.text,
//           ),
//           buildReviewRow(
//             "Devotee 1 Nakshatram",
//             selectedNakshatram == null
//                 ? "-"
//                 : nakshatramLabel(selectedNakshatram!),
//           ),
//           buildReviewRow(
//             "Total Devotees",
//             "$totalDevoteeCount",
//           ),
//           if (additionalMembers.isNotEmpty)
//             ...additionalMembers.asMap().entries.expand((entry) {
//               final devoteeNumber = entry.key + 2; // main devotee is 1
//               final member = entry.value;
//               final memberStar = member['nakshatram'];
//
//               return [
//                 buildReviewRow(
//                   "Devotee $devoteeNumber Name",
//                   member['name'] ?? "-",
//                 ),
//                 buildReviewRow(
//                   "Devotee $devoteeNumber Nakshatram",
//                   memberStar == null ? "-" : nakshatramLabel(memberStar),
//                 ),
//               ];
//             }),
//           const Divider(height: 25),
//           buildReviewRow("Pooja", widget.poojaName),
//           buildReviewRow("Date", formatDate(selectedDate)),
//           buildReviewRow("Time", selectedTime),
//           if (requestController.text.trim().isNotEmpty)
//             buildReviewRow("Special Request", requestController.text),
//         ],
//       ),
//     );
//   }
//
//   Widget buildPaymentTile(
//       int index,
//       IconData icon,
//       String title,
//       String subtitle,
//       ) {
//     final bool selected = paymentMethod == index;
//
//     return InkWell(
//       onTap: () {
//         setState(() {
//           paymentMethod = index;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.all(13),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(9),
//           border: Border.all(
//             color: selected ? brown : borderColor,
//             width: selected ? 1.4 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: brown),
//             const SizedBox(width: 13),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: const TextStyle(
//                       color: textColor,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   const SizedBox(height: 2),
//                   Text(
//                     subtitle,
//                     style: const TextStyle(
//                       color: subTextColor,
//                       fontSize: 11,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Radio<int>(
//               value: index,
//               groupValue: paymentMethod,
//               activeColor: brown,
//               onChanged: (value) {
//                 setState(() {
//                   paymentMethod = value!;
//                 });
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   // ===========================================================================
//   // COMMON WIDGETS
//   // ===========================================================================
//
//   Widget buildPoojaCard() {
//     return Row(
//       children: [
//         ClipOval(
//           child: Image.asset(
//             "assets/images/pooja.jpg",
//             width: 50,
//             height: 50,
//             fit: BoxFit.cover,
//             errorBuilder: (_, __, ___) {
//               return Container(
//                 width: 50,
//                 height: 50,
//                 color: const Color(0xFFE6DDD8),
//                 child: const Icon(Icons.temple_hindu, color: brown),
//               );
//             },
//           ),
//         ),
//         const SizedBox(width: 12),
//         Expanded(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 widget.poojaName,
//                 style: const TextStyle(
//                   color: textColor,
//                   fontWeight: FontWeight.w700,
//                   fontSize: 15,
//                 ),
//               ),
//               if (widget.malayalamName.isNotEmpty)
//                 Text(
//                   widget.malayalamName,
//                   style: const TextStyle(color: subTextColor, fontSize: 10),
//                 ),
//               const SizedBox(height: 2),
//               const Text(
//                 "○ POPULAR",
//                 style: TextStyle(color: Color(0xFFD56C50), fontSize: 9),
//               ),
//             ],
//           ),
//         ),
//         Text(
//           "₹${formatCurrency(widget.pricePerDevotee)} / person",
//           style: const TextStyle(
//             color: textColor,
//             fontSize: 14,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget sectionTitle(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         fontFamily: "serif",
//         fontSize: 23,
//         fontWeight: FontWeight.w600,
//         color: textColor,
//       ),
//     );
//   }
//
//   Widget inputLabel(String title) {
//     return Text(
//       title,
//       style: const TextStyle(
//         color: Color(0xFF665451),
//         fontSize: 13,
//         fontWeight: FontWeight.w500,
//       ),
//     );
//   }
//
//   Widget buildField(IconData icon, String value) {
//     return Container(
//       width: double.infinity,
//       height: 54,
//       padding: const EdgeInsets.symmetric(horizontal: 14),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: borderColor),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: brown),
//           const SizedBox(width: 11),
//           Text(value, style: const TextStyle(color: subTextColor)),
//         ],
//       ),
//     );
//   }
//
//   Widget buildInfoBox(IconData icon, String title, String value) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.all(15),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(9),
//         border: Border.all(color: borderColor),
//       ),
//       child: Row(
//         children: [
//           Icon(icon, color: brown),
//           const SizedBox(width: 13),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: const TextStyle(
//                     color: subTextColor,
//                     fontSize: 11,
//                   ),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   value,
//                   style: const TextStyle(
//                     color: textColor,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildReviewRow(String title, String value) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 11),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             child: Text(
//               title,
//               style: const TextStyle(color: subTextColor, fontSize: 12),
//             ),
//           ),
//           const SizedBox(width: 15),
//           Flexible(
//             child: Text(
//               value,
//               textAlign: TextAlign.right,
//               style: const TextStyle(
//                 color: textColor,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 12,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget buildSummaryRow(String title, String value, {bool bold = false}) {
//     return Row(
//       children: [
//         Expanded(
//           child: Text(
//             title,
//             style: TextStyle(
//               color: textColor,
//               fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
//               fontSize: bold ? 15 : 13,
//             ),
//           ),
//         ),
//         Text(
//           value,
//           style: TextStyle(
//             color: textColor,
//             fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
//             fontSize: bold ? 16 : 13,
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget buildContinueButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 54,
//       child: ElevatedButton(
//         onPressed: continuePage,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: brown,
//           foregroundColor: Colors.white,
//           elevation: 0,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         ),
//         child: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Continue",
//               style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//             ),
//             SizedBox(width: 8),
//             Icon(Icons.arrow_forward, size: 18),
//           ],
//         ),
//       ),
//     );
//   }
//
//   InputDecoration inputDecoration(String hint, IconData icon) {
//     return InputDecoration(
//       hintText: hint,
//       hintStyle: const TextStyle(color: subTextColor, fontSize: 14),
//       suffixIcon: Icon(icon, color: subTextColor),
//       filled: true,
//       fillColor: Colors.white,
//       enabledBorder: fieldBorder(),
//       focusedBorder: fieldBorder(color: brown, width: 1.4),
//     );
//   }
//
//   OutlineInputBorder fieldBorder({
//     Color color = borderColor,
//     double width = 1,
//   }) {
//     return OutlineInputBorder(
//       borderRadius: BorderRadius.circular(8),
//       borderSide: BorderSide(color: color, width: width),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Adjust this import path to match where booking_success_screen.dart
// actually lives in your project structure.
import 'Booking success screen.dart';

class TempleBookingPage extends StatefulWidget {
  final String poojaId;
  final String poojaName;
  final String malayalamName;
  final int pricePerDevotee;

  const TempleBookingPage({
    super.key,
    required this.poojaId,
    required this.poojaName,
    required this.malayalamName,
    required this.pricePerDevotee,
  });

  @override
  State<TempleBookingPage> createState() => _TempleBookingPageState();
}

class _TempleBookingPageState extends State<TempleBookingPage> {
  static const Color brown = Color(0xFF6D3B3A);
  static const Color darkBrown = Color(0xFF542B2A);
  static const Color background = Color(0xFFFAF8F5);
  static const Color borderColor = Color(0xFFE5DEDA);
  static const Color textColor = Color(0xFF59413F);
  static const Color subTextColor = Color(0xFF918480);

  int currentStep = 0;

  late DateTime selectedDate;

  String selectedTime = "04:00 PM";
  String? selectedNakshatram;

  // Extra named devotees added one-by-one via the "Add Member" bottom sheet.
  final List<Map<String, String?>> additionalMembers = [];

  int paymentMethod = 0;

  bool isSavingBooking = false;

  final TextEditingController nameController = TextEditingController();

  final TextEditingController requestController = TextEditingController();

  // Nakshatram list with Malayalam name shown in brackets.
  final Map<String, String> nakshatrams = {
    "Ashwathi": "അശ്വതി",
    "Bharani": "ഭരണി",
    "Karthika": "കാർത്തിക",
    "Rohini": "രോഹിണി",
    "Makayiram": "മകയിരം",
    "Thiruvathira": "തിരുവാതിര",
    "Punartham": "പുണർതം",
    "Pooyam": "പൂയം",
    "Ayilyam": "ആയില്യം",
    "Makam": "മകം",
    "Pooram": "പൂരം",
    "Uthram": "ഉത്രം",
    "Atham": "അത്തം",
    "Chithira": "ചിത്തിര",
    "Chothi": "ചോതി",
    "Vishakham": "വിശാഖം",
    "Anizham": "അനിഴം",
    "Thrikketta": "തൃക്കേട്ട",
    "Moolam": "മൂലം",
    "Pooradam": "പൂരാടം",
    "Uthradam": "ഉത്രാടം",
    "Thiruvonam": "തിരുവോണം",
    "Avittam": "അവിട്ടം",
    "Chathayam": "ചതയം",
    "Pooruruttathi": "പൂരുരുട്ടാതി",
    "Uthrattathi": "ഉത്രട്ടാതി",
    "Revathi": "രേവതി",
  };

  String nakshatramLabel(String star) {
    final malayalam = nakshatrams[star];
    return malayalam == null ? star : "$star ($malayalam)";
  }

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    nameController.dispose();
    requestController.dispose();
    super.dispose();
  }

  List<DateTime> get bookingDates {
    return List.generate(
      7,
          (index) => DateTime.now().add(Duration(days: index)),
    );
  }

  bool sameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  String weekDay(DateTime date) {
    const days = ["MON", "TUE", "WED", "THU", "FRI", "SAT", "SUN"];
    return days[date.weekday - 1];
  }

  String formatCurrency(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    final length = str.length;

    for (int i = 0; i < length; i++) {
      final posFromEnd = length - i;
      buffer.write(str[i]);

      // Indian-style grouping: last 3 digits, then groups of 2.
      if (posFromEnd > 3 && (posFromEnd - 3) % 2 == 0) {
        buffer.write(',');
      }
    }

    return buffer.toString();
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }

  Future<void> selectBookingDate() async {
    final result = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (result != null) {
      setState(() {
        selectedDate = result;
      });
    }
  }

  void continuePage() {
    if (currentStep == 0) {
      if (nameController.text.trim().isEmpty) {
        showMessage("Enter devotee name");
        return;
      }

      if (selectedNakshatram == null) {
        showMessage("Select Nakshatram");
        return;
      }
    }

    if (currentStep < 2) {
      setState(() {
        currentStep++;
      });
    }
  }

  void previousPage() {
    if (currentStep > 0) {
      setState(() {
        currentStep--;
      });
    } else {
      Navigator.pop(context);
    }
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  int get devoteeCountThisBooking => additionalMembers.length;

  // Total number of people this pooja is being booked for: the main
  // devotee (always 1) plus every additional member added.
  int get totalDevoteeCount => 1 + additionalMembers.length;

  static const int convenienceFee = 20;

  int get poojaAmount => totalDevoteeCount * widget.pricePerDevotee;

  int get totalAmount => poojaAmount + convenienceFee;

  /// Saves this booking to the `booking` collection, tagged with the
  /// currently logged-in user's UID so it can be looked up per-user later
  /// (e.g. to total how many devotees a user has booked over time).
  ///
  /// Also writes a companion doc to `admin_notifications` so admin screens
  /// can listen for new bookings and show a badge / alert.
  Future<void> saveBooking() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      showMessage("Please log in again before paying.");
      return;
    }

    setState(() => isSavingBooking = true);

    // Payment method 0 = Cash on Delivery (pay at temple later, so the
    // booking stays pending until admin confirms). Any other method
    // (UPI, Card) is treated as paid upfront, so the booking is
    // confirmed immediately.
    final bookingStatus = paymentMethod == 0 ? 'pending' : 'confirmed';
    final devoteeName = nameController.text.trim();

    try {
      final docRef = await FirebaseFirestore.instance.collection('booking').add({
        'userId': user.uid,
        'userEmail': user.email,
        'devoteeName': devoteeName,
        'nakshatram': selectedNakshatram,
        'additionalMembers': additionalMembers,
        'devoteeCount': devoteeCountThisBooking,
        'poojaId': widget.poojaId,
        'poojaName': widget.poojaName,
        'bookingDate': Timestamp.fromDate(selectedDate),
        'bookingTime': selectedTime,
        'specialRequest': requestController.text.trim(),
        'paymentMethod': paymentMethod,
        'status': bookingStatus,
        'devoteeTotalCount': totalDevoteeCount,
        'pricePerDevotee': widget.pricePerDevotee,
        'amount': poojaAmount,
        'convenienceFee': convenienceFee,
        'totalAmount': totalAmount,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Notify admins: create a companion doc in `admin_notifications`.
      // Kept as a separate write (not a transaction) so a failure here
      // never blocks the booking itself from succeeding.
      try {
        await FirebaseFirestore.instance.collection('admin_notifications').add({
          'type': 'booking',
          'bookingId': docRef.id,
          'title': 'New Pooja Booking',
          'message':
          '$devoteeName booked ${widget.poojaName} for '
              '${formatDate(selectedDate)} at $selectedTime',
          'userId': user.uid,
          'userEmail': user.email,
          'poojaId': widget.poojaId,
          'poojaName': widget.poojaName,
          'devoteeName': devoteeName,
          'devoteeTotalCount': totalDevoteeCount,
          'totalAmount': totalAmount,
          'status': bookingStatus, // 'pending' or 'confirmed'
          'isRead': false,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (notifyError) {
        // Swallow notification errors — the booking itself already
        // succeeded, so we don't want to block the user's flow.
        debugPrint('Failed to create admin notification: $notifyError');
      }

      if (!mounted) return;

      // Navigate to the success screen with the real booking details.
      // BookingSuccessScreen auto-returns to Home after a couple of
      // seconds, so no extra action is needed here.
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => BookingSuccessScreen(
            donationId: docRef.id,
            categoryLabel: widget.poojaName,
            categoryIcon: Icons.temple_hindu,
            amount: "₹${formatCurrency(totalAmount)}",
            date: formatDate(selectedDate),
            timeSlot: selectedTime,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      showMessage("Could not save booking. Please try again.");
    } finally {
      if (mounted) setState(() => isSavingBooking = false);
    }
  }

  /// Total devotees booked by the logged-in user across all their past
  /// bookings (sum of `devoteeCount` on every `booking` doc with their uid).
  Stream<int> get totalDevoteesForUser {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Stream.value(0);
    }

    return FirebaseFirestore.instance
        .collection('booking')
        .where('userId', isEqualTo: user.uid)
        .snapshots()
        .map((snapshot) {
      int total = 0;
      for (final doc in snapshot.docs) {
        final count = doc.data()['devoteeCount'];
        if (count is int) total += count;
      }
      return total;
    });
  }

  /// Opens a bottom sheet with a small form (name + nakshatram) to add
  /// one more named devotee to this booking.
  void showAddMemberSheet() {
    final memberNameController = TextEditingController();
    String? memberNakshatram;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (sheetContext, setSheetState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(sheetContext).viewInsets.bottom,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        width: 42,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: borderColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                    Text(
                      "Add Member",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    inputLabel("Name *"),
                    const SizedBox(height: 7),
                    TextField(
                      controller: memberNameController,
                      decoration: inputDecoration(
                        "Enter member name",
                        Icons.person_outline,
                      ),
                    ),
                    const SizedBox(height: 16),
                    inputLabel("Nakshatram *"),
                    const SizedBox(height: 7),
                    DropdownButtonFormField<String>(
                      initialValue: memberNakshatram,
                      isExpanded: true,
                      hint: const Text("Select nakshatram"),
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.star_border,
                          color: brown,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: fieldBorder(),
                        focusedBorder: fieldBorder(color: brown, width: 1.4),
                      ),
                      items: nakshatrams.keys.map((star) {
                        return DropdownMenuItem(
                          value: star,
                          child: Text(nakshatramLabel(star)),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setSheetState(() {
                          memberNakshatram = value;
                        });
                      },
                    ),
                    const SizedBox(height: 22),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          final name = memberNameController.text.trim();

                          if (name.isEmpty) {
                            showMessage("Enter member name");
                            return;
                          }

                          if (memberNakshatram == null) {
                            showMessage("Select member's Nakshatram");
                            return;
                          }

                          setState(() {
                            additionalMembers.add({
                              'name': name,
                              'nakshatram': memberNakshatram,
                            });
                          });

                          Navigator.pop(sheetContext);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brown,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Add",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Renders the list of extra named devotees added so far, each with a
  /// remove button.
  Widget buildAdditionalMembersList() {
    if (additionalMembers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        ...additionalMembers.asMap().entries.map((entry) {
          final index = entry.key;
          final member = entry.value;
          final star = member['nakshatram'];

          return Container(
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: borderColor),
            ),
            child: Row(
              children: [
                const Icon(Icons.person_outline, color: brown, size: 18),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        member['name'] ?? "",
                        style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      Text(
                        star == null ? "-" : nakshatramLabel(star),
                        style: const TextStyle(
                          color: subTextColor,
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {
                    setState(() {
                      additionalMembers.removeAt(index);
                    });
                  },
                  icon: const Icon(
                    Icons.close,
                    color: subTextColor,
                    size: 18,
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Column(
          children: [
            buildHeader(),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 250),
                child: SingleChildScrollView(
                  key: ValueKey(currentStep),
                  padding: const EdgeInsets.fromLTRB(20, 18, 20, 35),
                  child: currentStep == 0
                      ? buildDevoteePage()
                      : currentStep == 1
                      ? buildBookingPage()
                      : buildPaymentPage(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // HEADER
  // ===========================================================================

  Widget buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF8D2F1C), Color(0xFF703331), darkBrown],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 14, 17, 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: previousPage,
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                const Expanded(
                  child: Text(
                    "Booking Details",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white70),
                  ),
                  child: const Icon(
                    Icons.notifications_none_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 3, 32, 15),
            child: Row(
              children: [
                buildStep(0, "Devotee"),
                Expanded(child: buildStepLine(1)),
                buildStep(1, "Booking"),
                Expanded(child: buildStepLine(2)),
                buildStep(2, "Payment"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStep(int step, String title) {
    final bool completed = currentStep > step;
    final bool active = currentStep == step;

    return Column(
      children: [
        Container(
          width: 31,
          height: 31,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: completed || active
                ? const Color(0xFFF7F2ED)
                : Colors.white24,
            border: Border.all(color: Colors.white54),
          ),
          child: completed
              ? const Icon(Icons.check, color: brown, size: 17)
              : Center(
            child: Text(
              "${step + 1}",
              style: TextStyle(
                color: active ? brown : Colors.white54,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: TextStyle(
            fontSize: 10,
            color: active || completed ? Colors.white : Colors.white54,
          ),
        ),
      ],
    );
  }

  Widget buildStepLine(int targetStep) {
    final bool completed = currentStep >= targetStep;

    return Container(
      height: 2,
      margin: const EdgeInsets.only(bottom: 17),
      color: completed ? Colors.white : Colors.white38,
    );
  }

  // ===========================================================================
  // STEP 1
  // ===========================================================================

  Widget buildDevoteePage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPoojaCard(),
        const SizedBox(height: 24),
        Row(
          children: [
            sectionTitle("Select Date"),
            const Spacer(),
            InkWell(
              onTap: selectBookingDate,
              child: const Icon(
                Icons.calendar_month_outlined,
                color: brown,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        buildDateSelector(),
        const SizedBox(height: 26),
        sectionTitle("Time Slot"),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(child: buildTimeSlot("04:00 PM")),
            const SizedBox(width: 12),
            Expanded(child: buildTimeSlot("08:00 PM")),
          ],
        ),
        const SizedBox(height: 28),
        sectionTitle("Devotee Details"),
        const SizedBox(height: 4),
        const Text(
          "Please provide devotee information for the booking",
          style: TextStyle(color: subTextColor, fontSize: 12),
        ),
        const SizedBox(height: 20),
        inputLabel("Devotee Name (വഴിപാടുകാരന്റെ പേര്) *"),
        const SizedBox(height: 7),
        TextField(
          controller: nameController,
          decoration: inputDecoration(
            "Enter devotee name",
            Icons.person_outline,
          ),
        ),
        const SizedBox(height: 20),
        inputLabel("Nakshatram (നക്ഷത്രം) *"),
        const SizedBox(height: 7),
        buildNakshatramDropdown(),
        const SizedBox(height: 32),
        buildContinueButton(),
      ],
    );
  }

  Widget buildDateSelector() {
    final dates = bookingDates;

    return SizedBox(
      height: 80,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: dates.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 8);
        },
        itemBuilder: (context, index) {
          final date = dates[index];
          final selected = sameDate(date, selectedDate);

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = date;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 59,
              decoration: BoxDecoration(
                gradient: selected
                    ? const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF8B5553), brown],
                )
                    : null,
                color: selected ? null : const Color(0xFFF0ECE7),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    weekDay(date),
                    style: TextStyle(
                      fontSize: 10,
                      color: selected ? Colors.white70 : subTextColor,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "${date.day}",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                      color: selected ? Colors.white : textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildTimeSlot(String time) {
    final bool selected = selectedTime == time;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;
        });
      },
      child: Container(
        height: 67,
        padding: const EdgeInsets.symmetric(horizontal: 13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected ? brown : borderColor,
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "EVENING",
                    style: TextStyle(fontSize: 9, color: subTextColor),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    time,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: brown),
              ),
              child: selected
                  ? const Icon(Icons.check, size: 14, color: brown)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildNakshatramDropdown() {
    return DropdownButtonFormField<String>(
      initialValue: selectedNakshatram,
      isExpanded: true,
      hint: const Text("Select nakshatram"),
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.star_border, color: brown),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: fieldBorder(),
        focusedBorder: fieldBorder(color: brown, width: 1.4),
      ),
      items: nakshatrams.keys.map((star) {
        return DropdownMenuItem(
          value: star,
          child: Text(nakshatramLabel(star)),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          selectedNakshatram = value;
        });
      },
    );
  }

  // ===========================================================================
  // STEP 2
  // ===========================================================================

  Widget buildBookingPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildPoojaCard(),
        const SizedBox(height: 28),
        sectionTitle("Booking Details"),
        const SizedBox(height: 4),
        const Text(
          "Confirm your preferred booking schedule",
          style: TextStyle(color: subTextColor, fontSize: 12),
        ),
        const SizedBox(height: 18),
        buildInfoBox(
          Icons.calendar_month_outlined,
          "Preferred Date",
          formatDate(selectedDate),
        ),
        const SizedBox(height: 12),
        buildInfoBox(Icons.access_time, "Preferred Time", selectedTime),
        const SizedBox(height: 28),
        sectionTitle("Devotees"),
        const SizedBox(height: 4),
        const Text(
          "Add each devotee for this booking",
          style: TextStyle(color: subTextColor, fontSize: 12),
        ),
        const SizedBox(height: 14),
        // Add a named extra devotee via bottom sheet.
        InkWell(
          onTap: showAddMemberSheet,
          borderRadius: BorderRadius.circular(9),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: brown, width: 1.2),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, color: brown, size: 18),
                SizedBox(width: 6),
                Text(
                  "Add Member",
                  style: TextStyle(
                    color: brown,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ),
        buildAdditionalMembersList(),
        const SizedBox(height: 10),
        // Total devotees the logged-in user has booked so far (all bookings).
        StreamBuilder<int>(
          stream: totalDevoteesForUser,
          builder: (context, snapshot) {
            final total = snapshot.data;

            if (total == null) return const SizedBox.shrink();

            return Text(
              "Total devotees booked under your account so far: $total",
              style: const TextStyle(
                color: subTextColor,
                fontSize: 11,
                fontStyle: FontStyle.italic,
              ),
            );
          },
        ),
        const SizedBox(height: 28),
        sectionTitle("Special Request"),
        const SizedBox(height: 4),
        const Text(
          "Add any special instructions (optional)",
          style: TextStyle(color: subTextColor, fontSize: 12),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: requestController,
          maxLines: 5,
          maxLength: 250,
          decoration: InputDecoration(
            hintText: "Enter special request...",
            filled: true,
            fillColor: Colors.white,
            enabledBorder: fieldBorder(),
            focusedBorder: fieldBorder(color: brown, width: 1.4),
          ),
        ),
        const SizedBox(height: 25),
        buildContinueButton(),
      ],
    );
  }

  // ===========================================================================
  // STEP 3
  // ===========================================================================

  Widget buildPaymentPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sectionTitle("Review Details"),
        const SizedBox(height: 16),
        buildReviewCard(),
        const SizedBox(height: 28),
        sectionTitle("Payment Method"),
        const SizedBox(height: 15),
        buildPaymentTile(
          0,
          Icons.payments_outlined,
          "Cash on Delivery",
          "Pay at the temple during the pooja",
        ),
        const SizedBox(height: 12),
        buildPaymentTile(
          1,
          Icons.account_balance_wallet_outlined,
          "UPI",
          "Google Pay, PhonePe, Paytm",
        ),
        const SizedBox(height: 28),
        sectionTitle("Payment Summary"),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.all(17),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor),
          ),
          child: Column(
            children: [
              buildSummaryRow(
                "Pooja Amount ($totalDevoteeCount × ₹${formatCurrency(widget.pricePerDevotee)})",
                "₹${formatCurrency(poojaAmount)}",
              ),
              const SizedBox(height: 12),
              buildSummaryRow(
                "Convenience Fee",
                "₹${formatCurrency(convenienceFee)}",
              ),
              const Divider(height: 28),
              buildSummaryRow(
                "Total Amount",
                "₹${formatCurrency(totalAmount)}",
                bold: true,
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton(
            onPressed: isSavingBooking ? null : saveBooking,
            style: ElevatedButton.styleFrom(
              backgroundColor: brown,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: isSavingBooking
                ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2.4,
              ),
            )
                : Text(
              paymentMethod == 0
                  ? "Confirm Booking (₹${formatCurrency(totalAmount)} at temple)"
                  : "Confirm & Pay ₹${formatCurrency(totalAmount)}",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildReviewCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        children: [
          buildReviewRow(
            "Devotee 1 Name",
            nameController.text,
          ),
          buildReviewRow(
            "Devotee 1 Nakshatram",
            selectedNakshatram == null
                ? "-"
                : nakshatramLabel(selectedNakshatram!),
          ),
          buildReviewRow(
            "Total Devotees",
            "$totalDevoteeCount",
          ),
          if (additionalMembers.isNotEmpty)
            ...additionalMembers.asMap().entries.expand((entry) {
              final devoteeNumber = entry.key + 2; // main devotee is 1
              final member = entry.value;
              final memberStar = member['nakshatram'];

              return [
                buildReviewRow(
                  "Devotee $devoteeNumber Name",
                  member['name'] ?? "-",
                ),
                buildReviewRow(
                  "Devotee $devoteeNumber Nakshatram",
                  memberStar == null ? "-" : nakshatramLabel(memberStar),
                ),
              ];
            }),
          const Divider(height: 25),
          buildReviewRow("Pooja", widget.poojaName),
          buildReviewRow("Date", formatDate(selectedDate)),
          buildReviewRow("Time", selectedTime),
          if (requestController.text.trim().isNotEmpty)
            buildReviewRow("Special Request", requestController.text),
        ],
      ),
    );
  }

  Widget buildPaymentTile(
      int index,
      IconData icon,
      String title,
      String subtitle,
      ) {
    final bool selected = paymentMethod == index;

    return InkWell(
      onTap: () {
        setState(() {
          paymentMethod = index;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected ? brown : borderColor,
            width: selected ? 1.4 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: brown),
            const SizedBox(width: 13),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: subTextColor,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
            Radio<int>(
              value: index,
              groupValue: paymentMethod,
              activeColor: brown,
              onChanged: (value) {
                setState(() {
                  paymentMethod = value!;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // COMMON WIDGETS
  // ===========================================================================

  Widget buildPoojaCard() {
    return Row(
      children: [
        ClipOval(
          child: Image.asset(
            "assets/images/pooja.jpg",
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Container(
                width: 50,
                height: 50,
                color: const Color(0xFFE6DDD8),
                child: const Icon(Icons.temple_hindu, color: brown),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.poojaName,
                style: const TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              if (widget.malayalamName.isNotEmpty)
                Text(
                  widget.malayalamName,
                  style: const TextStyle(color: subTextColor, fontSize: 10),
                ),
              const SizedBox(height: 2),
              const Text(
                "○ POPULAR",
                style: TextStyle(color: Color(0xFFD56C50), fontSize: 9),
              ),
            ],
          ),
        ),
        Text(
          "₹${formatCurrency(widget.pricePerDevotee)} / person",
          style: const TextStyle(
            color: textColor,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontFamily: "serif",
        fontSize: 23,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),
    );
  }

  Widget inputLabel(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Color(0xFF665451),
        fontSize: 13,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget buildField(IconData icon, String value) {
    return Container(
      width: double.infinity,
      height: 54,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: brown),
          const SizedBox(width: 11),
          Text(value, style: const TextStyle(color: subTextColor)),
        ],
      ),
    );
  }

  Widget buildInfoBox(IconData icon, String title, String value) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Icon(icon, color: brown),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: subTextColor,
                    fontSize: 11,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReviewRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 11),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(color: subTextColor, fontSize: 12),
            ),
          ),
          const SizedBox(width: 15),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: textColor,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSummaryRow(String title, String value, {bool bold = false}) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
              fontSize: bold ? 15 : 13,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: textColor,
            fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
            fontSize: bold ? 16 : 13,
          ),
        ),
      ],
    );
  }

  Widget buildContinueButton() {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        onPressed: continuePage,
        style: ElevatedButton.styleFrom(
          backgroundColor: brown,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Continue",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 18),
          ],
        ),
      ),
    );
  }

  InputDecoration inputDecoration(String hint, IconData icon) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: subTextColor, fontSize: 14),
      suffixIcon: Icon(icon, color: subTextColor),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: fieldBorder(),
      focusedBorder: fieldBorder(color: brown, width: 1.4),
    );
  }

  OutlineInputBorder fieldBorder({
    Color color = borderColor,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}