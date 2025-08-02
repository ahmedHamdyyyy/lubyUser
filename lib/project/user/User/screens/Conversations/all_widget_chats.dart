import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../config/images/image_assets.dart';
import 'package:google_fonts/google_fonts.dart';

// ------------------------ Chat Message Model ------------------------

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}

// ------------------------ Chat Screen Widgets ------------------------

// User Info Header Widget
class UserInfoHeaderWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final bool isOnline;

  const UserInfoHeaderWidget({
    super.key,
    required this.userName,
    required this.userImage,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Row(
        children: [
          // User image with online status
          Stack(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(userImage),
              ),
              if (isOnline)
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 12),
          // User name and status
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userName,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isOnline ? "Online" : "Offline",
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: isOnline ? Colors.green : Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Chat Message Item Widget
class ChatMessageItemWidget extends StatelessWidget {
  final ChatMessage message;

  const ChatMessageItemWidget({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: message.isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: message.isMe ? 80 : 0,
          right: message.isMe ? 0 : 80,
          bottom: 16,
        ),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            // Message bubble
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: message.isMe ? Colors.white : AppColors.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                message.text,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: message.isMe ? AppColors.primaryColor : Colors.white,
                ),
              ),
            ),
            // Message time
            Padding(
              padding: const EdgeInsets.only(top: 4, right: 8, left: 8),
              child: Text(
                message.time,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: AppColors.grayTextColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Message Input Box Widget
class MessageInputBoxWidget extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendPressed;

  const MessageInputBoxWidget({
    super.key,
    required this.controller,
    required this.onSendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 8),
      child: Row(
        children: [
          // Text field
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 5,
                top: 5,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFFEEEEEE)),
              ),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  suffixIcon: InkWell(
                    onTap: () {
                      // Handle emoji button tap
                    },
                    child: Icon(
                      Icons.sentiment_satisfied_alt_outlined,
                      color: AppColors.grayTextColor,
                    ),
                  ),
                  hintText: "message",
                  hintStyle: GoogleFonts.poppins(
                    color: AppColors.grayTextColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          // Voice message button
          const SizedBox(width: 10),
          InkWell(
            onTap: onSendPressed,
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  ImageAssets.mic,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Chat Screen Content Widget
class ChatScreenContent extends StatelessWidget {
  final String userName;
  final String userImage;
  final bool isOnline;
  final List<ChatMessage> messages;
  final TextEditingController messageController;
  final VoidCallback onSendPressed;

  const ChatScreenContent({
    super.key,
    required this.userName,
    required this.userImage,
    this.isOnline = false,
    required this.messages,
    required this.messageController,
    required this.onSendPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            const SizedBox(width: 20),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
            ),
            const SizedBox(width: 8),
            Text(
              "Conversations",
              style: GoogleFonts.poppins(
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            )
          ],
        ),
        const SizedBox(height: 22),
        
        // User info header
        UserInfoHeaderWidget(
          userName: userName,
          userImage: userImage,
          isOnline: isOnline,
        ),

        // Messages list
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFF8F8F8),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: messages.length,
              reverse: false,
              itemBuilder: (context, index) {
                return ChatMessageItemWidget(message: messages[index]);
              },
            ),
          ),
        ),

        // Message input box
        MessageInputBoxWidget(
          controller: messageController,
          onSendPressed: onSendPressed,
        ),
      ],
    );
  }
}

// ------------------------ Conversations Screen Widgets ------------------------

// Conversation List Item Widget
class ConversationListItemWidget extends StatelessWidget {
  final String userName;
  final String userImage;
  final String messagePreview;
  final String time;
  final bool isOnline;
  final bool isRead;
  final VoidCallback onTap;

  const ConversationListItemWidget({
    super.key,
    required this.userName,
    required this.userImage,
    required this.messagePreview,
    required this.time,
    this.isOnline = false,
    this.isRead = true,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage(userImage),
          ),
          if (isOnline)
            Positioned(
              bottom: 5,
              right: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
        ],
      ),
      title: Text(
        userName,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.primaryTextColor,
        ),
      ),
      subtitle: Text(
        messagePreview,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.grayTextColor,
        ),
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            time,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.grayTextColor,
            ),
          ),
          const SizedBox(height: 5),
          Icon(
            isRead ? Icons.done_all : Icons.done,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}

// Conversations Screen Content Widget
class ConversationsScreenContent extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSearch;
  final List<Map<String, dynamic>> conversations;
  final Widget? searchBar;

  const ConversationsScreenContent({
    super.key,
    required this.searchController,
    required this.onSearch,
    required this.conversations,
    this.searchBar,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        Row(
          children: [
            const SizedBox(width: 20),
            InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
            ),
            const SizedBox(width: 8),
            Text(
              "Conversations",
              style: GoogleFonts.poppins(
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            )
          ],
        ),
        const SizedBox(height: 22),
        
        // Title
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            'Your Conversations',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        
        // Search bar
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 20),
          child: searchBar ?? TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: "Search...",
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: onSearch,
          ),
        ),
        
        // Conversations list
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 20),
            child: ListView.separated(
              shrinkWrap: true,
              itemCount: conversations.length,
              separatorBuilder: (_, __) => const Padding(
                padding: EdgeInsets.only(left: 12.0),
                child: Divider(),
              ),
              itemBuilder: (context, index) {
                final conversation = conversations[index];
                return ConversationListItemWidget(
                  userName: conversation['userName'],
                  userImage: conversation['userImage'],
                  messagePreview: conversation['messagePreview'],
                  time: conversation['time'],
                  isOnline: conversation['isOnline'],
                  isRead: conversation['isRead'],
                  onTap: conversation['onTap'],
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

// ------------------------ No Chats Screen Widgets ------------------------

// Empty State Widget
class NoChatsWidget extends StatelessWidget {
  final String iconAsset;
  final String message;

  const NoChatsWidget({
    super.key,
    required this.iconAsset,
    this.message = "You don't have any conversation \n yet",
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty state icon
          Container(
            width: 130,
            height: 130,
            margin: const EdgeInsets.only(bottom: 24),
            child: SvgPicture.asset(iconAsset),
          ),

          // Empty state message
          Text(
            message,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.secondTextColor,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// Header Title Widget for Conversations
class ConversationHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final bool showBackButton;

  const ConversationHeaderWidget({
    super.key,
    required this.title,
    this.onTap,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 22),
        Row(
          children: [
            const SizedBox(width: 20),
            if (showBackButton)
              InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back_ios, color: AppColors.grayColorIcon),
              ),
            const SizedBox(width: 8),
            Text(
              "Conversations",
              style: GoogleFonts.poppins(
                color: AppColors.grayTextColor,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 22),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// No Chat Screen Content Widget
class NoChatScreenContent extends StatelessWidget {
  final VoidCallback? onTitleTap;
  final bool showBackButton;
  final String iconAsset;
  final String message;

  const NoChatScreenContent({
    super.key,
    this.onTitleTap,
    this.showBackButton = false,
    this.iconAsset = ImageAssets.chat,
    this.message = "You don't have any conversation \n yet",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        ConversationHeaderWidget(
          title: 'Your Conversations',
          onTap: onTitleTap,
          showBackButton: showBackButton,
        ),
        
        // Empty state
        Expanded(
          child: NoChatsWidget(
            iconAsset: iconAsset,
            message: message,
          ),
        ),
      ],
    );
  }
}
