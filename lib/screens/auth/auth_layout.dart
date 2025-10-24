// TODO Implement this library.
import 'package:flutter/material.dart';

// Colors sampled from the new design
const kAuthBlue = Color(0xFF2979FF);
final kAuthBackgroundGradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [
    Colors.white,
    const Color(0xFFEAF2FF).withOpacity(0.8),
    const Color(0xFFEAF2FF),
  ],
  stops: const [0.0, 0.4, 1.0],
);

class AuthLayout extends StatelessWidget {
  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use a container for the gradient background
      body: Container(
        decoration: BoxDecoration(gradient: kAuthBackgroundGradient),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
