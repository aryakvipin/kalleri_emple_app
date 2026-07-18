// // // // import 'dart:async';
// // // // import 'package:flutter/material.dart';
// // // //
// // // // class MostBookedSection extends StatefulWidget {
// // // //   const MostBookedSection({super.key});
// // // //
// // // //   @override
// // // //   State<MostBookedSection> createState() => _MostBookedSectionState();
// // // // }
// // // //
// // // // class _MostBookedSectionState extends State<MostBookedSection> {
// // // //   static const Color maroon = Color(0xFF750B0B);
// // // //
// // // //   Timer? _timer;
// // // //   int _currentIndex = 0;
// // // //
// // // //   final List<MostBookedModel> items = const [
// // // //     MostBookedModel(
// // // //       title: "KUTTICHATHAN VELLAT",
// // // //       malayalam: "കുട്ടിച്ചാത്തൻ വെള്ളാട്ട്",
// // // //     ),
// // // //     MostBookedModel(
// // // //       title: "GULIKAN VELLAT",
// // // //       malayalam: "ഗുളികൻ വെള്ളാട്ട്",
// // // //     ),
// // // //     MostBookedModel(
// // // //       title: "PAYASA DHANAM",
// // // //       malayalam: "പായസ ദാനം",
// // // //     ),
// // // //     MostBookedModel(
// // // //       title: "GANAPATHI HOMAM",
// // // //       malayalam: "ഗണപതി ഹോമം",
// // // //     ),
// // // //     MostBookedModel(
// // // //       title: "VALA (GOLD 1)",
// // // //       malayalam: "വള സ്വർണം",
// // // //     ),
// // // //   ];
// // // //
// // // //   @override
// // // //   void initState() {
// // // //     super.initState();
// // // //     _startTimer();
// // // //   }
// // // //
// // // //   void _startTimer() {
// // // //     _timer?.cancel();
// // // //
// // // //     _timer = Timer.periodic(
// // // //       const Duration(seconds: 3),
// // // //           (_) {
// // // //         if (!mounted) return;
// // // //
// // // //         setState(() {
// // // //           _currentIndex = (_currentIndex + 1) % items.length;
// // // //         });
// // // //       },
// // // //     );
// // // //   }
// // // //
// // // //   void _selectItem(int index) {
// // // //     setState(() {
// // // //       _currentIndex = index;
// // // //     });
// // // //
// // // //     _startTimer();
// // // //   }
// // // //
// // // //   @override
// // // //   void dispose() {
// // // //     _timer?.cancel();
// // // //     super.dispose();
// // // //   }
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return Padding(
// // // //       padding: const EdgeInsets.symmetric(horizontal: 14),
// // // //       child: Column(
// // // //         crossAxisAlignment: CrossAxisAlignment.start,
// // // //         children: [
// // // //           const Text(
// // // //             "Most Booked",
// // // //             style: TextStyle(
// // // //               color: maroon,
// // // //               fontSize: 16,
// // // //               fontWeight: FontWeight.w700,
// // // //             ),
// // // //           ),
// // // //
// // // //           const SizedBox(height: 12),
// // // //
// // // //           SizedBox(
// // // //             height: 230,
// // // //             child: LayoutBuilder(
// // // //               builder: (context, constraints) {
// // // //                 final double width = constraints.maxWidth;
// // // //
// // // //                 // Target design proportions.
// // // //
// // // //                 final double imageAreaWidth = width * 0.40;
// // // //
// // // //                 final double curveAreaWidth = width * 0.13;
// // // //
// // // //                 // Curve sits close to image.
// // // //
// // // //                 final double curveLeft =
// // // //                     imageAreaWidth - 24;
// // // //
// // // //                 // Text starts after curve.
// // // //
// // // //                 final double textLeft =
// // // //                     imageAreaWidth + curveAreaWidth - 10;
// // // //
// // // //                 return Stack(
// // // //                   clipBehavior: Clip.none,
// // // //                   children: [
// // // //                     // =================================================
// // // //                     // IMAGE
// // // //                     // =================================================
// // // //
// // // //                     Positioned(
// // // //                       left: -14,
// // // //                       top: 0,
// // // //                       width: imageAreaWidth + 14,
// // // //                       height: 230,
// // // //                       child: ClipPath(
// // // //                         clipper: const _TargetImageClipper(),
// // // //                         child: Image.asset(
// // // //                           "assets/images/b09c2b74728d9dda1731306dcdf5ee76 2.png",
// // // //                           fit: BoxFit.cover,
// // // //                           alignment: Alignment.center,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //
// // // //                     // =================================================
// // // //                     // CURVE + BULLETS + LINES
// // // //                     // =================================================
// // // //
// // // //                     Positioned(
// // // //                       left: curveLeft,
// // // //                       top: 0,
// // // //                       width: curveAreaWidth + 28,
// // // //                       height: 230,
// // // //                       child: CustomPaint(
// // // //                         painter: _TargetCurvePainter(
// // // //                           itemCount: items.length,
// // // //                           selectedIndex: _currentIndex,
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //
// // // //                     // =================================================
// // // //                     // TEXT
// // // //                     // =================================================
// // // //
// // // //                     Positioned(
// // // //                       left: textLeft,
// // // //                       right: 21,
// // // //                       top: 0,
// // // //                       height: 230,
// // // //                       child: Column(
// // // //                         children: List.generate(
// // // //                           items.length,
// // // //                               (index) {
// // // //                             final MostBookedModel item = items[index];
// // // //
// // // //                             final bool selected =
// // // //                                 index == _currentIndex;
// // // //
// // // //                             return Expanded(
// // // //                               child: GestureDetector(
// // // //                                 behavior: HitTestBehavior.opaque,
// // // //                                 onTap: () => _selectItem(index),
// // // //                                 child: Align(
// // // //                                   alignment: Alignment.centerLeft,
// // // //                                   child: AnimatedOpacity(
// // // //                                     duration: const Duration(
// // // //                                       milliseconds: 300,
// // // //                                     ),
// // // //                                     opacity: selected ? 1 : 0.85,
// // // //                                     child: Column(
// // // //                                       mainAxisSize: MainAxisSize.min,
// // // //                                       crossAxisAlignment:
// // // //                                       CrossAxisAlignment.start,
// // // //                                       children: [
// // // //                                         Text(
// // // //                                           item.title,
// // // //                                           maxLines: 1,
// // // //                                           overflow: TextOverflow.ellipsis,
// // // //                                           style: TextStyle(
// // // //                                             fontSize: 8.5,
// // // //                                             height: 1,
// // // //                                             color: Colors.black87,
// // // //                                             fontWeight: selected
// // // //                                                 ? FontWeight.w600
// // // //                                                 : FontWeight.w400,
// // // //                                           ),
// // // //                                         ),
// // // //
// // // //                                         const SizedBox(height: 4),
// // // //
// // // //                                         Text(
// // // //                                           item.malayalam,
// // // //                                           maxLines: 1,
// // // //                                           overflow: TextOverflow.ellipsis,
// // // //                                           style: const TextStyle(
// // // //                                             fontSize: 7.5,
// // // //                                             height: 1,
// // // //                                             color: Colors.black87,
// // // //                                           ),
// // // //                                         ),
// // // //                                       ],
// // // //                                     ),
// // // //                                   ),
// // // //                                 ),
// // // //                               ),
// // // //                             );
// // // //                           },
// // // //                         ),
// // // //                       ),
// // // //                     ),
// // // //
// // // //                     // =================================================
// // // //                     // RIGHT INDICATOR
// // // //                     // =================================================
// // // //
// // // //                     Positioned(
// // // //                       right: 0,
// // // //                       top: 0,
// // // //                       bottom: 0,
// // // //                       child: _MostBookedIndicator(
// // // //                         count: items.length,
// // // //                         selectedIndex: _currentIndex,
// // // //                         onTap: _selectItem,
// // // //                       ),
// // // //                     ),
// // // //                   ],
// // // //                 );
// // // //               },
// // // //             ),
// // // //           ),
// // // //         ],
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // //
// // // // // =============================================================
// // // // // IMAGE SHAPE
// // // // // =============================================================
// // // //
// // // // class _TargetImageClipper extends CustomClipper<Path> {
// // // //   const _TargetImageClipper();
// // // //
// // // //   @override
// // // //   Path getClip(Size size) {
// // // //     final Path path = Path();
// // // //
// // // //     /*
// // // //        TARGET SHAPE
// // // //
// // // //        │\
// // // //        │ \
// // // //        │  )
// // // //        │  )
// // // //        │ /
// // // //        │/
// // // //
// // // //        Rounded U/D shape on right side.
// // // //     */
// // // //
// // // //     final double startX = size.width * 0.15;
// // // //
// // // //     final double bulgeX = size.width * 1.05;
// // // //
// // // //     path.moveTo(0, 0);
// // // //
// // // //     path.lineTo(
// // // //       startX,
// // // //       0,
// // // //     );
// // // //
// // // //     path.cubicTo(
// // // //       bulgeX,
// // // //       0,
// // // //       bulgeX,
// // // //       size.height,
// // // //       startX,
// // // //       size.height,
// // // //     );
// // // //
// // // //     path.lineTo(
// // // //       0,
// // // //       size.height,
// // // //     );
// // // //
// // // //     path.close();
// // // //
// // // //     return path;
// // // //   }
// // // //
// // // //   @override
// // // //   bool shouldReclip(
// // // //       covariant _TargetImageClipper oldClipper,
// // // //       ) {
// // // //     return false;
// // // //   }
// // // // }
// // // //
// // // // // =============================================================
// // // // // CURVE + BULLETS
// // // // // =============================================================
// // // //
// // // // class _TargetCurvePainter extends CustomPainter {
// // // //   final int itemCount;
// // // //   final int selectedIndex;
// // // //
// // // //   const _TargetCurvePainter({
// // // //     required this.itemCount,
// // // //     required this.selectedIndex,
// // // //   });
// // // //
// // // //   static const Color maroon = Color(0xFF750B0B);
// // // //
// // // //   @override
// // // //   void paint(Canvas canvas, Size size) {
// // // //     final Paint curvePaint = Paint()
// // // //       ..color = maroon
// // // //       ..style = PaintingStyle.stroke
// // // //       ..strokeWidth = 3
// // // //       ..strokeCap = StrokeCap.round;
// // // //
// // // //     final Paint bulletPaint = Paint()
// // // //       ..color = maroon
// // // //       ..style = PaintingStyle.fill;
// // // //
// // // //     final Paint connectorPaint = Paint()
// // // //       ..color = maroon.withOpacity(0.55)
// // // //       ..strokeWidth = 1
// // // //       ..strokeCap = StrokeCap.round;
// // // //
// // // //     /*
// // // //        Narrow rounded curve close to image.
// // // //     */
// // // //
// // // //     final Offset start = const Offset(
// // // //       0,
// // // //       3,
// // // //     );
// // // //
// // // //     final Offset control1 = Offset(
// // // //       size.width * 1.28,
// // // //       3,
// // // //     );
// // // //
// // // //     final Offset control2 = Offset(
// // // //       size.width * 1.28,
// // // //       size.height - 3,
// // // //     );
// // // //
// // // //     final Offset end = Offset(
// // // //       0,
// // // //       size.height - 3,
// // // //     );
// // // //
// // // //     final Path curve = Path()
// // // //       ..moveTo(
// // // //         start.dx,
// // // //         start.dy,
// // // //       )
// // // //       ..cubicTo(
// // // //         control1.dx,
// // // //         control1.dy,
// // // //         control2.dx,
// // // //         control2.dy,
// // // //         end.dx,
// // // //         end.dy,
// // // //       );
// // // //
// // // //     canvas.drawPath(
// // // //       curve,
// // // //       curvePaint,
// // // //     );
// // // //
// // // //     // =========================================================
// // // //     // FIVE BULLETS + CONNECTOR LINES
// // // //     // =========================================================
// // // //
// // // //     for (int index = 0; index < itemCount; index++) {
// // // //       final double t =
// // // //       itemCount <= 1 ? 0 : index / (itemCount - 1);
// // // //
// // // //       final Offset point = _bezierPoint(
// // // //         start,
// // // //         control1,
// // // //         control2,
// // // //         end,
// // // //         t,
// // // //       );
// // // //
// // // //       // Same bullet size as target.
// // // //
// // // //       canvas.drawCircle(
// // // //         point,
// // // //         6.5,
// // // //         bulletPaint,
// // // //       );
// // // //
// // // //       // Connector line.
// // // //
// // // //       canvas.drawLine(
// // // //         Offset(
// // // //           point.dx + 6.5,
// // // //           point.dy,
// // // //         ),
// // // //         Offset(
// // // //           size.width + 16,
// // // //           point.dy,
// // // //         ),
// // // //         connectorPaint,
// // // //       );
// // // //     }
// // // //   }
// // // //
// // // //   Offset _bezierPoint(
// // // //       Offset p0,
// // // //       Offset p1,
// // // //       Offset p2,
// // // //       Offset p3,
// // // //       double t,
// // // //       ) {
// // // //     final double u = 1 - t;
// // // //
// // // //     return Offset(
// // // //       (u * u * u * p0.dx) +
// // // //           (3 * u * u * t * p1.dx) +
// // // //           (3 * u * t * t * p2.dx) +
// // // //           (t * t * t * p3.dx),
// // // //       (u * u * u * p0.dy) +
// // // //           (3 * u * u * t * p1.dy) +
// // // //           (3 * u * t * t * p2.dy) +
// // // //           (t * t * t * p3.dy),
// // // //     );
// // // //   }
// // // //
// // // //   @override
// // // //   bool shouldRepaint(
// // // //       covariant _TargetCurvePainter oldDelegate,
// // // //       ) {
// // // //     return oldDelegate.selectedIndex != selectedIndex ||
// // // //         oldDelegate.itemCount != itemCount;
// // // //   }
// // // // }
// // // //
// // // // // =============================================================
// // // // // RIGHT INDICATOR
// // // // // =============================================================
// // // //
// // // // class _MostBookedIndicator extends StatelessWidget {
// // // //   final int count;
// // // //   final int selectedIndex;
// // // //   final ValueChanged<int> onTap;
// // // //
// // // //   const _MostBookedIndicator({
// // // //     required this.count,
// // // //     required this.selectedIndex,
// // // //     required this.onTap,
// // // //   });
// // // //
// // // //   static const Color maroon = Color(0xFF750B0B);
// // // //
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return SizedBox(
// // // //       width: 12,
// // // //       child: Column(
// // // //         mainAxisAlignment: MainAxisAlignment.center,
// // // //         children: List.generate(
// // // //           count,
// // // //               (index) {
// // // //             final bool selected =
// // // //                 index == selectedIndex;
// // // //
// // // //             return GestureDetector(
// // // //               behavior: HitTestBehavior.opaque,
// // // //               onTap: () => onTap(index),
// // // //               child: Padding(
// // // //                 padding: const EdgeInsets.symmetric(
// // // //                   vertical: 2.5,
// // // //                 ),
// // // //                 child: AnimatedContainer(
// // // //                   duration: const Duration(
// // // //                     milliseconds: 350,
// // // //                   ),
// // // //                   curve: Curves.easeInOut,
// // // //                   width: 5,
// // // //                   height: selected ? 28 : 5,
// // // //                   decoration: BoxDecoration(
// // // //                     color: selected
// // // //                         ? maroon
// // // //                         : const Color(0xFFD7D7D7),
// // // //                     borderRadius: BorderRadius.circular(20),
// // // //                   ),
// // // //                 ),
// // // //               ),
// // // //             );
// // // //           },
// // // //         ),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // // //
// // // // // =============================================================
// // // // // MODEL
// // // // // =============================================================
// // // //
// // // // class MostBookedModel {
// // // //   final String title;
// // // //   final String malayalam;
// // // //
// // // //   const MostBookedModel({
// // // //     required this.title,
// // // //     required this.malayalam,
// // // //   });
// // // // }
import 'dart:async';
import 'package:flutter/material.dart';

class MostBookedSection extends StatefulWidget {
  const MostBookedSection({super.key});

  @override
  State<MostBookedSection> createState() => _MostBookedSectionState();
}

class _MostBookedSectionState extends State<MostBookedSection> {
  static const Color maroon = Color(0xFF750B0B);

  Timer? _timer;
  int _currentIndex = 0;

  final List<MostBookedModel> items = const [
    MostBookedModel(
      title: "KUTTICHATHAN VELLAT",
      malayalam: "കുട്ടിച്ചാത്തൻ വെള്ളാട്ട്",
    ),
    MostBookedModel(
      title: "GULIKAN VELLAT",
      malayalam: "ഗുളികൻ വെള്ളാട്ട്",
    ),
    MostBookedModel(
      title: "PAYASA DHANAM",
      malayalam: "പായസ ദാനം",
    ),
    MostBookedModel(
      title: "GANAPATHI HOMAM",
      malayalam: "ഗണപതി ഹോമം",
    ),
    MostBookedModel(
      title: "VALA (GOLD 1)",
      malayalam: "വള സ്വർണം",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(
      const Duration(seconds: 3),
          (_) {
        if (!mounted) return;

        setState(() {
          _currentIndex = (_currentIndex + 1) % items.length;
        });
      },
    );
  }

  void _selectItem(int index) {
    setState(() {
      _currentIndex = index;
    });

    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Most Booked",
            style: TextStyle(
              color: maroon,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 230,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final double width = constraints.maxWidth;

                // Target design proportions.

                final double imageAreaWidth = width * 0.40;

                final double curveAreaWidth = width * 0.13;

                // Curve sits close to image.

                final double curveLeft =
                    imageAreaWidth - 24;

                // Text starts after curve.

                final double textLeft =
                    imageAreaWidth + curveAreaWidth - 10;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // =================================================
                    // IMAGE
                    // =================================================

                    Positioned(
                      left: -14,
                      top: 0,
                      width: imageAreaWidth + 14,
                      height: 230,
                      child: ClipPath(
                        clipper: const _TargetImageClipper(),
                        child: Image.asset(
                          "assets/images/b09c2b74728d9dda1731306dcdf5ee76 2.png",
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),

                    // =================================================
                    // CURVE + BULLETS + LINES
                    // =================================================
                    // Bullets are sampled at the same row-center
                    // fractions as the text/indicator columns below
                    // ((index + 0.5) / itemCount), so all three
                    // pieces (bullet, connector line, text row,
                    // right indicator bar) line up on the same
                    // horizontal band per item.

                    Positioned(
                      left: curveLeft,
                      top: 0,
                      width: curveAreaWidth + 28,
                      height: 230,
                      child: CustomPaint(
                        painter: _TargetCurvePainter(
                          itemCount: items.length,
                          selectedIndex: _currentIndex,
                        ),
                      ),
                    ),

                    // =================================================
                    // TEXT
                    // =================================================

                    Positioned(
                      left: textLeft,
                      right: 21,
                      top: 0,
                      height: 230,
                      child: Column(
                        children: List.generate(
                          items.length,
                              (index) {
                            final MostBookedModel item = items[index];

                            final bool selected =
                                index == _currentIndex;

                            return Expanded(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => _selectItem(index),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: AnimatedOpacity(
                                    duration: const Duration(
                                      milliseconds: 300,
                                    ),
                                    opacity: selected ? 1 : 0.85,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.title,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontSize: 8.5,
                                            height: 1,
                                            color: Colors.black87,
                                            fontWeight: selected
                                                ? FontWeight.w600
                                                : FontWeight.w400,
                                          ),
                                        ),

                                        const SizedBox(height: 4),

                                        Text(
                                          item.malayalam,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontSize: 7.5,
                                            height: 1,
                                            color: Colors.black87,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // =================================================
                    // RIGHT INDICATOR
                    // =================================================
                    // Uses the same equal-slice (Expanded) layout as
                    // the text column above, instead of a centered
                    // fixed-height list, so each bar sits directly
                    // across from its matching text row and bullet.

                    Positioned(
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: _MostBookedIndicator(
                        count: items.length,
                        selectedIndex: _currentIndex,
                        onTap: _selectItem,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================
// IMAGE SHAPE
// =============================================================

class _TargetImageClipper extends CustomClipper<Path> {
  const _TargetImageClipper();

  @override
  Path getClip(Size size) {
    final Path path = Path();

    /*
       TARGET SHAPE

       │\
       │ \
       │  )
       │  )
       │ /
       │/

       Rounded U/D shape on right side.
    */

    final double startX = size.width * 0.15;

    final double bulgeX = size.width * 1.05;

    path.moveTo(0, 0);

    path.lineTo(
      startX,
      0,
    );

    path.cubicTo(
      bulgeX,
      0,
      bulgeX,
      size.height,
      startX,
      size.height,
    );

    path.lineTo(
      0,
      size.height,
    );

    path.close();

    return path;
  }

  @override
  bool shouldReclip(
      covariant _TargetImageClipper oldClipper,
      ) {
    return false;
  }
}

// =============================================================
// CURVE + BULLETS
// =============================================================

class _TargetCurvePainter extends CustomPainter {
  final int itemCount;
  final int selectedIndex;

  const _TargetCurvePainter({
    required this.itemCount,
    required this.selectedIndex,
  });

  static const Color maroon = Color(0xFF750B0B);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint curvePaint = Paint()
      ..color = maroon
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final Paint bulletPaint = Paint()
      ..color = maroon
      ..style = PaintingStyle.fill;

    final Paint selectedBulletPaint = Paint()
      ..color = Colors.amber.shade700
      ..style = PaintingStyle.fill;

    final Paint connectorPaint = Paint()
      ..color = maroon.withOpacity(0.55)
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round;

    /*
       Narrow rounded curve close to image.
    */

    final Offset start = const Offset(
      0,
      3,
    );

    final Offset control1 = Offset(
      size.width * 1.28,
      3,
    );

    final Offset control2 = Offset(
      size.width * 1.28,
      size.height - 3,
    );

    final Offset end = Offset(
      0,
      size.height - 3,
    );

    final Path curve = Path()
      ..moveTo(
        start.dx,
        start.dy,
      )
      ..cubicTo(
        control1.dx,
        control1.dy,
        control2.dx,
        control2.dy,
        end.dx,
        end.dy,
      );

    canvas.drawPath(
      curve,
      curvePaint,
    );

    // =========================================================
    // BULLETS + CONNECTOR LINES
    // =========================================================
    // Sampled at (index + 0.5) / itemCount to match the row-center
    // fraction used by the Expanded text rows and indicator bars,
    // so every bullet/line lands on the same band as its label.

    for (int index = 0; index < itemCount; index++) {
      final double t = (index + 0.5) / itemCount;

      final Offset point = _bezierPoint(
        start,
        control1,
        control2,
        end,
        t,
      );

      final bool selected = index == selectedIndex;

      canvas.drawCircle(
        point,
        selected ? 7.5 : 6.5,
        selected ? selectedBulletPaint : bulletPaint,
      );

      // Connector line.

      canvas.drawLine(
        Offset(
          point.dx + 7.5,
          point.dy,
        ),
        Offset(
          size.width + 16,
          point.dy,
        ),
        connectorPaint,
      );
    }
  }

  Offset _bezierPoint(
      Offset p0,
      Offset p1,
      Offset p2,
      Offset p3,
      double t,
      ) {
    final double u = 1 - t;

    return Offset(
      (u * u * u * p0.dx) +
          (3 * u * u * t * p1.dx) +
          (3 * u * t * t * p2.dx) +
          (t * t * t * p3.dx),
      (u * u * u * p0.dy) +
          (3 * u * u * t * p1.dy) +
          (3 * u * t * t * p2.dy) +
          (t * t * t * p3.dy),
    );
  }

  @override
  bool shouldRepaint(
      covariant _TargetCurvePainter oldDelegate,
      ) {
    return oldDelegate.selectedIndex != selectedIndex ||
        oldDelegate.itemCount != itemCount;
  }
}

// =============================================================
// RIGHT INDICATOR
// =============================================================

class _MostBookedIndicator extends StatelessWidget {
  final int count;
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _MostBookedIndicator({
    required this.count,
    required this.selectedIndex,
    required this.onTap,
  });

  static const Color maroon = Color(0xFF750B0B);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 12,
      // Equal-slice Column (Expanded per item) instead of a
      // centered fixed-height list, so bar N sits on the same
      // horizontal band as text row N and bullet N.
      child: Column(
        children: List.generate(
          count,
              (index) {
            final bool selected =
                index == selectedIndex;

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => onTap(index),
                child: Center(
                  child: AnimatedContainer(
                    duration: const Duration(
                      milliseconds: 350,
                    ),
                    curve: Curves.easeInOut,
                    width: 5,
                    height: selected ? 28 : 5,
                    decoration: BoxDecoration(
                      color: selected
                          ? maroon
                          : const Color(0xFFD7D7D7),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// =============================================================
// MODEL
// =============================================================

class MostBookedModel {
  final String title;
  final String malayalam;

  const MostBookedModel({
    required this.title,
    required this.malayalam,
  });
}
// // import 'dart:async';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:flutter/material.dart';
// //
// // /// FIRESTORE SCHEMA
// // ///
// // /// mostBooked/main  (single doc)
// // ///     imageUrl (String)  -> network image for the left graphic.
// // ///                           Falls back to the bundled asset below if
// // ///                           empty/missing so the layout never breaks.
// // ///     items (array<map>) -> [{ title: String, malayalam: String }, ...]
// // ///                           Falls back to the 5 defaults below if
// // ///                           empty/missing.
// // class MostBookedSection extends StatefulWidget {
// //   const MostBookedSection({super.key});
// //
// //   @override
// //   State<MostBookedSection> createState() => _MostBookedSectionState();
// // }
// //
// // class _MostBookedSectionState extends State<MostBookedSection> {
// //   static const Color maroon = Color(0xFF750B0B);
// //   static const String _fallbackImage =
// //       "assets/images/b09c2b74728d9dda1731306dcdf5ee76 2.png";
// //
// //   static const List<MostBookedModel> _defaultItems = [
// //     MostBookedModel(
// //       title: "KUTTICHATHAN VELLAT",
// //       malayalam: "കുട്ടിച്ചാത്തൻ വെള്ളാട്ട്",
// //     ),
// //     MostBookedModel(
// //       title: "GULIKAN VELLAT",
// //       malayalam: "ഗുളികൻ വെള്ളാട്ട്",
// //     ),
// //     MostBookedModel(
// //       title: "PAYASA DHANAM",
// //       malayalam: "പായസ ദാനം",
// //     ),
// //     MostBookedModel(
// //       title: "GANAPATHI HOMAM",
// //       malayalam: "ഗണപതി ഹോമം",
// //     ),
// //     MostBookedModel(
// //       title: "VALA (GOLD 1)",
// //       malayalam: "വള സ്വർണം",
// //     ),
// //   ];
// //
// //   late final Stream<DocumentSnapshot<Map<String, dynamic>>> _stream;
// //
// //   Timer? _timer;
// //   int _currentIndex = 0;
// //
// //   // Kept in sync with whatever the StreamBuilder last rendered, so the
// //   // auto-advance Timer always knows the *current* item count even
// //   // though it was started once in initState.
// //   List<MostBookedModel> _liveItems = _defaultItems;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _stream = FirebaseFirestore.instance
// //         .collection('mostBooked')
// //         .doc('main')
// //         .snapshots();
// //     _startTimer();
// //   }
// //
// //   void _startTimer() {
// //     _timer?.cancel();
// //     _timer = Timer.periodic(const Duration(seconds: 3), (_) {
// //       if (!mounted) return;
// //       setState(() {
// //         _currentIndex = (_currentIndex + 1) % _liveItems.length;
// //       });
// //     });
// //   }
// //
// //   void _selectItem(int index) {
// //     setState(() => _currentIndex = index);
// //     _startTimer();
// //   }
// //
// //   @override
// //   void dispose() {
// //     _timer?.cancel();
// //     super.dispose();
// //   }
// //
// //   Widget _sectionImage(String imageUrl) {
// //     return imageUrl.isNotEmpty
// //         ? Image.network(
// //       imageUrl,
// //       fit: BoxFit.cover,
// //       alignment: Alignment.center,
// //       errorBuilder: (_, __, ___) => Image.asset(
// //         _fallbackImage,
// //         fit: BoxFit.cover,
// //         alignment: Alignment.center,
// //       ),
// //     )
// //         : Image.asset(
// //       _fallbackImage,
// //       fit: BoxFit.cover,
// //       alignment: Alignment.center,
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
// //       stream: _stream,
// //       builder: (context, snapshot) {
// //         final data = snapshot.data?.data();
// //
// //         final imageUrl = (data?['imageUrl'] as String?) ?? '';
// //
// //         final rawItems = data?['items'] as List<dynamic>?;
// //         final items = (rawItems != null && rawItems.isNotEmpty)
// //             ? rawItems
// //             .map((e) {
// //           final m = e as Map<String, dynamic>;
// //           return MostBookedModel(
// //             title: (m['title'] as String?) ?? '',
// //             malayalam: (m['malayalam'] as String?) ?? '',
// //           );
// //         })
// //             .toList()
// //             : _defaultItems;
// //
// //         // Keep the Timer's notion of item count current, and clamp the
// //         // selected index in case the live list is shorter than before.
// //         _liveItems = items;
// //         if (_currentIndex >= items.length) _currentIndex = 0;
// //
// //         return Padding(
// //           padding: const EdgeInsets.symmetric(horizontal: 14),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               const Text(
// //                 "Most Booked",
// //                 style: TextStyle(
// //                   color: maroon,
// //                   fontSize: 16,
// //                   fontWeight: FontWeight.w700,
// //                 ),
// //               ),
// //               const SizedBox(height: 12),
// //               SizedBox(
// //                 height: 230,
// //                 child: LayoutBuilder(
// //                   builder: (context, constraints) {
// //                     final double width = constraints.maxWidth;
// //
// //                     // Target design proportions.
// //                     final double imageAreaWidth = width * 0.40;
// //                     final double curveAreaWidth = width * 0.13;
// //
// //                     // Curve sits close to image.
// //                     final double curveLeft = imageAreaWidth - 24;
// //
// //                     // Text starts after curve.
// //                     final double textLeft =
// //                         imageAreaWidth + curveAreaWidth - 10;
// //
// //                     return Stack(
// //                       clipBehavior: Clip.none,
// //                       children: [
// //                         // =====================================
// //                         // IMAGE
// //                         // =====================================
// //                         Positioned(
// //                           left: -14,
// //                           top: 0,
// //                           width: imageAreaWidth + 14,
// //                           height: 230,
// //                           child: ClipPath(
// //                             clipper: const _TargetImageClipper(),
// //                             child: _sectionImage(imageUrl),
// //                           ),
// //                         ),
// //
// //                         // =====================================
// //                         // CURVE + BULLETS + LINES
// //                         // =====================================
// //                         Positioned(
// //                           left: curveLeft,
// //                           top: 0,
// //                           width: curveAreaWidth + 28,
// //                           height: 230,
// //                           child: CustomPaint(
// //                             painter: _TargetCurvePainter(
// //                               itemCount: items.length,
// //                               selectedIndex: _currentIndex,
// //                             ),
// //                           ),
// //                         ),
// //
// //                         // =====================================
// //                         // TEXT
// //                         // =====================================
// //                         Positioned(
// //                           left: textLeft,
// //                           right: 21,
// //                           top: 0,
// //                           height: 230,
// //                           child: Column(
// //                             children: List.generate(items.length, (index) {
// //                               final MostBookedModel item = items[index];
// //                               final bool selected = index == _currentIndex;
// //
// //                               return Expanded(
// //                                 child: GestureDetector(
// //                                   behavior: HitTestBehavior.opaque,
// //                                   onTap: () => _selectItem(index),
// //                                   child: Align(
// //                                     alignment: Alignment.centerLeft,
// //                                     child: AnimatedOpacity(
// //                                       duration: const Duration(milliseconds: 300),
// //                                       opacity: selected ? 1 : 0.85,
// //                                       child: Column(
// //                                         mainAxisSize: MainAxisSize.min,
// //                                         crossAxisAlignment: CrossAxisAlignment.start,
// //                                         children: [
// //                                           Text(
// //                                             item.title,
// //                                             maxLines: 1,
// //                                             overflow: TextOverflow.ellipsis,
// //                                             style: TextStyle(
// //                                               fontSize: 8.5,
// //                                               height: 1,
// //                                               color: Colors.black87,
// //                                               fontWeight:
// //                                               selected ? FontWeight.w600 : FontWeight.w400,
// //                                             ),
// //                                           ),
// //                                           const SizedBox(height: 4),
// //                                           Text(
// //                                             item.malayalam,
// //                                             maxLines: 1,
// //                                             overflow: TextOverflow.ellipsis,
// //                                             style: const TextStyle(
// //                                               fontSize: 7.5,
// //                                               height: 1,
// //                                               color: Colors.black87,
// //                                             ),
// //                                           ),
// //                                         ],
// //                                       ),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               );
// //                             }),
// //                           ),
// //                         ),
// //
// //                         // =====================================
// //                         // RIGHT INDICATOR
// //                         // =====================================
// //                         Positioned(
// //                           right: 0,
// //                           top: 0,
// //                           bottom: 0,
// //                           child: _MostBookedIndicator(
// //                             count: items.length,
// //                             selectedIndex: _currentIndex,
// //                             onTap: _selectItem,
// //                           ),
// //                         ),
// //                       ],
// //                     );
// //                   },
// //                 ),
// //               ),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }
// //
// // // =============================================================
// // // IMAGE SHAPE
// // // =============================================================
// //
// // class _TargetImageClipper extends CustomClipper<Path> {
// //   const _TargetImageClipper();
// //
// //   @override
// //   Path getClip(Size size) {
// //     final Path path = Path();
// //
// //     final double startX = size.width * 0.15;
// //     final double bulgeX = size.width * 1.05;
// //
// //     path.moveTo(0, 0);
// //     path.lineTo(startX, 0);
// //     path.cubicTo(bulgeX, 0, bulgeX, size.height, startX, size.height);
// //     path.lineTo(0, size.height);
// //     path.close();
// //
// //     return path;
// //   }
// //
// //   @override
// //   bool shouldReclip(covariant _TargetImageClipper oldClipper) => false;
// // }
// //
// // // =============================================================
// // // CURVE + BULLETS
// // // =============================================================
// //
// // class _TargetCurvePainter extends CustomPainter {
// //   final int itemCount;
// //   final int selectedIndex;
// //
// //   const _TargetCurvePainter({
// //     required this.itemCount,
// //     required this.selectedIndex,
// //   });
// //
// //   static const Color maroon = Color(0xFF750B0B);
// //
// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final Paint curvePaint = Paint()
// //       ..color = maroon
// //       ..style = PaintingStyle.stroke
// //       ..strokeWidth = 3
// //       ..strokeCap = StrokeCap.round;
// //
// //     final Paint bulletPaint = Paint()
// //       ..color = maroon
// //       ..style = PaintingStyle.fill;
// //
// //     final Paint selectedBulletPaint = Paint()
// //       ..color = Colors.amber.shade700
// //       ..style = PaintingStyle.fill;
// //
// //     final Paint connectorPaint = Paint()
// //       ..color = maroon.withOpacity(0.55)
// //       ..strokeWidth = 1
// //       ..strokeCap = StrokeCap.round;
// //
// //     final Offset start = const Offset(0, 3);
// //     final Offset control1 = Offset(size.width * 1.28, 3);
// //     final Offset control2 = Offset(size.width * 1.28, size.height - 3);
// //     final Offset end = Offset(0, size.height - 3);
// //
// //     final Path curve = Path()
// //       ..moveTo(start.dx, start.dy)
// //       ..cubicTo(control1.dx, control1.dy, control2.dx, control2.dy, end.dx, end.dy);
// //
// //     canvas.drawPath(curve, curvePaint);
// //
// //     // Sampled at (index + 0.5) / itemCount to match the row-center
// //     // fraction used by the Expanded text rows and indicator bars, so
// //     // every bullet/line lands on the same band as its label.
// //     for (int index = 0; index < itemCount; index++) {
// //       final double t = (index + 0.5) / itemCount;
// //       final Offset point = _bezierPoint(start, control1, control2, end, t);
// //       final bool selected = index == selectedIndex;
// //
// //       canvas.drawCircle(
// //         point,
// //         selected ? 7.5 : 6.5,
// //         selected ? selectedBulletPaint : bulletPaint,
// //       );
// //
// //       canvas.drawLine(
// //         Offset(point.dx + 7.5, point.dy),
// //         Offset(size.width + 16, point.dy),
// //         connectorPaint,
// //       );
// //     }
// //   }
// //
// //   Offset _bezierPoint(Offset p0, Offset p1, Offset p2, Offset p3, double t) {
// //     final double u = 1 - t;
// //     return Offset(
// //       (u * u * u * p0.dx) + (3 * u * u * t * p1.dx) + (3 * u * t * t * p2.dx) + (t * t * t * p3.dx),
// //       (u * u * u * p0.dy) + (3 * u * u * t * p1.dy) + (3 * u * t * t * p2.dy) + (t * t * t * p3.dy),
// //     );
// //   }
// //
// //   @override
// //   bool shouldRepaint(covariant _TargetCurvePainter oldDelegate) {
// //     return oldDelegate.selectedIndex != selectedIndex || oldDelegate.itemCount != itemCount;
// //   }
// // }
// //
// // // =============================================================
// // // RIGHT INDICATOR
// // // =============================================================
// //
// // class _MostBookedIndicator extends StatelessWidget {
// //   final int count;
// //   final int selectedIndex;
// //   final ValueChanged<int> onTap;
// //
// //   const _MostBookedIndicator({
// //     required this.count,
// //     required this.selectedIndex,
// //     required this.onTap,
// //   });
// //
// //   static const Color maroon = Color(0xFF750B0B);
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return SizedBox(
// //       width: 12,
// //       child: Column(
// //         children: List.generate(count, (index) {
// //           final bool selected = index == selectedIndex;
// //           return Expanded(
// //             child: GestureDetector(
// //               behavior: HitTestBehavior.opaque,
// //               onTap: () => onTap(index),
// //               child: Center(
// //                 child: AnimatedContainer(
// //                   duration: const Duration(milliseconds: 350),
// //                   curve: Curves.easeInOut,
// //                   width: 5,
// //                   height: selected ? 28 : 5,
// //                   decoration: BoxDecoration(
// //                     color: selected ? maroon : const Color(0xFFD7D7D7),
// //                     borderRadius: BorderRadius.circular(20),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         }),
// //       ),
// //     );
// //   }
// // }
// //
// // // =============================================================
// // // MODEL
// // // =============================================================
// //
// // class MostBookedModel {
// //   final String title;
// //   final String malayalam;
// //
// //   const MostBookedModel({
// //     required this.title,
// //     required this.malayalam,
// //   });
// // }
// import 'dart:async';
// import 'dart:math';
// import 'package:flutter/material.dart';
//
// const Color kMaroon = Color(0xFF750B0B);
//
// /// Data model shared between the home-page carousel and the full
// /// "Most Booked" list page.
// class MostBookedModel {
//   final String title;
//   final String malayalam;
//   final String image;
//   final num? amount;
//
//   const MostBookedModel({
//     required this.title,
//     required this.malayalam,
//     this.image = "assets/images/deity.png",
//     this.amount,
//   });
// }
//
// /// Default data. Swap this for a Firestore stream
// /// (e.g. `mostBooked/main` -> items array) once you wire it up —
// /// both MostBookedSection and MostBookedPage accept an `items`
// /// override so you don't have to touch this constant.
// const List<MostBookedModel> kMostBookedItems = [
//   MostBookedModel(
//     title: "KUTTICHATHAN VELLAT",
//     malayalam: "കുട്ടിച്ചാത്തൻ വെള്ളാട്ട്",
//     amount: 1100,
//   ),
//   MostBookedModel(
//     title: "GULIKAN VELLAT",
//     malayalam: "ഗുളികൻ വെള്ളാട്ട്",
//     amount: 1100,
//   ),
//   MostBookedModel(
//     title: "PAYASA DHANAM",
//     malayalam: "പായസ ദാനം",
//     amount: 250,
//   ),
//   MostBookedModel(
//     title: "GANAPATHI HOMAM",
//     malayalam: "ഗണപതി ഹോമം",
//     amount: 500,
//   ),
//   MostBookedModel(
//     title: "VALA (GOLD 1)",
//     malayalam: "വള സ്വർണം",
//     amount: 3500,
//   ),
// ];
//
// /// The curved-carousel "Most Booked" section for the home page.
// ///
// /// Pass [onViewAll] to show the same "Title — View All >" header row
// /// used by the other home-page sections, which pushes to
// /// [MostBookedPage]. Omit it to fall back to a plain bold title.
// class MostBookedSection extends StatefulWidget {
//   const MostBookedSection({
//     super.key,
//     this.items = kMostBookedItems,
//     this.onViewAll,
//   });
//
//   final List<MostBookedModel> items;
//   final VoidCallback? onViewAll;
//
//   @override
//   State<MostBookedSection> createState() => _MostBookedSectionState();
// }
//
// class _MostBookedSectionState extends State<MostBookedSection> {
//   Timer? _timer;
//   int _currentIndex = 0;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     _timer?.cancel();
//     _timer = Timer.periodic(const Duration(seconds: 3), (_) {
//       if (!mounted) return;
//       setState(() {
//         _currentIndex = (_currentIndex + 1) % widget.items.length;
//       });
//     });
//   }
//
//   void _selectItem(int index) {
//     setState(() => _currentIndex = index);
//     _startTimer();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final items = widget.items;
//     if (items.isEmpty) return const SizedBox.shrink();
//
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.onViewAll != null)
//             Row(
//               children: [
//                 const Expanded(
//                   child: Text(
//                     "Most Booked",
//                     style: TextStyle(
//                       color: kMaroon,
//                       fontSize: 15,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                 ),
//                 TextButton(
//                   onPressed: widget.onViewAll,
//                   style: TextButton.styleFrom(
//                     minimumSize: Size.zero,
//                     padding: EdgeInsets.zero,
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                   ),
//                   child: const Text(
//                     "View All >",
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 9,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           else
//             const Text(
//               "Most Booked",
//               style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 18,
//                 fontWeight: FontWeight.w800,
//               ),
//             ),
//           const SizedBox(height: 16),
//           SizedBox(
//             height: 280,
//             child: LayoutBuilder(
//               builder: (context, constraints) {
//                 final double width = constraints.maxWidth;
//
//                 final double imageAreaWidth = width * 0.38;
//                 final double curveLeft = imageAreaWidth - 18;
//                 final double textLeft = imageAreaWidth + width * 0.13;
//                 final double curveWidgetWidth = textLeft - curveLeft;
//
//                 return Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     // IMAGE
//                     Positioned(
//                       left: -14,
//                       top: 0,
//                       width: imageAreaWidth + 14,
//                       height: 280,
//                       child: ClipPath(
//                         clipper: const _TargetImageClipper(),
//                         child: Container(
//                           color: Colors.grey.shade300,
//                           child: Image.asset(
//                             items[_currentIndex].image,
//                             fit: BoxFit.cover,
//                             alignment: Alignment.center,
//                             errorBuilder: (context, error, stack) =>
//                             const Center(
//                               child: Icon(
//                                 Icons.image,
//                                 color: Colors.white70,
//                                 size: 32,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//
//                     // CURVE + BULLETS + LINES
//                     Positioned(
//                       left: curveLeft,
//                       top: 0,
//                       width: curveWidgetWidth,
//                       height: 280,
//                       child: CustomPaint(
//                         painter: _TargetCurvePainter(
//                           itemCount: items.length,
//                           selectedIndex: _currentIndex,
//                         ),
//                       ),
//                     ),
//
//                     // TEXT
//                     Positioned(
//                       left: textLeft,
//                       right: 24,
//                       top: 0,
//                       height: 280,
//                       child: Column(
//                         children: List.generate(items.length, (index) {
//                           final item = items[index];
//                           final selected = index == _currentIndex;
//
//                           return Expanded(
//                             child: GestureDetector(
//                               behavior: HitTestBehavior.opaque,
//                               onTap: () => _selectItem(index),
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: AnimatedOpacity(
//                                   duration: const Duration(milliseconds: 300),
//                                   opacity: selected ? 1 : 0.9,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         item.title,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           fontSize: 13,
//                                           height: 1.15,
//                                           letterSpacing: 0.2,
//                                           color: Colors.black87,
//                                           fontWeight: FontWeight.w700,
//                                         ),
//                                       ),
//                                       const SizedBox(height: 3),
//                                       Text(
//                                         item.malayalam,
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           fontSize: 12.5,
//                                           height: 1.15,
//                                           color: kMaroon,
//                                           fontWeight: FontWeight.w500,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           );
//                         }),
//                       ),
//                     ),
//
//                     // RIGHT INDICATOR
//                     Positioned(
//                       right: 0,
//                       top: 0,
//                       bottom: 0,
//                       child: _MostBookedIndicator(
//                         count: items.length,
//                         selectedIndex: _currentIndex,
//                         onTap: _selectItem,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // =============================================================
// // IMAGE SHAPE
// // =============================================================
//
// class _TargetImageClipper extends CustomClipper<Path> {
//   const _TargetImageClipper();
//
//   @override
//   Path getClip(Size size) {
//     final Path path = Path();
//     final double startX = size.width * 0.18;
//     final double bulgeX = size.width * 0.98;
//
//     path.moveTo(0, 0);
//     path.lineTo(startX, 0);
//     path.cubicTo(bulgeX, 0, bulgeX, size.height, startX, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant _TargetImageClipper oldClipper) => false;
// }
//
// // =============================================================
// // CURVE + BULLETS
// // =============================================================
//
// class _TargetCurvePainter extends CustomPainter {
//   final int itemCount;
//   final int selectedIndex;
//
//   const _TargetCurvePainter({
//     required this.itemCount,
//     required this.selectedIndex,
//   });
//
//   @override
//   void paint(Canvas canvas, Size size) {
//     final Paint curvePaint = Paint()
//       ..color = kMaroon
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2.5
//       ..strokeCap = StrokeCap.round;
//
//     final Paint bulletPaint = Paint()
//       ..color = kMaroon
//       ..style = PaintingStyle.fill;
//
//     final Paint bulletRingPaint = Paint()
//       ..color = Colors.white
//       ..style = PaintingStyle.stroke
//       ..strokeWidth = 2;
//
//     final Paint connectorPaint = Paint()
//       ..color = kMaroon.withOpacity(0.7)
//       ..strokeWidth = 1.2
//       ..strokeCap = StrokeCap.round;
//
//     final double rowHeight = size.height / itemCount;
//     final double bulgeAmplitude = size.width * 0.42;
//     final double baseX = size.width * 0.12;
//
//     final List<Offset> points = List.generate(itemCount, (index) {
//       final double t = itemCount == 1 ? 0.5 : (index + 0.5) / itemCount;
//       final double x = baseX + bulgeAmplitude * sin(pi * t);
//       final double y = rowHeight * (index + 0.5);
//       return Offset(x, y);
//     });
//
//     canvas.drawPath(_smoothPath(points), curvePaint);
//
//     for (int index = 0; index < itemCount; index++) {
//       final Offset point = points[index];
//       final bool selected = index == selectedIndex;
//
//       canvas.drawLine(
//         Offset(point.dx + 6, point.dy),
//         Offset(size.width, point.dy),
//         connectorPaint,
//       );
//
//       canvas.drawCircle(point, selected ? 7 : 6, bulletPaint);
//
//       if (selected) {
//         canvas.drawCircle(point, 9, bulletRingPaint);
//       }
//     }
//   }
//
//   Path _smoothPath(List<Offset> points) {
//     final Path path = Path();
//     if (points.isEmpty) return path;
//
//     path.moveTo(points.first.dx, points.first.dy);
//     if (points.length == 1) return path;
//
//     for (int i = 0; i < points.length - 1; i++) {
//       final Offset p0 = i == 0 ? points[i] : points[i - 1];
//       final Offset p1 = points[i];
//       final Offset p2 = points[i + 1];
//       final Offset p3 = i + 2 < points.length ? points[i + 2] : p2;
//
//       final Offset cp1 = Offset(
//         p1.dx + (p2.dx - p0.dx) / 6,
//         p1.dy + (p2.dy - p0.dy) / 6,
//       );
//       final Offset cp2 = Offset(
//         p2.dx - (p3.dx - p1.dx) / 6,
//         p2.dy - (p3.dy - p1.dy) / 6,
//       );
//
//       path.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p2.dx, p2.dy);
//     }
//
//     return path;
//   }
//
//   @override
//   bool shouldRepaint(covariant _TargetCurvePainter oldDelegate) {
//     return oldDelegate.selectedIndex != selectedIndex ||
//         oldDelegate.itemCount != itemCount;
//   }
// }
//
// // =============================================================
// // RIGHT INDICATOR
// // =============================================================
//
// class _MostBookedIndicator extends StatelessWidget {
//   final int count;
//   final int selectedIndex;
//   final ValueChanged<int> onTap;
//
//   const _MostBookedIndicator({
//     required this.count,
//     required this.selectedIndex,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 16,
//       child: Column(
//         children: List.generate(count, (index) {
//           final bool selected = index == selectedIndex;
//
//           return Expanded(
//             child: GestureDetector(
//               behavior: HitTestBehavior.opaque,
//               onTap: () => onTap(index),
//               child: Center(
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                   width: selected ? 8 : 6,
//                   height: selected ? 8 : 6,
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: selected ? kMaroon : const Color(0xFFD7D7D7),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }
