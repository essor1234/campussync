import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import 'auth_layout.dart';
import 'auth_primary_button.dart';
import 'auth_text_field.dart';
import 'auth_bottom_link.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
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
            'Create Account',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Experience smarter conversations',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 48),

          // --- Form ---
          AuthTextField(
            controller: _nameController,
            hintText: 'Name',
            icon: Icons.person_outline,
          ),
          const SizedBox(height: 16),
          AuthTextField(
            controller: _emailController,
            hintText: 'Email',
            icon: Icons.email_outlined,
          ),
          const SizedBox(height: 24),

          // --- Register Button ---
          AuthPrimaryButton(
            text: 'Sign Up',
            isLoading: _loading,
            onPressed: () async {
              final email = _emailController.text.trim();
              final name = _nameController.text.trim();

              if (email.isEmpty || name.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Name and Email cannot be empty.'),
                  ),
                );
                return;
              }

              setState(() => _loading = true);
              try {
                await userProvider.register(email, name: name);
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Registration successful!')),
                  );
                  Navigator.pop(context);
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
            text: 'Already have an account?',
            linkText: 'Sign In',
            onTap: () {
              Navigator.pop(context); // Go back to Login
            },
          ),
          const SizedBox(height: 20), // Padding from bottom
        ],
      ),
    );
  }
}
