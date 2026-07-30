import 'package:EcoSense/services/api_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../verify_email/verify_code_screen.dart';
import '../login_and_signup/signup_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String? email;
  const ForgotPasswordScreen({super.key, this.email});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final Color _primaryGreen = const Color(0xFF4A7B59);

  final _emailController = TextEditingController();
  late TapGestureRecognizer _signUpRecognizer;

  @override
  void initState() {
    super.initState();
    _signUpRecognizer = TapGestureRecognizer()..onTap = _navigateToSignUp;
    if (widget.email != null) {
      _emailController.text = widget.email!;
    }
  }

  void _navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignupScreen(),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _signUpRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  horizontal: 24.0, vertical: 40.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight - 80.0,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),

                      Text(
                        "Reset your password",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: _primaryGreen,
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Enter the email address associated with your account and\nwe'll send OTP to reset your password.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // FIXED: controller added
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: "Email",
                          hintStyle: const TextStyle(color: Colors.grey),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            const BorderSide(color: Colors.grey, width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide(
                                color: Colors.grey.shade300, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide:
                            BorderSide(color: _primaryGreen, width: 1),
                          ),
                        ),
                      ),

                      const SizedBox(height: 40),

                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),

                          onPressed: () async {
                            final email = _emailController.text.trim();

                            if (email.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Please enter email")),
                              );
                              return;
                            }

                            final response =
                            await ApiService.forgetPasswordEmail(
                                email: email);

                            if (!mounted) return;

                            if (response["status"] != "error") {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                    Text("OTP sent successfully")),
                              );

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => VerifyCodeScreen(
                                    email: email,
                                    isPasswordReset: true,
                                  ),
                                ),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    response["message"] ??
                                        "Request failed",
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text(
                            "Continue",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Return to Login",
                          style: TextStyle(
                            color: Color(0xFF555555),
                            fontSize: 14,
                          ),
                        ),
                      ),

                      const Spacer(),

                      RichText(
                        text: TextSpan(
                          text: "Create a ",
                          style:
                          const TextStyle(color: Colors.grey, fontSize: 14),
                          children: [
                            TextSpan(
                              text: "New account",
                              recognizer: _signUpRecognizer,
                              style: const TextStyle(
                                color: Color(0xFF555555),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}