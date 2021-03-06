import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simple_logic/models/chat.dart';
import 'package:async/async.dart' show StreamGroup;

import '../models/user.dart';
import '../utils/constants/strings.dart';

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
        if (user.reference.id != StringConstant.userId) {
          final usersModel =
              UserModel.fromDocumentSnapshot(documentSnapshot: user);
          users.add(usersModel);
        }
      }
      return users;
    });
  }

  static Stream<List<ChatModel>> chatStream() {
    List<ChatModel> chats = [];
    return FirebaseFirestore.instance
        .collection('chats')
        .where("senderId", isEqualTo: StringConstant.userId)
        .snapshots()
        .map((QuerySnapshot query) {
      for (var chat in query.docs) {
        if (chat.get("receiverId").toString() == StringConstant.userId ||
            chat.get("senderId").toString() == StringConstant.userId) {
          final chatModel =
          ChatModel.fromDocumentSnapshot(documentSnapshot: chat);
          chats.add(chatModel);
        }
      }
      return chats;
    });
  }

  static Stream<List<ChatModel>> chatDetailStream(String receiverId) {
    List<ChatModel> chats = [];
    return FirebaseFirestore.instance
        .collection('chats')
        .snapshots()
        .map((QuerySnapshot query) {
      for (var chat in query.docs) {
        if (chat.get("receiverId").toString() == StringConstant.userId ||
            chat.get("receiverId").toString() == receiverId ||
            chat.get("senderId").toString() == StringConstant.userId ||
            chat.get("senderId").toString() == receiverId) {
          final chatModel =
              ChatModel.fromDocumentSnapshot(documentSnapshot: chat);
          chats.add(chatModel);
        }
      }
      return chats;
    });
  }
}
