import 'package:flutter/material.dart';

import '../../../../Home/cubit/home_cubit.dart';
import 'show_image_dialoge.dart';

class ImageListWidget extends StatelessWidget {
  final HomeState state;
  final int index;
  const ImageListWidget({
    super.key,
    required this.state,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 101,
      
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: List.generate(
          state.property.medias.length,
          (index) => InkWell(
            onTap: () {
              
              showImageDialoge(context, state.property.medias[index]);
            },
            child: Container(
              width: 101,
              height: 101,
              margin: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                  image: NetworkImage(state.property.medias[index]),
                  fit: BoxFit.cover,
                  
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
