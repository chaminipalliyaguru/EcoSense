// import 'dart:io';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'scan_frame.dart';
// import 'scan_overlay.dart';
//
// class ImagePreviewOverlay extends StatelessWidget {
//   final File imageFile;
//   final VoidCallback onConfirm;
//   final VoidCallback onRetake;
//   final Color primaryColor;
//   final Animation<double> scanAnimation;
//
//   const ImagePreviewOverlay({
//     super.key,
//     required this.imageFile,
//     required this.onConfirm,
//     required this.onRetake,
//     required this.primaryColor,
//     required this.scanAnimation,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(
//       builder: (context, constraints) {
//         // Preview frame is SMALL (75% width / 65% height)
//         final frameW = constraints.maxWidth * 0.75;
//         final frameH = constraints.maxHeight * 0.65;
//
//         return Container(
//           color: Colors.black,
//           child: Stack(
//             children: [
//               // ── 1. Blurred Background ──
//               Positioned.fill(
//                 child: Stack(
//                   children: [
//                     Image.file(
//                       imageFile,
//                       fit: BoxFit.cover,
//                     ),
//                     BackdropFilter(
//                       filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                       child: Container(
//                         color: Colors.black.withValues(alpha: 0.6),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               // ── 2. The Photo (Centered and sized to fit exactly in frame) ──
//               Center(
//                 child: Container(
//                   width: frameW,
//                   height: frameH,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(4),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withValues(alpha: 0.5),
//                         blurRadius: 20,
//                       )
//                     ],
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(4),
//                     child: Image.file(
//                       imageFile,
//                       fit: BoxFit.cover, // Ensures the photo fills the frame area
//                     ),
//                   ),
//                 ),
//               ),
//
//               // ── 3. Darkened Overlay (with hole for the image) ──
//               ScanOverlay(frameWidth: frameW, frameHeight: frameH),
//
//               // ── 4. Animated Scan Frame (The brackets and scan line) ──
//               Center(
//                 child: ScanFrame(
//                   width: frameW,
//                   height: frameH,
//                   scanAnimation: scanAnimation,
//                   cornerColor: primaryColor,
//                   hintText: 'Verifying report quality...',
//                   showScanLine: true,
//                 ),
//               ),
//
//               // ── Top Title ──
//               Positioned(
//                 top: 40,
//                 left: 0,
//                 right: 0,
//                 child: const Center(
//                   child: Text(
//                     'Verify Report Quality',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//               ),
//
//               // ── Bottom Action Buttons ──
//               Positioned(
//                 bottom: 40,
//                 left: 0,
//                 right: 0,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 32),
//                   child: Row(
//                     children: [
//                       // Retake Button
//                       Expanded(
//                         child: _buildButton(
//                           label: 'Retake',
//                           onPressed: onRetake,
//                           isOutlined: true,
//                         ),
//                       ),
//                       const SizedBox(width: 16),
//                       // OK Button
//                       Expanded(
//                         child: _buildButton(
//                           label: 'OK',
//                           onPressed: onConfirm,
//                           isOutlined: false,
//                           color: primaryColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildButton({
//     required String label,
//     required VoidCallback onPressed,
//     bool isOutlined = false,
//     Color? color,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         boxShadow: [
//           if (!isOutlined)
//             BoxShadow(
//               color: (color ?? Colors.black).withValues(alpha: 0.3),
//               blurRadius: 12,
//               offset: const Offset(0, 4),
//             ),
//         ],
//       ),
//       child: isOutlined
//           ? OutlinedButton(
//               onPressed: onPressed,
//               style: OutlinedButton.styleFrom(
//                 side: const BorderSide(color: Colors.white, width: 1.5),
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               ),
//               child: Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
//             )
//           : ElevatedButton(
//               onPressed: onPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: color,
//                 foregroundColor: Colors.white,
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//                 elevation: 0,
//               ),
//               child: Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//             ),
//     );
//   }
// }
