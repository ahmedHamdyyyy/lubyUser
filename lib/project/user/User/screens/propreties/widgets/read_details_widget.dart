import 'package:flutter/material.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../Home/cubit/home_cubit.dart';

class ReadDetailsWidget extends StatelessWidget {
  final HomeState state;
  const ReadDetailsWidget({
    required this.state,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return  Padding(
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
         
                TextWidget(
                  text:
                      state.property.details,
                  color: Color(0xFF757575),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          Row(children: []),
        ],
      ),
    );
  }
}
