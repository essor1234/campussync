import 'package:campussync/screens/event/events_screen.dart';
import 'package:flutter/material.dart'; // For kColorTeal, kColorTagNeutral

class ScheduleDayFilter extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ScheduleDayFilter({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected
              ? kColorTeal
              : Colors.grey[200], // Active vs inactive color
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(color: Colors.transparent), // No border for inactive
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
