import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../services/api_service.dart';
import '../verify_email/verify_code_screen.dart';
import 'login_screen.dart';
import 'widgets/auth_widgets.dart';
import 'widgets/password_requirements.dart';
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
  bool _isLoading = false;

  final Color _primaryGreen = const Color(0xFF4A7B59);

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(_onPasswordChanged);
  }

  void _onPasswordChanged() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _passwordController.removeListener(_onPasswordChanged);
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
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: SingleChildScrollView(
              padding:
                  EdgeInsets.symmetric(horizontal: 24.0.w, vertical: 40.0.h),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    // Sign Up Title
                    Text(
                      "Sign up",
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    PasswordRequirements(
                      password: _passwordController.text,
                      primaryGreen: _primaryGreen,
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
                          _obscureRePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
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
                // Sign up Button
                AuthPrimaryButton(
                    text: "Sign up",
                    isLoading: _isLoading,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => _isLoading = true);
                        try {
                          final response = await ApiService.signup(
                            name: _fullNameController.text.trim(),
                            username: _usernameController.text.trim(),
                            email: _emailController.text.trim(),
                            password: _passwordController.text.trim(),
                          );

                            if (!mounted) return;

                            if (response["status"] != "error") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text(
                                        "Signup successful, check your email for OTP")),
                              );

                              if (mounted) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VerifyCodeScreen(
                                            email:
                                                _emailController.text.trim(),
                                          )),
                                );
                              }
                            } else {
                              final message =
                                  response["message"] ?? "Signup failed";
                              final isAlreadySignedUp = message
                                      .toString()
                                      .toLowerCase()
                                      .contains("already exists") ||
                                  message
                                      .toString()
                                      .toLowerCase()
                                      .contains("already registered");

                              if (isAlreadySignedUp) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "$message. Redirecting to Login..."),
                                    duration: const Duration(seconds: 2),
                                  ),
                                );

                                Future.delayed(const Duration(seconds: 2), () {
                                  if (mounted) {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const LoginScreen(),
                                      ),
                                    );
                                  }
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(message.toString())),
                                );
                              }
                            }
                        } finally {
                          if (mounted) setState(() => _isLoading = false);
                        }
                      }
                    }),
                    SizedBox(height: 16.h),

                    /*
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
                    */
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
        ),
      ),
    );
  }
}
