import 'package:flutter/material.dart';
import '../main.dart';
import '../utils/AppBackground.dart';

class TabOption {
  final String label;
  final IconData icon;
  const TabOption(this.label, this.icon);
}

class TabSelector extends StatelessWidget {
  static const options = [
    TabOption('My\nPoojas', Icons.auto_awesome),
    TabOption('My\nBookings', Icons.event_available),
    TabOption('Donations', Icons.volunteer_activism),
  ];

  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const TabSelector({
    super.key,
    required this.selectedIndex,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(options.length, (i) {
        final isSelected = i == selectedIndex;
        final option = options[i];
        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(
              right: i != options.length - 1 ? 10 : 0,
            ),
            child: GestureDetector(
              onTap: () => onSelected(i),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.maroon : AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Icon(
                      option.icon,
                      color: isSelected ? Colors.white : AppColors.maroon,
                      size: 20,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      option.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.textDark,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}