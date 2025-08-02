import 'package:flutter/material.dart';
import 'all_widget_chats.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userImage;
  final bool isOnline;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userImage,
    this.isOnline = false,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();

  // List of chat messages
  final List<ChatMessage> _messages = [
    ChatMessage(
      text: "Hello ! howe are you ?",
      isMe: false,
      time: "12:20 PM",
    ),
    ChatMessage(
      text: "Lorem ipsum dolor sit amet, consecr text adipiscing",
      isMe: false,
      time: "12:20 PM",
    ),
    ChatMessage(
      text: "Hey! How have you ?",
      isMe: true,
      time: "12:15 PM",
    ),
    ChatMessage(
      text: "Lorem ipsum dolor sit amet,",
      isMe: true,
      time: "12:15 PM",
    ),
    ChatMessage(
      text: "Lorem ipsum dolor sit,",
      isMe: false,
      time: "12:20 PM",
    ),
    ChatMessage(
      text: "Lorem ipsum dolor sit amet,",
      isMe: false,
      time: "12:20 PM",
    ),
    ChatMessage(
      text: "Lorem ipsum dolor sit amet,",
      isMe: true,
      time: "12:20 PM",
    ),
    ChatMessage(
      text: "Lorem ipsum dolor sit amet,",
      isMe: true,
      time: "12:20 PM",
    ),
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSendMessage() {
    final text = _messageController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _messages.add(ChatMessage(
          text: text,
          isMe: true,
          time: "${DateTime.now().hour}:${DateTime.now().minute}",
        ));
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ChatScreenContent(
        userName: widget.userName,
        userImage: widget.userImage,
        isOnline: widget.isOnline,
        messages: _messages,
        messageController: _messageController,
        onSendPressed: _handleSendMessage,
      ),
    );
  }
}
