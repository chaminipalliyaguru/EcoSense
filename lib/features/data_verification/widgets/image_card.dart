import 'dart:io';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onRetake;

  const ImageCard({
    super.key,
    required this.imageFile,
    required this.onRetake,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Column(
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: imageFile != null
                ? ClipRRect(
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(16)),
              child: Image.file(
                imageFile!,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            )
                : const Center(child: Text("No Image Selected")),
          ),

          Padding(
            padding: const EdgeInsets.all(12),
            child: ElevatedButton.icon(
              onPressed: imageFile != null ? onRetake : null,
              icon: const Icon(Icons.camera_alt),
              label: const Text("Retake"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.green,
                elevation: 0,
                side: const BorderSide(color: Colors.green),
              ),
            ),
          )
        ],
      ),
    );
  }
}