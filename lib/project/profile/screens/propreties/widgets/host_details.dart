import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../../config/images/assets.dart';
import '../../../../../../config/widget/helper.dart';
import '../../../../../locator.dart';
import '../../../../Home/cubit/home_cubit.dart';
import '../../../../models/chat.dart';
import '../../Conversations/chat_screen.dart';

class HostDetailsWidget extends StatelessWidget {
  const HostDetailsWidget({super.key, required this.vendorName, required this.vendorImageUrl, required this.vendorId});
  final String vendorName, vendorImageUrl, vendorId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage:
                vendorImageUrl.isNotEmpty
                    ? NetworkImage(vendorImageUrl)
                    : const AssetImage(AssetsData.host) as ImageProvider,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: 'Hosted by', color: Color(0xFF414141), fontSize: 16, fontWeight: FontWeight.w600),
              TextWidget(text: vendorName, color: Color(0xFF757575), fontSize: 14, fontWeight: FontWeight.w400),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              final user = getIt<HomeCubit>().state.user;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ChatScreen(
                      chat: ChatModel(
                        id: '${vendorId}_${user.id}',
                        vendorId: vendorId,
                        vendorName: vendorName,
                        vendorImageUrl: vendorImageUrl,
                        lastMessage: '',
                        lastTimestamp: DateTime.now(),
                        userId: user.id,
                        userImageUrl: user.profilePicture,
                        userName: '${user.firstName} ${user.lastName}',
                      ),
                    );
                  },
                ),
              );
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
