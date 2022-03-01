import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  late String name,emailId, password;
  late DateTime lastSeen;
  late DateTime createdOn;

  UserModel(this.name,this.emailId, this.password, this.lastSeen, this.createdOn);

  UserModel.fromJson(Map<dynamic, dynamic> json)
      : name = json['name'] as String,
       emailId = json['emailId'] as String,
        password = json['password'] as String,
        lastSeen = json['lastSeen'] as DateTime,
        createdOn = json['createdOn'] as DateTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name.toString(),
        'emailId': emailId.toString(),
        'password': password,
        'lastSeen': lastSeen,
        'createdOn': createdOn,
      };

  UserModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    name = documentSnapshot["name"];
    emailId = documentSnapshot["emailId"];
    password = documentSnapshot["password"];
    lastSeen = documentSnapshot["lastSeen"].toDate();
    createdOn = documentSnapshot["createdOn"].toDate();
  }
}
