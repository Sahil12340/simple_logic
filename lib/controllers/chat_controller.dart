import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:simple_logic/bussiness_logic/chat_bl.dart';
import 'package:simple_logic/models/user.dart';

import '../bussiness_logic/user_bl.dart';
import '../models/chat.dart';

class ChatController extends GetxController {
  Rx<List<UserModel>> userList = Rx<List<UserModel>>([]);

  List<UserModel> get user => userList.value;
  Rx<List<ChatModel>> chatList = Rx<List<ChatModel>>([]);

  List<ChatModel> get chat => chatList.value;

  @override
  void onReady() {
    userList.bindStream(ChatBL.userStream());
    chatList.bindStream(ChatBL.chatStream());
  }
}
