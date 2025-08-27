import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';

class ImagePickerWidget extends StatefulWidget {
  const ImagePickerWidget({super.key});

  @override
  State<ImagePickerWidget> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerWidget> {
  final List<String> _imagePaths = [];
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile =
          await _picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        setState(() {
          _imagePaths.add(pickedFile.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
      return   _imagePaths.isEmpty ? Container(
        height: 103,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xFFCBCBCB)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: _pickImage,
                    child: SvgPicture.asset(
                      ImageAssets.uploadIcon,
                      width: 40,
                      height: 40,
                    )),
                const SizedBox(height: 4),
                Text(  'Upload studio photos or video',
                    style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: AppColors.grayTextColor)),
              ],
            ),
          ],
        ),
      ) : SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: 
       // crossAxisAlignment: CrossAxisAlignment.start,
        
         
          Container(

            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  // Display selected images
                  ..._imagePaths
                      .map((imagePath) => _buildImageThumbnail(imagePath)),
      
                  // Add button
                  if (_imagePaths.length < 7) _buildAddButton(),
                ],
              ),
            ),
          ),
       
    );
  }

  Widget _buildImageThumbnail(String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _imagePaths.remove(imagePath);
                });
              },
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 16,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Icon(
            Icons.add,
            color: Colors.grey,
            size: 30,
          ),
        ),
      ),
    );
  }
}
