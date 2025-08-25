import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/colors/colors.dart';
import '../../../../../../locator.dart';
import '../../../Home/cubit/home_cubit.dart';
import '../../../auth/view/Screen/auth/sign_in.dart';
import 'all_widget_chats.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final String userImage;
  final String vendorId;
  final bool isOnline;

  const ChatScreen({
    super.key,
    required this.userName,
    required this.userImage,
    required this.vendorId,
    this.isOnline = false,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  String? _currentUserId;
  String? _chatRoomId;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  Future<void> _initializeChat() async {
    try {
      // Get current user ID from custom auth system
      final homeCubit = getIt<HomeCubit>();
      
      // Check if user is already loaded
      if (homeCubit.state.user.id.isNotEmpty) {
        _currentUserId = homeCubit.state.user.id;
        _chatRoomId = _chatService.getChatRoomId(_currentUserId!, widget.vendorId);
        setState(() {
          _isLoading = false;
        });
      } else {
        // Try to fetch user if not loaded
        homeCubit.fetchUser();
        
        // Wait for the fetch to complete
        await Future.delayed(const Duration(milliseconds: 1000));
        
        if (homeCubit.state.user.id.isNotEmpty) {
          _currentUserId = homeCubit.state.user.id;
          _chatRoomId = _chatService.getChatRoomId(_currentUserId!, widget.vendorId);
        } else {
          // If still no user, show authentication required
          print('No user found, authentication required');
        }
        
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      print('Error initializing chat: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _handleSendMessage() async {
    final text = _messageController.text.trim();
    if (text.isNotEmpty && _currentUserId != null && _chatRoomId != null) {
      try {
        // Ensure chat room exists before sending message
        await _chatService.ensureChatRoom(_chatRoomId!, [_currentUserId!, widget.vendorId]);
        
        final message = ChatMessage(
          id: '',
          text: text,
          senderId: _currentUserId!,
          receiverId: widget.vendorId,
          isMe: true,
          timestamp: DateTime.now(),
          time: '',
        );

        await _chatService.sendMessage(_chatRoomId!, message);
        _messageController.clear();
      } catch (e) {
        print('Error sending message: $e');
        String errorMessage = 'فشل في إرسال الرسالة';
        
        if (e.toString().contains('permission-denied')) {
          errorMessage = 'خطأ في الأذونات: تأكد من تسجيل الدخول';
        } else if (e.toString().contains('unavailable')) {
          errorMessage = 'خطأ في الاتصال: تحقق من اتصال الإنترنت';
        } else if (e.toString().contains('خطأ في الأذونات')) {
          errorMessage = e.toString();
        }
        
        // Show error message to user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _navigateToSignIn() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        if (_isLoading) {
          return const Scaffold(
            backgroundColor: Colors.white,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Check if user is authenticated
        final isAuthenticated = homeState.user.id.isNotEmpty;
        
        if (!isAuthenticated) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.chat_bubble_outline, size: 64, color: AppColors.primaryColor),
                  const SizedBox(height: 16),
                  Text(
                    'تسجيل الدخول مطلوب',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'يرجى تسجيل الدخول لبدء الدردشة',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: _navigateToSignIn,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'تسجيل الدخول',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'User ID: ${homeState.user.id}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Update current user ID if it changed
        if (_currentUserId != homeState.user.id) {
          _currentUserId = homeState.user.id;
          _chatRoomId = _chatService.getChatRoomId(_currentUserId!, widget.vendorId);
        }

        return Scaffold(
          backgroundColor: Colors.white,
          body: StreamBuilder<QuerySnapshot>(
            stream: _chatService.getMessages(_chatRoomId!),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                String errorMessage = 'حدث خطأ غير متوقع';
                String debugInfo = '';
                
                if (snapshot.error.toString().contains('permission-denied')) {
                  errorMessage = 'خطأ في الأذونات: تأكد من تسجيل الدخول';
                  debugInfo = 'Firestore Rules: تأكد من تطبيق قواعد الأمان';
                } else if (snapshot.error.toString().contains('unavailable')) {
                  errorMessage = 'خطأ في الاتصال: تحقق من اتصال الإنترنت';
                  debugInfo = 'Network: تحقق من اتصال الإنترنت';
                } else if (snapshot.error.toString().contains('خطأ في الأذونات')) {
                  errorMessage = snapshot.error.toString();
                  debugInfo = 'Custom Error: خطأ في النظام';
                } else {
                  debugInfo = 'Error: ${snapshot.error}';
                }
                
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline, size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        'خطأ في الدردشة',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          errorMessage,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Text(
                          debugInfo,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[500],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Chat Room ID: $_chatRoomId',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isLoading = true;
                          });
                          _initializeChat();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                );
              }

              List<ChatMessage> messages = [];
              if (snapshot.hasData) {
                messages = snapshot.data!.docs
                    .map((doc) => ChatMessage.fromFirestore(doc, _currentUserId!))
                    .toList();
                // Sort messages by timestamp (oldest first for display)
                messages.sort((a, b) => a.timestamp.compareTo(b.timestamp));
              }

              return ChatScreenContent(
                userName: widget.userName,
                userImage: widget.userImage,
                isOnline: widget.isOnline,
                messages: messages,
                messageController: _messageController,
                onSendPressed: _handleSendMessage,
              );
            },
          ),
        );
      },
    );
  }
}
