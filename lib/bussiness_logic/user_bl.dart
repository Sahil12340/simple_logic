import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';
import '../utils/shared_prefrence_helper.dart';

class UserBL {
  static final CollectionReference collection =
      FirebaseFirestore.instance.collection('users');

  Stream<QuerySnapshot> getUsers() {
    return collection.snapshots();
  }

  Future<DocumentReference> addUser(UserModel user) {
    return collection.add(user.toJson());
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

  static Future<bool> checkIfUserExist(String email) async {
    bool isUserExist = false;
    var doc = await collection.where("emailId", isEqualTo: email).get();
    if (doc.size != 0) {
      isUserExist = true;
    } else {
      isUserExist = false;
    }
    return isUserExist;
  }

  static Future<bool> loginUser(String email, String password) async {
    bool isUserExist = false;
    var doc = await collection
        .where("emailId", isEqualTo: email)
        .where("password", isEqualTo: password)
        .get();
    if (doc.size != 0) {
      for (var doc in doc.docs) {
        SPHelper().addUid(doc.reference.id);
      }

      isUserExist = true;
    } else {
      isUserExist = false;
    }
    return isUserExist;
  }

  static Future<bool> loginUserWithEmail(String email) async {
    bool isUserExist = false;
    var doc = await collection
        .where("emailId", isEqualTo: email)
        .get();
    if (doc.size != 0) {
      for (var doc in doc.docs) {
        SPHelper().addUid(doc.reference.id);
      }

      isUserExist = true;
    } else {
      isUserExist = false;
    }
    return isUserExist;
  }
}
