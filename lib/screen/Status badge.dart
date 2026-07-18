import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/AppBackground.dart';

class StatusBadge extends StatelessWidget {
  final String status; // "CONFIRMED" or "CLOSED"

  const StatusBadge({super.key, required this.status});

  bool get _isClosed => status.toUpperCase() == 'CLOSED';

  @override
  Widget build(BuildContext context) {
    final bg = _isClosed ? AppColors.closedBg : AppColors.confirmedBg;
    final fg = _isClosed ? AppColors.closedText : AppColors.confirmedText;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.only(right: 6),
            decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
          ),
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: fg,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );
  }
}