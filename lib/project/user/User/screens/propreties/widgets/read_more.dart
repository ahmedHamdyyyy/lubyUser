import 'package:flutter/material.dart';

class ReadMoreTextWidget extends StatelessWidget {
  const ReadMoreTextWidget({super.key, required this.details});
  final String details;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 335,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  details,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Color(0xFF757575), fontSize: 16, fontWeight: FontWeight.w400),
                ),

                // Row(children: []),
              ],
            ),
          ),
          Row(children: []),
        ],
      ),
    );
  }
}
