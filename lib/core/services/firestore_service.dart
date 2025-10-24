import 'package:cloud_firestore/cloud_firestore.dart';

import '../../project/models/chat.dart';

class FirestoreService {
  final _firestore = FirebaseFirestore.instance;
  static const _chatsCollection = 'chats';
  static const _messagesCollection = 'messages';

  Stream<List<ChatModel>> getUserChats(String userId) =>
      _firestore.collection(_chatsCollection).where('userId', isEqualTo: userId).snapshots().map((snapshot) {
        final list = snapshot.docs.map((doc) => ChatModel.fromFirestore(doc.data(), doc.id)).toList();
        list.sort((a, b) => b.lastTimestamp.compareTo(a.lastTimestamp));
        return list;
      });

  Future<void> sendMessage(String chatId, ChatMessage message) async {
    await _firestore.collection(_chatsCollection).doc(chatId).collection(_messagesCollection).add(message.toMap());
    await _firestore.collection(_chatsCollection).doc(chatId).update({
      'lastMessage': message.text,
      'lastTimestamp': Timestamp.fromDate(message.timestamp),
    });
  }

  // Future<void> deleteChat(String chatId) async {
  //   final chatRef = _firestore.collection(_chatsCollection).doc(chatId);
  //   final messagesRef = chatRef.collection(_messagesCollection);
  //   final messagesSnap = await messagesRef.get();
  //   final batch = _firestore.batch();
  //   for (final doc in messagesSnap.docs) {
  //     batch.delete(doc.reference);
  //   }
  //   batch.delete(chatRef);
  //   await batch.commit();
  // }

  Future<void> ensureChatExists(ChatModel chat) async {
    final chatRef = _firestore.collection(_chatsCollection).doc(chat.id);
    final chatDoc = await chatRef.get();
    if (!chatDoc.exists) await chatRef.set(chat.toMap());
  }

  Stream<List<ChatMessage>> getMessages(String chatId) => _firestore
      .collection(_chatsCollection)
      .doc(chatId)
      .collection(_messagesCollection)
      .orderBy('timestamp', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => ChatMessage.fromFirestore(doc.data(), doc.id)).toList());
}
