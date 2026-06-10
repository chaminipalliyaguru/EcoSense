import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'signup_screen.dart';
import '../forgot_password/forgot_password_screen.dart';
import '../../data/user_session.dart';
import 'widgets/auth_widgets.dart';
import 'utils/validators.dart';
import 'utils/google_auth_helper.dart';
import '../../services/api_service.dart';

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
                  hintText: "Email",
                  controller: _emailController,
                  validator: (value) => value == null || value.isEmpty ? 'Please enter Email.' : null,
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: _primaryGreen,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),

                // Login Button
                AuthPrimaryButton(
                  text: "Login",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final response = await ApiService.login(
                        identifier: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );

                      if (response["status"] != "error") {
                        // Save session
                        final user = response["user"];
                        final username = user != null ? (user["username"] ?? "") : (response["username"] ?? "");
                        final email = user != null ? (user["email"] ?? "") : (response["email"] ?? _emailController.text.trim());
                        final fullName = user != null ? (user["name"] ?? user["fullName"] ?? "") : (response["name"] ?? response["fullName"] ?? "");
                        final contact = user != null ? (user["contact"] ?? "") : (response["contact"] ?? "");

                        await UserSession.saveUser(
                          username: username.isNotEmpty ? username : email.split('@')[0],
                          email: email,
                          fullName: fullName.isNotEmpty ? fullName : (username.isNotEmpty ? username : email.split('@')[0]),
                          contact: contact,
                        );

                        if (mounted) {
                          // Login success
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Login successful")),
                          );

                          Navigator.pushReplacementNamed(context, '/login_home');
                        }
                      } else {
                        // Login failed
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(response["message"])),
                        );
                      }
                    }
                  }
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
                  questionText: "Don't have an account?",
                  actionText: "Sign Up.",
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen(),
                      ),
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
