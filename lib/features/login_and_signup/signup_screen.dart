import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../api.dart';
import '../verify_email/verify_code_screen.dart';
import 'widgets/auth_widgets.dart';
import 'utils/validators.dart';

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

                // User Name Field
                AuthTextField(
                  hintText: "User Name",
                  controller: _usernameController,
                  validator: Validators.validateUserName,
                ),
                SizedBox(height: 20.h),

                // Full Name Field
                AuthTextField(
                  hintText: "Full Name",
                  controller: _fullNameController,
                  validator: Validators.validateName,
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
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please re-enter your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 40.h),

                // Sign up Button
                AuthPrimaryButton(
                  text: "Sign up",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final response = await ApiService.signup(
                          name: _fullNameController.text.trim(),
                          username: _usernameController.text.trim(),
                          email: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );

                        if (response["status"] == "success") {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Signup successful")),
                          );

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const VerifyCodeScreen()),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(response["message"] ?? "Signup failed")),
                          );
                        }
                      }
                    }
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
      ),
    );
  }
}
