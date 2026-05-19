import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../verify_email/verify_code_screen.dart';
import 'widgets/auth_widgets.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;

  final Color _primaryGreen = const Color(0xFF4A7B59);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 40.0.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              // Sign Up Title
              Text(
                "Sign Up",
                style: TextStyle(
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold,
                  color: _primaryGreen,
                ),
              ),
              SizedBox(height: 40.h),

              // User Name Field
              const AuthTextField(hintText: "User Name"),
              SizedBox(height: 20.h),

              // Full Name Field
              const AuthTextField(hintText: "Full Name"),
              SizedBox(height: 20.h),

              // Email Field
              const AuthTextField(hintText: "Email"),
              SizedBox(height: 20.h),

              // Password Field
              AuthTextField(
                hintText: "Password",
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.h),

              // Re-enter Password Field
              const AuthTextField(
                hintText: "Re-enter Password",
                obscureText: true,
              ),
              SizedBox(height: 40.h),

              // Sign up Button
              AuthPrimaryButton(
                text: "Sign up",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const VerifyCodeScreen()),
                  );
                },
              ),
              SizedBox(height: 16.h),

              // Login Button
              AuthSecondaryButton(
                text: "Login",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: 40.h),

              // OR Divider
              const AuthDivider(),
              SizedBox(height: 40.h),

              // Continue with Google Button
              AuthSocialButton(
                text: "Continue with Google",
                icon: Icons.g_mobiledata,
                onPressed: () {
                  // Google signup logic
                },
              ),
              SizedBox(height: 40.h),

              // Bottom Text
              AuthBottomText(
                questionText: "Already have an account?",
                actionText: "Login.",
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
