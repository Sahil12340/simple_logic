import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_logic/controllers/user_controller.dart';
import 'package:simple_logic/models/user.dart';

import '../utils/constants/dimens.dart';
import '../utils/constants/strings.dart';
import '../utils/helper.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SignUpScreenState();
  }
}

class SignUpScreenState extends State<SignUpScreen> {
  late MediaQueryData _mediaQuery;

  final TextEditingController etName = TextEditingController();
  final TextEditingController etEmail = TextEditingController();
  final TextEditingController etPassword = TextEditingController();
  final TextEditingController etConfirmPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    _mediaQuery = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: SizedBox(
            height: _mediaQuery.size.height ,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
        GestureDetector(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(Dimens.dimenTwentyFive),
            child: Text(
              "Login",
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  fontSize: _mediaQuery.size.width * 0.05,
                  color: Colors.black45,
                  fontWeight: FontWeight.w500),
            ),
          ),
          onTap: () {
            Get.offNamed(StringConstant.loginScreen);
          },
        ),
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
            "Sign Up",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: _mediaQuery.size.width * 0.05,
                fontWeight: FontWeight.w500),
          ),
        ),
        const Spacer(),
        Container(
          alignment: Alignment.center,
          height: _mediaQuery.size.height * 0.045,
          width: _mediaQuery.size.width * 0.1,
          margin: const EdgeInsets.all(Dimens.dimenTwentyFive),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1, color: Colors.red),
              color: Colors.redAccent),
          child: const Icon(
            Icons.person_outline_rounded,
            color: Colors.white,
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
          top: Dimens.dimenForty,
          bottom: Dimens.dimenHundred / 2),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Hello ',
              style: GoogleFonts.poppins(
                  fontSize: _mediaQuery.size.width * 0.08,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
            ),
            TextSpan(
              text: 'Beautiful,\n',
              style: GoogleFonts.poppins(
                  fontSize: _mediaQuery.size.width * 0.08,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text:
                  'Enter your information below or\nlogin with a social account',
              style: GoogleFonts.poppins(
                  fontSize: _mediaQuery.size.width * 0.035,
                  color: Colors.black87,
                  fontWeight: FontWeight.w500),
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
                  controller: etName,
                  focusNode: _nameFocusNode,
                  style: GoogleFonts.poppins(color: Colors.black87),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Name Cannot Be Empty.';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (_) {
                    Helper.fieldFocusChange(
                        context, _nameFocusNode, _emailFocusNode);
                  },
                  decoration: InputDecoration(
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                    fillColor: Colors.white,
                    hintText: 'Name',
                    hintStyle: GoogleFonts.poppins(
                        color: Colors.black38, fontWeight: FontWeight.w500),
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
                  left: Dimens.dimenTwentyFive,
                  right: Dimens.dimenTwentyFive,
                  bottom: Dimens.dimenTwentyFive),
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
                        color: Colors.black38, fontWeight: FontWeight.w500),
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
                  left: Dimens.dimenTwentyFive,
                  right: Dimens.dimenTwentyFive,
                  bottom: Dimens.dimenTwentyFive),
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
                onFieldSubmitted: (_) {
                  Helper.fieldFocusChange(
                      context, _passwordFocusNode, _confirmPasswordFocusNode);
                },
                decoration: InputDecoration(
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  fillColor: Colors.white,
                  hintText: 'Password',
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.black38, fontWeight: FontWeight.w500),
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
          Container(
              margin: const EdgeInsets.only(
                  left: Dimens.dimenTwentyFive, right: Dimens.dimenTwentyFive),
              child: TextFormField(
                controller: etConfirmPassword,
                focusNode: _confirmPasswordFocusNode,
                style: GoogleFonts.poppins(color: Colors.black87),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password Cannot Be Empty.';
                  }
                  if (value.length < 5 || value.length > 8) {
                    return 'Password Should Consist Of Minimum 5 And Maximum Of 8 Character.';
                  }
                  if (etPassword.text.isNotEmpty) {
                    if (value.toString() != etPassword.text) {
                      return 'Password Does Not Match!.';
                    }
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
                  hintText: 'Password Again',
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.black38, fontWeight: FontWeight.w500),
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
              UserController.signUpWithGoogle(context: context);
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
            Align(
              alignment: const Alignment(1, 1.5),
              child: GestureDetector(
                child: Container(
                  height: _mediaQuery.size.height * 0.08,
                  width: _mediaQuery.size.width * 0.35,
                  color: const Color(0xffeb5757),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 40,
                  ),
                ),
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    UserModel user = UserModel(etName.text, etEmail.text,
                        etPassword.text, DateTime.now(), DateTime.now());
                    UserController.signUp(user);
                  }
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
