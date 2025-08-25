// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'all_widget_chats.dart';
import 'chat_screen.dart';
import 'simple_search_bar.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredConversations = [];
  
  final List<Map<String, dynamic>> _conversations = [
    {
      'userName': 'Mohamed Ahmed',
      'userImage': 'assets/images/saudian_man.png',
      'messagePreview': 'Hello ! howe Are you',
      'time': '12:25 PM',
      'isOnline': true,
      'isRead': true,
    },
    {
      'userName': 'Mohamed Ahmed',
      'userImage': 'assets/images/saudian_man.png',
      'messagePreview': 'Lorem ipsum dolor sit amet, consecr text adipiscing',
      'time': '12:25 PM',
      'isOnline': false,
      'isRead': true,
    },
    {
      'userName': 'Mohamed Ahmed',
      'userImage': 'assets/images/saudian_man.png',
      'messagePreview': 'Hey! How have you ?',
      'time': '12:25 PM',
      'isOnline': false,
      'isRead': false,
    },
    {
      'userName': 'Mohamed Ahmed',
      'userImage': 'assets/images/saudian_man.png',
      'messagePreview': 'Lorem ipsum dolor sit amet',
      'time': '12:25 PM',
      'isOnline': false,
      'isRead': true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _filteredConversations = _conversations;
    
    // Add onTap callback to each conversation
    for (var conversation in _filteredConversations) {
      conversation['onTap'] = () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChatScreen(
              vendorId: conversation['vendorId'],
              userName: conversation['userName'],
              userImage: conversation['userImage'],
              isOnline: conversation['isOnline'],
            ),
          ),
        );
      };
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _handleSearch(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredConversations = _conversations;
      } else {
        _filteredConversations = _conversations.where((conversation) {
          return conversation['userName'].toLowerCase().contains(query.toLowerCase()) ||
                 conversation['messagePreview'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ConversationsScreenContent(
        searchController: _searchController,
        onSearch: _handleSearch,
        conversations: _filteredConversations,
        searchBar: SimpleSearchBar(
          controller: _searchController,
          onSearch: _handleSearch,
        ),
      ),
    );
  }
}
