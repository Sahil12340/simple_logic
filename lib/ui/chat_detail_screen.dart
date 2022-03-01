import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_logic/bussiness_logic/chat_bl.dart';
import 'package:simple_logic/models/chat.dart';
import 'package:simple_logic/utils/shared_prefrence_helper.dart';

import '../utils/constants/colors.dart';
import '../utils/constants/dimens.dart';

class ChatDetailScreen extends StatefulWidget {
  var receiverId = "";

  ChatDetailScreen(this.receiverId, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ChatDetailScreenState(receiverId);
  }
}

class ChatDetailScreenState extends State<ChatDetailScreen> {
  late MediaQueryData _mediaQuery;
  final TextEditingController etMsg = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var receiverId = "";

  ChatDetailScreenState(this.receiverId);

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: darkBgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: header(),
          ),
          receiveMsgHeader(),
          receiveMsg(),
          Align(alignment: Alignment.centerRight, child: sendMsg()),
          const Spacer(),
          msgBox()
        ],
      ),
    ));
  }

  Widget header() {
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.only(
                top: Dimens.dimenTwenty,
                left: Dimens.dimenFifteen,
                right: Dimens.dimenFifteen),
            child: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 30,
              ),
            )),
        Container(
            margin: const EdgeInsets.only(
                right: Dimens.dimenTwenty, top: Dimens.dimenTwenty),
            child: const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 21.0,
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsaJ8vdeZ0vLK_4X-wQN602hiXrlEsom_YOA&usqp=CAU'),
              ),
            )),
        Container(
          margin: const EdgeInsets.only(
              right: Dimens.dimenTwenty, top: Dimens.dimenTwenty),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Albert Flores",
                style: GoogleFonts.poppins(
                    fontSize: _mediaQuery.size.width * 0.04,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500),
              ),
              Row(
                children: [
                  badge(),
                  Text(
                    "Online",
                    style: GoogleFonts.poppins(
                        fontSize: _mediaQuery.size.width * 0.03,
                        color: Colors.white70,
                        fontWeight: FontWeight.w500),
                  )
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  Widget badge() {
    return Container(
      width: _mediaQuery.size.width * 0.025,
      height: _mediaQuery.size.height * 0.025,
      margin: const EdgeInsets.only(right: Dimens.dimenFive),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 1, color: Colors.green),
          color: Colors.green),
    );
  }

  Widget receiveMsgHeader() {
    return Container(
      margin: const EdgeInsets.only(
          top: Dimens.dimenFifteen, left: Dimens.dimenTwentyFive),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.only(
                  right: Dimens.dimenTwenty, top: Dimens.dimenTwenty),
              child: const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 21.0,
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundImage: NetworkImage(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsaJ8vdeZ0vLK_4X-wQN602hiXrlEsom_YOA&usqp=CAU'),
                ),
              )),
          Text(
            "Albert Flores",
            style: GoogleFonts.poppins(
                fontSize: _mediaQuery.size.width * 0.04,
                color: Colors.white70,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }

  Widget receiveMsg() {
    return Container(
      padding: const EdgeInsets.all(Dimens.dimenTen),
      margin: EdgeInsets.only(left: _mediaQuery.size.width * 0.2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Color(0XFF313d5f),
      ),
      child: Text(
        "Albert Flores",
        style: GoogleFonts.poppins(
            fontSize: _mediaQuery.size.width * 0.03,
            color: Colors.white70,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget sendMsg() {
    return Container(
      padding: const EdgeInsets.all(Dimens.dimenTen),
      margin: EdgeInsets.only(right: _mediaQuery.size.width * 0.08),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: const Color(0XFF4acfee),
      ),
      child: Text(
        "Albert Flores",
        style: GoogleFonts.poppins(
            fontSize: _mediaQuery.size.width * 0.03,
            color: Colors.white70,
            fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget msgBox() {
    return Form(
        key: _formKey,
        child: Container(
            margin: const EdgeInsets.only(
                left: Dimens.dimenTwentyFive,
                right: Dimens.dimenTwentyFive,
                bottom: Dimens.dimenFifteen),
            child: TextFormField(
              controller: etMsg,
              style: const TextStyle(color: Colors.white70),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Message Cannot Be Empty';
                }
                return null;
              },
              onFieldSubmitted: (_) {},
              decoration: InputDecoration(
                filled: true,
                hintText: "Write your message",
                hintStyle: GoogleFonts.poppins(
                    color: Colors.white, fontWeight: FontWeight.normal),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                fillColor: const Color(0xff13254d),
                suffixIcon: SizedBox(
                  width: _mediaQuery.size.width * 0.25,
                  child: Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: const EdgeInsets.all(Dimens.dimenFive),
                          padding: const EdgeInsets.all(Dimens.dimenFive),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0XFF4acfee),
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(Dimens.dimenFive),
                          padding: const EdgeInsets.all(Dimens.dimenFive),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: const Color(0XFF4acfee),
                          ),
                          child: GestureDetector(
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                            onTap: () async{
                              ChatModel chat = ChatModel(
                                  await SPHelper().getUid(),
                                  receiverId,
                                  etMsg.text,
                                  "TEXT",
                                  false,
                                  DateTime.now());
                              ChatBL().addChat(chat);
                            },
                          ),
                        )
                      ],
                    ), // icon is 48px widget.
                  ),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenTwenty),
                  ),
                  borderSide: BorderSide(color: darkBgColor),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenTwenty),
                  ),
                  borderSide: BorderSide(color: darkBgColor),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenTwenty),
                  ),
                  borderSide: BorderSide(color: darkBgColor),
                ),
                errorBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.dimenTwenty),
                  ),
                  borderSide: BorderSide(color: darkBgColor),
                ),
              ),
            )));
  }
}
