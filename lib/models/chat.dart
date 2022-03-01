import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{

  String? id;
  late String senderId,receiverId,msg,msgType;
  late bool isMessageRead;
  late DateTime createdOn;

  ChatModel(this.senderId, this.receiverId, this.msg, this.msgType,this.isMessageRead,this.createdOn);

  ChatModel.fromJson(Map<dynamic, dynamic> json)
      : senderId = json['senderId'] as String,
        receiverId = json['receiverId'] as String,
        msg = json['msg'] as String,
        msgType = json['msgType'] as String,
        isMessageRead = json['isMessageRead'] as bool,
        createdOn = json['createdOn'] as DateTime;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'senderId': senderId.toString(),
    'receiverId': receiverId,
    'msg': msg,
    'msgType': msgType,
    'isMessageRead': isMessageRead,
    'createdOn': createdOn,
  };

  ChatModel.fromDocumentSnapshot({required DocumentSnapshot documentSnapshot}) {
    id = documentSnapshot.id;
    senderId = documentSnapshot["senderId"];
    receiverId = documentSnapshot["receiverId"];
    msg = documentSnapshot["msg"];
    msgType = documentSnapshot["msgType"];
    isMessageRead = documentSnapshot["isMessageRead"];
    createdOn = documentSnapshot["createdOn"].toDate();
  }

}