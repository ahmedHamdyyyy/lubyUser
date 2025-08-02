import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../config/images/assets.dart';

import '../../../../../../config/widget/helper.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../Conversations/chat_screen.dart';


class HostDetailsWidget extends StatelessWidget {
  final HomeState state;
  const HostDetailsWidget({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage:state.user.profilePicture.isNotEmpty? 
             NetworkImage(state.user.profilePicture): AssetImage(AssetsData.host),
          ),
          const SizedBox(width: 12),
           Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: 'Hosted by',
                color: Color(0xFF414141),
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              TextWidget(
                text: '${state.user.firstName}${state.user.lastName}',
                color: Color(0xFF757575),
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ChatScreen(userName: '${state.user.firstName}${state.user.lastName}', userImage: AssetsData.host)));
            },
            child: SvgPicture.asset(
              'assets/images/message-2.svg',
              // ignore: deprecated_member_use
              color: const Color(0xFF414141),
              height: 24,
            ),
          ),
        ],
      ),
    );
  }
}
