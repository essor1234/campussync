import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/routes.dart';
import 'auth_layout.dart';
import 'auth_primary_button.dart';
import 'auth_text_field.dart';
import 'auth_bottom_link.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return AuthLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),
          // --- Header ---
          const Text(
            'Welcome Back!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Sign in to your account to continue',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 48),

          // --- Form ---
          AuthTextField(
            controller: _emailController,
            hintText: 'Email',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 24),

          // --- Login Button ---
          AuthPrimaryButton(
            text: 'Sign In',
            isLoading: _loading,
            onPressed: () async {
              final email = _emailController.text.trim();
              if (email.isEmpty) return;

              setState(() => _loading = true);
              try {
                await userProvider.login(email);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Login successful!')),
                  );
                  // Navigate to home after successful login (matching your Routes.home)
                  Navigator.pushReplacementNamed(context, Routes.home);
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(e.toString())));
                }
              } finally {
                if (mounted) setState(() => _loading = false);
              }
            },
          ),
          const Spacer(flex: 3),

          // --- Bottom Link ---
          AuthBottomLink(
            text: "Don't have an account?",
            linkText: 'Sign Up',
            onTap: () {
              Navigator.pushNamed(context, Routes.register);
            },
          ),
          const SizedBox(height: 20), // Padding from bottom
        ],
      ),
    );
  }
}
