import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signup_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import 'widgets/auth_widgets.dart';
import 'utils/validators.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  
  bool _rememberMe = true;
  bool _obscurePassword = true;

  final Color _primaryGreen = const Color(0xFF4A7B59);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 40.0.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                // Login Title
                Center(
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                      color: _primaryGreen,
                    ),
                  ),
                ),
                SizedBox(height: 40.h),

                // Subtitle
                Text(
                  "Please Sign in to continue.",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: _primaryGreen,
                  ),
                ),
                SizedBox(height: 30.h),

                // Email Field
                AuthTextField(
                  hintText: "Email/User name",
                  controller: _emailController,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter Email or Username' : null,
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.h),

                // Password Field
                AuthTextField(
                  hintText: "Password",
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  validator: Validators.validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16.h),

                // Remember Me & Forgot Password
                Row(
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: Checkbox(
                        value: _rememberMe,
                        activeColor: _primaryGreen,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? true;
                          });
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Remember Me",
                      style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size(50.w, 30.h),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),

                // Login Button
                AuthPrimaryButton(
                  text: "Login",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushReplacementNamed(context, '/login_home');
                    }
                  },
                ),
                SizedBox(height: 16.h),

                // Sign up Button
                AuthSecondaryButton(
                  text: "Sign up",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
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
                    // Google login logic
                  },
                ),
                SizedBox(height: 40.h),

                // Bottom Text
                AuthBottomText(
                  questionText: "Don't have an account?",
                  actionText: "Sign Up.",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
