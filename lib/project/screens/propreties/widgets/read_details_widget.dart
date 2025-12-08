import 'package:flutter/material.dart';

import '../../../../../config/widget/helper.dart';

class ReadDetailsWidget extends StatelessWidget {
  const ReadDetailsWidget({required this.details, super.key});
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
              children: [TextWidget(text: details, color: Color(0xFF757575), fontSize: 16, fontWeight: FontWeight.w400)],
            ),
          ),
          Row(children: []),
        ],
      ),
    );
  }
}
