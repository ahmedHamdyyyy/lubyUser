import 'package:flutter/material.dart';

import 'show_image_dialoge.dart';

class ImageListWidget extends StatelessWidget {
  final List<String> images;
  const ImageListWidget({super.key, required this.images});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: List.generate(
          images.length,
          (index) => InkWell(
            onTap: () {
              showImageDialoge(context, images[index]);
            },
            child: Container(
              width: 101,
              height: 101,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(image: NetworkImage(images[index]), fit: BoxFit.cover),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
