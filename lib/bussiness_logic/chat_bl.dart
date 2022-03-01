import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_logic/models/chat.dart';
import 'package:simple_logic/utils/shared_prefrence_helper.dart';

import '../models/user.dart';

class ChatBL {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('chats');

  Stream<QuerySnapshot> getChats() {
    return collection.snapshots();
  }

  Future<DocumentReference> addChat(ChatModel chatModel) {
    return collection.add(chatModel.toJson());
  }

  static Stream<List<UserModel>> userStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .map((QuerySnapshot query) {
      List<UserModel> users = [];
      for (var user in query.docs) {
        final usersModel =
            UserModel.fromDocumentSnapshot(documentSnapshot: user);
        users.add(usersModel);
      }
      return users;
    });
  }

  static Stream<List<ChatModel>> chatStream() {
    return FirebaseFirestore.instance
        .collection('chats')
        .where("senderId", isEqualTo: SPHelper().getUid())
        .where("receiverId", isEqualTo: SPHelper().getUid())
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatModel> chats = [];
      for (var chat in query.docs) {
        final chatModel =
            ChatModel.fromDocumentSnapshot(documentSnapshot: chat);
        chats.add(chatModel);
      }
      return chats;
    });
  }
}
