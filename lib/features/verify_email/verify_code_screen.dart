import 'package:flutter/material.dart';
import '../login_and_signup/login_screen.dart';

class VerifyCodeScreen extends StatefulWidget {
  const VerifyCodeScreen({super.key});

  @override
  State<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends State<VerifyCodeScreen> {
  final Color _primaryGreen = const Color(0xFF4A7B59); // Match image green color
  String _code = "";

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
    return Expanded(
      child: GestureDetector(
        onTap: () => _onKeyPress(text),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          height: 60,
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
              style: const TextStyle(
                fontSize: 22,
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
    return Expanded(
      child: GestureDetector(
        onTap: _onBackspace,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: _primaryGreen, width: 1.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                Icons.backspace_outlined,
                color: _primaryGreen,
                size: 24,
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
                
                // Placeholder for the email illustration
                Container(
                  width: double.infinity,
                  height: 140,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4E5D4), // Peachy color from screenshot
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.email,
                        size: 80,
                        color: Colors.white.withOpacity(0.9),
                      ),
                      Positioned(
                        right: 70,
                        top: 25,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.red.shade400,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Text(
                            "1",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // OK Button
                SizedBox(
                  width: 150,
                  height: 45,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Close dialog
                      // Redirect to login page
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    
                    // Title
                    Text(
                      "Enter verification code",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: _primaryGreen,
                      ),
                    ),
                    const SizedBox(height: 16),

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
                    const SizedBox(height: 40),

                    // Code Boxes
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(4, (index) {
                        return Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey.shade300, 
                              width: 1
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              _code.length > index ? _code[index] : "",
                              style: const TextStyle(
                                fontSize: 24, 
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),

                    // Verify Button
                    SizedBox(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          // Show dialog when verify is clicked
                          _showSuccessDialog();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryGreen,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(28),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          "Verify",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Resend text
                    RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: "Didn't receive the Code?\n",
                        style: TextStyle(
                          color: Colors.grey, 
                          fontSize: 14, 
                          height: 1.5
                        ),
                        children: [
                          TextSpan(
                            text: "Resend.",
                            style: TextStyle(
                              color: Color(0xFF555555),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Custom Keypad
            Container(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
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
                      const Expanded(child: SizedBox()), // Empty space for bottom left
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
