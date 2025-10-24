// TODO Implement this library.
import 'package:flutter/material.dart';

class HomeSuggestionCard extends StatelessWidget {
  final String title;
  final Gradient gradient;
  final Widget icon;
  final VoidCallback onCardTap;
  final String? buttonText; // For the "Events" card
  final bool isSmall; // For the "Weekly Plan" cards

  const HomeSuggestionCard({
    super.key,
    required this.title,
    required this.gradient,
    required this.icon,
    required this.onCardTap,
    this.buttonText,
    this.isSmall = false,
  });

  @override
  Widget build(BuildContext context) {
    // The small cards on the right
    if (isSmall) {
      return _buildSmallCard();
    }
    // The large card on the left
    return _buildLargeCard();
  }

  Widget _buildLargeCard() {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        height: 200, // Fixed height to match the column on the right
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            icon,
            const Spacer(),
            Text(
              title,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            if (buttonText != null)
              ElevatedButton(
                onPressed: onCardTap, // Button also triggers the card tap
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0D47A1), // Dark blue
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                ),
                child: Text(
                  buttonText!,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallCard() {
    return GestureDetector(
      onTap: onCardTap,
      child: Container(
        height: 92, // Fixed height to stack two
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            icon,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                // Arrow icon
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black54,
                    size: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
