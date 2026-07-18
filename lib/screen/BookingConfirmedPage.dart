import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BookingConfirmedPage extends StatelessWidget {
  const BookingConfirmedPage({super.key});

  static const Color primaryColor = Color(0xFF8D1B4D);
  static const Color secondaryColor = Color(0xFFB13A67);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: const Color(0xFFFDFCF9),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.07),

                      // SUCCESS ICON
                      Container(
                        width: 72,
                        height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.green,
                            width: 2.5,
                          ),
                        ),
                        child: const Icon(
                          Icons.check,
                          size: 40,
                          color: Colors.green,
                        ),
                      ),

                      const SizedBox(height: 24),

                      // TITLE
                      const Text(
                        "Booking Confirmed!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF292929),
                        ),
                      ),

                      const SizedBox(height: 7),

                      // SUBTITLE
                      Text(
                        "Your pooja has been successfully booked",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // BOOKING ID CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 22,
                          horizontal: 15,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF7A1646),
                              Color(0xFFB83D69),
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(9),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.08),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            const Text(
                              "BOOKING ID",
                              style: TextStyle(
                                color: Color(0xFFFFC85A),
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "POOJA202505230001",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(width: 10),

                                InkWell(
                                  onTap: () {
                                    Clipboard.setData(
                                      const ClipboardData(
                                        text: "POOJA202505230001",
                                      ),
                                    );

                                    Get.snackbar(
                                      "Copied",
                                      "Booking ID copied successfully",
                                      snackPosition: SnackPosition.BOTTOM,
                                      margin: const EdgeInsets.all(15),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.copy_outlined,
                                    color: Colors.white,
                                    size: 19,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 30),

                      // POOJA DETAILS CARD
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(.03),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // POOJA IMAGE
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                "assets/images/kuttichathan.png",
                                width: 68,
                                height: 68,
                                fit: BoxFit.cover,
                                errorBuilder: (_, __, ___) {
                                  return Container(
                                    width: 68,
                                    height: 68,
                                    color: Colors.grey.shade200,
                                    child: const Icon(
                                      Icons.temple_hindu,
                                      color: primaryColor,
                                    ),
                                  );
                                },
                              ),
                            ),

                            const SizedBox(width: 14),

                            // POOJA DETAILS
                            const Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Kuttichathan Vellatt",
                                    style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF303030),
                                    ),
                                  ),

                                  SizedBox(height: 7),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_month_outlined,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "23 May 2025, Saturday",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time,
                                        size: 15,
                                        color: Colors.grey,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        "04:00 PM - 06:00 PM",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 34),

                      // BLESSING MESSAGE
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.volunteer_activism,
                              color: primaryColor,
                              size: 27,
                            ),

                            const SizedBox(width: 14),

                            Expanded(
                              child: Text(
                                "May Kuttichathan Swami bless you\n"
                                    "and your family with peace,\n"
                                    "prosperity and happiness.",
                                style: TextStyle(
                                  fontSize: 14,
                                  height: 1.6,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),
                    ],
                  ),
                ),
              ),

              // BOTTOM BUTTONS
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 15,
                ),
                child: Row(
                  children: [
                    // VIEW BOOKING BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: OutlinedButton(
                          onPressed: () {
                            // Get.to(() => MyBookingsPage());
                          },
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: Colors.grey.shade300,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            "View Booking",
                            style: TextStyle(
                              color: Color(0xFF555555),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 14),

                    // HOME BUTTON
                    Expanded(
                      child: SizedBox(
                        height: 52,
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [
                                primaryColor,
                                secondaryColor,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ElevatedButton(
                            onPressed: () {
                              // Get.offAll(() => HomePage());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              "Home",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}