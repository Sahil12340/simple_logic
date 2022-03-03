import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_logic/bussiness_logic/user_bl.dart';
import 'package:simple_logic/utils/constants/strings.dart';

import '../controllers/user_controller.dart';
import '../utils/constants/dimens.dart';
import '../utils/helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  late MediaQueryData _mediaQuery;

  final TextEditingController etEmail = TextEditingController();
  final TextEditingController etPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final UserController userController = Get.put(UserController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    UserBL().checkIfLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
          child: SizedBox(
              height: _mediaQuery.size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  header(),
                  title(),
                  textFields(),
                  const Spacer(),
                  footer()
                ],
              ))),
    ));
  }

  Widget header() {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.all(Dimens.dimenTwentyFive),
          padding: const EdgeInsets.only(
            bottom: 5, // space between underline and text
          ),
          decoration: const BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            color: Colors.black, // Text colour here
            width: 1.0, // Underline width
          ))),
          child: Text(
            "Login",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: _mediaQuery.size.width * 0.05,
                fontWeight: FontWeight.w500),
          ),
        ),
        GestureDetector(
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(Dimens.dimenTwentyFive),
              child: Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                    fontSize: _mediaQuery.size.width * 0.05,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500),
              ),
            ),
            onTap: () {
              Get.offNamed(StringConstant.signUpScreen);
            }),
        const Spacer(),
        Container(
          alignment: Alignment.center,
          height: _mediaQuery.size.height * 0.04,
          width: _mediaQuery.size.width * 0.1,
          margin: const EdgeInsets.all(Dimens.dimenTwentyFive),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsaJ8vdeZ0vLK_4X-wQN602hiXrlEsom_YOA&usqp=CAU'),
              fit: BoxFit.fill,
            ),
            shape: BoxShape.circle,
          ),
        )
      ],
    );
  }

  Widget title() {
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.only(
          left: Dimens.dimenTwentyFive,
          top: Dimens.dimenHundred,
          bottom: Dimens.dimenHundred),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Welcome Back,\n',
              style: GoogleFonts.poppins(
                  fontSize: _mediaQuery.size.width * 0.08,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: 'Rebecca',
              style: GoogleFonts.poppins(
                  fontSize: _mediaQuery.size.width * 0.08,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget textFields() {
    return Form(
        key: _formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              margin: const EdgeInsets.all(Dimens.dimenTwentyFive),
              child: TextFormField(
                  controller: etEmail,
                  focusNode: _emailFocusNode,
                  style: GoogleFonts.poppins(color: Colors.black87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Email Address Cannot Be Empty.';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'Invalid Email Address.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) {
                    Helper.fieldFocusChange(
                        context, _emailFocusNode, _passwordFocusNode);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    fillColor: Colors.white,
                    hintText: 'Email address',
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.black45, fontWeight: FontWeight.w500),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    focusedErrorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black45),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                  ))),
          Container(
              margin: const EdgeInsets.only(
                  left: Dimens.dimenTwentyFive, right: Dimens.dimenTwentyFive),
              child: TextFormField(
                controller: etPassword,
                focusNode: _passwordFocusNode,
                style: GoogleFonts.poppins(color: Colors.black87),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password Cannot Be Empty.';
                  }
                  if (value.length < 5 || value.length > 8) {
                    return 'Password Should Consist Of Minimum 5 And Maximum Of 8 Character.';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                obscureText: true,
                onFieldSubmitted: (_) {},
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  fillColor: Colors.white,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.black45, fontWeight: FontWeight.w500),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  focusedErrorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black45),
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              )),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.all(Dimens.dimenTwentyFive),
              child: Image.asset(StringConstant.googleIcon,
                  width: 50, height: 50, fit: BoxFit.contain),
            ),
            onTap: () {
              // UserController.signInWithGoogle( context:context);
            },
          )
        ]));
  }

  Widget footer() {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(
              left: Dimens.dimenTwentyFive, bottom: Dimens.dimenTen),
          child: Text(
            "Forgot Password?",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: _mediaQuery.size.width * 0.04,
                color: Colors.black,
                fontWeight: FontWeight.w500),
          ),
        ),
        Stack(
          children: [
            Container(
              height: _mediaQuery.size.height * 0.1,
              color: Colors.black12,
            ),
            GestureDetector(
              child: Align(
                alignment: const Alignment(1, 1.5),
                child: Container(
                  height: _mediaQuery.size.height * 0.08,
                  width: _mediaQuery.size.width * 0.35,
                  color: const Color(0xfff4d166),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
              ),
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  UserController.signIn(etEmail.text, etPassword.text);
                }
              },
            ),
          ],
        )
      ],
    );
  }
}
