import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});
  @override
  State<ImagePickerWidget> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerWidget> {
  final List<String> _imagePaths = [];
  final _picker = ImagePicker();
  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) setState(() => _imagePaths.add(pickedFile.path));
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      Container(
        decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              ..._imagePaths.map((imagePath) => _buildImageThumbnail(imagePath)),
              if (_imagePaths.length < 5) _buildAddButton(),
            ],
          ),
        ),
      ),
    ],
  );

  Widget _buildImageThumbnail(String imagePath) => Padding(
    padding: const EdgeInsets.only(right: 8.0),
    child: Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(width: 80, height: 80, child: Image.file(File(imagePath), fit: BoxFit.cover)),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => setState(() => _imagePaths.remove(imagePath)),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 16, color: Colors.black),
            ),
          ),
        ),
      ],
    ),
  );

  Widget _buildAddButton() => GestureDetector(
    onTap: _pickImage,
    child: Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(8)),
      child: const Center(child: Icon(Icons.add, color: Colors.grey, size: 30)),
    ),
  );
}
