import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_logic/controllers/chat_controller.dart';
import 'package:simple_logic/models/chat.dart';
import 'package:simple_logic/models/user.dart';
import 'package:simple_logic/utils/constants/colors.dart';
import 'package:simple_logic/utils/constants/strings.dart';
import 'package:simple_logic/utils/shared_prefrence_helper.dart';

import '../utils/constants/dimens.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatScreenState();
  }
}

class ChatScreenState extends State<ChatScreen> {
  late MediaQueryData _mediaQuery;
  final TextEditingController etSearch = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkBgColor,
      body: Column(
        children: [header(), searchBox(), listForChatCard()],
      ),
    ));
  }

  Widget header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(
              top: Dimens.dimenTwenty,
              bottom: Dimens.dimenTwenty,
              left: Dimens.dimenTwentyFive),
          child: Text(
            "Meowsenger",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: _mediaQuery.size.width * 0.06,
                color: Colors.white60,
                fontWeight: FontWeight.w500),
          ),
        ),
        Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(Dimens.dimenTwenty),
            child: IconButton(
              onPressed: () {
                showPopupMenu();
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
            ))
      ],
    );
  }

  Widget searchBox() {
    return Form(
        key: _formKey,
        child: Container(
            margin: const EdgeInsets.only(
                left: Dimens.dimenTwentyFive,
                right: Dimens.dimenTwentyFive,
                bottom: Dimens.dimenFifteen),
            child: TextFormField(
              controller: etSearch,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]")),
              ],
              style: const TextStyle(color: Colors.black87),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Name Cannot Be Empty';
                }
                return null;
              },
              onFieldSubmitted: (_) {},
              decoration: InputDecoration(
                filled: true,
                hintText: "Search your message",
                hintStyle: GoogleFonts.poppins(
                    color: Colors.white24, fontWeight: FontWeight.normal),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                fillColor: Colors.transparent,
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ), // icon is 48px widget.
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenFifteen),
                  ),
                  borderSide: BorderSide(color: Colors.white38),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenFifteen),
                  ),
                  borderSide: BorderSide(color: Colors.white38),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenFifteen),
                  ),
                  borderSide: BorderSide(color: Colors.white38),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenFifteen),
                  ),
                  borderSide: BorderSide(color: Colors.white38),
                ),
              ),
            )));
  }

  Widget chatCard(UserModel userModel, ChatModel chatModel) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.only(
            left: Dimens.dimenTwentyFive,
            right: Dimens.dimenTwentyFive,
            top: Dimens.dimenTwentyFive,
            bottom: Dimens.dimenTen),
        child: Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: Dimens.dimenTwentyFive),
                child: const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 21.0,
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(
                        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsaJ8vdeZ0vLK_4X-wQN602hiXrlEsom_YOA&usqp=CAU'),
                  ),
                )),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userModel.name,
                  style: GoogleFonts.poppins(
                      fontSize: _mediaQuery.size.width * 0.05,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  chatModel.msg,
                  style: GoogleFonts.poppins(
                      fontSize: _mediaQuery.size.width * 0.03,
                      color: Colors.white30,
                      fontWeight: FontWeight.normal),
                ),
              ],
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.all(Dimens.dimenFive),
              child: Text(
                "05:00 AM",
                style: GoogleFonts.poppins(
                    fontSize: _mediaQuery.size.width * 0.035,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500),
              ),
            ),
            badge()
          ],
        ),
      ),
      onTap: () {
        StringConstant.receiverID = userModel.id.toString();
        Get.toNamed(
          StringConstant.chatDetailScreen,
          arguments: [
            userModel.id,
            userModel.name
          ],
        );
      },
    );
  }

  Widget listForChatCard() {
    return GetX<ChatController>(
        init: Get.put<ChatController>(ChatController()),
        builder: (ChatController chatController) {
          return Expanded(
              child: ListView.builder(
                  itemCount: chatController.user.length,
                  itemBuilder: (context, i) {
                    return chatCard(
                        chatController.user[i], chatController.chat[i]);
                  }));
        });
  }

  Widget badge() {
    return Container(
      width: 22,
      height: 22,
      margin: const EdgeInsets.all(Dimens.dimenFive),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Colors.red),
          color: Colors.redAccent),
      child: Text(
        "3",
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
            fontSize: _mediaQuery.size.width * 0.03,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  showPopupMenu() {
    showMenu<String>(
      context: context,
      position: const RelativeRect.fromLTRB(50.0, 90.0, 0.0, 0.0),
      items: [
        PopupMenuItem<String>(
            child: Text(
              "Logout",
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.normal,
                  fontSize: _mediaQuery.size.width * 0.03),
            ),
            value: '1'),
      ],
      elevation: 8.0,
    ).then<void>((String? itemSelected) async {
      if (itemSelected == null) return;
      if (itemSelected == "1") {
        SPHelper().setIsLoggedIn(false);
        Get.offAllNamed(StringConstant.loginScreen);
      }
    });
  }
}
