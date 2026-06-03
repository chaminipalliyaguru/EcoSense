import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../verify_email/verify_code_screen.dart';
import 'widgets/auth_widgets.dart';
import 'utils/validators.dart';
import 'utils/google_auth_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repasswordController = TextEditingController();
  
  bool _obscurePassword = true;
  bool _obscureRePassword = true;

  final Color _primaryGreen = const Color(0xFF4A7B59);

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _repasswordController.dispose();
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

                

                // Full Name Field
                AuthTextField(
                  hintText: "Full Name",
                  controller: _fullNameController,
                  validator: Validators.validateName,
                ),
                SizedBox(height: 20.h),

                
                // User Name Field
                AuthTextField(
                  hintText: "User Name",
                  controller: _usernameController,
                  validator: Validators.validateUserName,
                ),
                SizedBox(height: 20.h),

                // Email Field
                AuthTextField(
                  hintText: "Email",
                  controller: _emailController,
                  validator: Validators.validateEmail,
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
                AuthTextField(
                  hintText: "Re-enter Password",
                  controller: _repasswordController,
                  obscureText: _obscureRePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureRePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureRePassword = !_obscureRePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 40.h),

                // Sign up Button
                AuthPrimaryButton(
                  text: "Sign up",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VerifyCodeScreen()),
                      );
                    }
                  },
                ),
                SizedBox(height: 16.h),

                SizedBox(height: 40.h),

                // OR Divider
                const AuthDivider(),
                SizedBox(height: 40.h),

                // Continue with Google Button
                AuthSocialButton(
                  text: "Continue with Google",
                  logo: const GoogleLogoWidget(size: 34),
                  backgroundColor: Colors.white,
                  borderColor: Colors.grey.shade300,
                  textColor: const Color(0xFF1F1F1F),
                  onPressed: () {
                    GoogleAuthHelper.performGoogleSignIn(context);
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
      ),
    );
  }
}
