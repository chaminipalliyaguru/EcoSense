import 'dart:async';
import 'package:flutter/material.dart';
import '../../services/api_service.dart';
import '../login_and_signup/login_screen.dart';
import '../forgot_password/new_password_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  final bool isPasswordReset;
  final String email;

  const VerifyCodeScreen({
    super.key,
    required this.email,
    this.isPasswordReset = false,
  });

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final Color _primaryGreen =
      const Color(0xFF4A7B59); // Match image green color
  String _code = "";
  Timer? _timer;
  int _start = 240; // 4 minutes

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    setState(() {
      _start = 240;
    });
    _timer?.cancel();
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get timerText {
    int minutes = _start ~/ 60;
    int seconds = _start % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void _onKeyPress(String value) {
    if (_code.length < 4) {
      setState(() {
        _code += value;
      });
    }
  }

  void _onBackspace() {
    if (_code.isNotEmpty) {
      setState(() {
        _code = _code.substring(0, _code.length - 1);
      });
    }
  }

  Widget _buildKeypadButton(String text) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onKeyPress(text),
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: 8, vertical: isPortrait ? 8 : 4),
          height: isPortrait ? 60 : 35,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.05),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontSize: isPortrait ? 22 : 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBackspaceButton() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Expanded(
      child: GestureDetector(
        onTap: _onBackspace,
        child: Container(
          margin:
              EdgeInsets.symmetric(horizontal: 8, vertical: isPortrait ? 8 : 4),
          height: isPortrait ? 60 : 35,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(
            child: Container(
              padding: EdgeInsets.all(isPortrait ? 12 : 6),
              decoration: BoxDecoration(
                border: Border.all(color: _primaryGreen, width: 1.5),
                borderRadius: BorderRadius.circular(isPortrait ? 16 : 8),
              ),
              child: Icon(
                Icons.backspace_outlined,
                color: _primaryGreen,
                size: isPortrait ? 24 : 16,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Email verified Successfully",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _primaryGreen,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // Email success image
                Image.asset(
                  'assets/images/email-ve-success.png',
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),

                // OK Button
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog

                      if (widget.isPasswordReset) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => NewPasswordScreen(
                                email: widget.email,
                              )),
                        );
                      } else {
                        // Redirect to login page
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(22),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "OK",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: isPortrait ? 40.0 : 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: isPortrait ? 20 : 10),

                    // Title
                    Text(
                      "Enter verification code",
                      style: TextStyle(
                        fontSize: isPortrait ? 28 : 22,
                        fontWeight: FontWeight.bold,
                        color: _primaryGreen,
                      ),
                    ),
                    SizedBox(height: isPortrait ? 16 : 8),

                    // Subtitle
                    const Text(
                      "We have send a Code to your Email",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: isPortrait ? 40 : 16),

                    // Code Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          width: isPortrait ? 65 : 45,
                          height: isPortrait ? 65 : 45,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              _code.length > index ? _code[index] : "",
                              style: TextStyle(
                                fontSize: isPortrait ? 24 : 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: isPortrait ? 40 : 20),

                    // Verify Button
                    SizedBox(
                      width: double.infinity,
                      height: isPortrait ? 55 : 45,
                      child: ElevatedButton(
                        onPressed: () async {
                          final response = await ApiService.verifyOTP(
                            email: widget.email,
                            otp: _code,
                          );
                          // Show dialog when verify is clicked
                          if (response["status"] == "success") {
                            _showSuccessDialog();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  response["message"] ?? "Invalid OTP",
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          "Verify",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isPortrait ? 18 : 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: isPortrait ? 24 : 12),

                    // Resend text
                    Column(
                      children: [
                        const Text(
                          "Didn't receive the Code?",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 4),
                        GestureDetector(
                          onTap: _start == 0
                              ? () {
                                  startTimer();
                                  // TODO: Add resend API call
                                }
                              : null,
                          child: Text(
                            _start == 0 ? "Resend." : "Resend in $timerText",
                            style: TextStyle(
                              color: _start == 0
                                  ? _primaryGreen
                                  : const Color(0xFF555555),
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Custom Keypad
            Container(
              padding: EdgeInsets.fromLTRB(
                  16, isPortrait ? 24 : 6, 16, isPortrait ? 24 : 6),
              decoration: const BoxDecoration(
                color: Color(0xFFEEEEEE),
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      _buildKeypadButton("1"),
                      _buildKeypadButton("2"),
                      _buildKeypadButton("3"),
                    ],
                  ),
                  Row(
                    children: [
                      _buildKeypadButton("4"),
                      _buildKeypadButton("5"),
                      _buildKeypadButton("6"),
                    ],
                  ),
                  Row(
                    children: [
                      _buildKeypadButton("7"),
                      _buildKeypadButton("8"),
                      _buildKeypadButton("9"),
                    ],
                  ),
                  Row(
                    children: [
                      const Expanded(
                          child: SizedBox()), // Empty space for bottom left
                      _buildKeypadButton("0"),
                      _buildBackspaceButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
