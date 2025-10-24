// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/colors/colors.dart';
import '../../../../../core/localization/l10n_ext.dart';
import '../../../../../core/services/firestore_service.dart';
import '../../../../../locator.dart';
import '../../../Home/cubit/home_cubit.dart';
import 'chat_screen.dart';

class ConversationScreen extends StatefulWidget {
  const ConversationScreen({super.key});
  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  String _searchTerm = '';
  late final AnimationController _emptyController;
  late final Animation<double> _floatAnim;

  @override
  void initState() {
    _emptyController = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _floatAnim = Tween<double>(
      begin: -8,
      end: 8,
    ).animate(CurvedAnimation(parent: _emptyController, curve: Curves.easeInOut));
    _emptyController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _emptyController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        // Title
        Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text(
            context.l10n.yourConversations,
            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
          ),
        ),
        const SizedBox(height: 20),

        // Search bar
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: context.l10n.searchHint,
              prefixIcon: const Icon(Icons.search),

              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
            ),
            onChanged: (term) => setState(() => _searchTerm = term.trim().toLowerCase()),
          ),
        ),

        // Conversations list
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 20),
            child: StreamBuilder(
              stream: FirestoreService().getUserChats(getIt<HomeCubit>().state.user.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('${context.l10n.errorLabel}: ${snapshot.error}'));
                }
                final chats = snapshot.data ?? [];
                final filtered =
                    _searchTerm.isEmpty
                        ? chats
                        : chats.where((c) => c.vendorName.toLowerCase().contains(_searchTerm)).toList();
                if (filtered.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedBuilder(
                            animation: _floatAnim,
                            builder:
                                (context, child) => Transform.translate(offset: Offset(0, _floatAnim.value), child: child),
                            child: Icon(Icons.chat_bubble_outline, size: 120, color: AppColors.grayTextColor.withAlpha(100)),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            context.l10n.noConversationsYet,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryTextColor,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            context.l10n.startByContactingSellers,
                            style: GoogleFonts.poppins(fontSize: 14, color: AppColors.grayTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const Padding(padding: EdgeInsets.only(left: 12.0), child: Divider()),
                  itemBuilder: (context, index) {
                    final chat = filtered[index];

                    return ListTile(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => ChatScreen(chat: chat))),
                      // onLongPress: () async {
                      //   final confirmed = await showDialog<bool>(
                      //     context: context,
                      //     builder:
                      //         (context) => AlertDialog(
                      //           title: Text(context.l10n.deleteConversationTitle),
                      //           content: Text(context.l10n.deleteConversationBody),
                      //           actions: [
                      //             TextButton(
                      //               onPressed: () => Navigator.pop(context, false),
                      //               child: Text(context.l10n.commonCancel),
                      //             ),
                      //             TextButton(
                      //               onPressed: () => Navigator.pop(context, true),
                      //               child: Text(context.l10n.commonDelete),
                      //             ),
                      //           ],
                      //         ),
                      //   );
                      //   if (confirmed == true) await FirestoreService().deleteChat(chat.id);
                      // },
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: FadeInImage.assetNetwork(
                          image: chat.vendorImage,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          placeholderFit: BoxFit.cover,
                          placeholder: 'assets/images/saudian_man.png',
                          imageErrorBuilder: (context, error, stackTrace) => Image.asset('assets/images/saudian_man.png'),
                        ),
                      ),
                      title: Text(
                        chat.vendorName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primaryTextColor,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat.lastMessage,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: AppColors.grayTextColor,
                            ),
                          ),
                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              chat.lastTimestamp.toString().substring(0, 16).replaceAll('T', '  '),
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                color: AppColors.grayTextColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ],
    ),
  );
}
