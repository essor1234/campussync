import 'package:flutter/material.dart';

class HomeBottomChatBar extends StatelessWidget {
  final VoidCallback onTap;
  const HomeBottomChatBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    // This container sits in the Scaffold's bottomNavigationBar property
    return Container(
      height: 90, // Give it a fixed height
      color: Colors.white, // Ensure it has a white background
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2979FF), // Main blue button color
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start New Chat',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}
