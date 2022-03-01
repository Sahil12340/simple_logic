import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_logic/utils/constants/strings.dart';

import '../bussiness_logic/user_bl.dart';
import '../models/user.dart';
import '../utils/shared_prefrence_helper.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  void onReady() {}

  static void signUp(UserModel userModel) async {
    bool isUserExist = await UserBL.checkIfUserExist(userModel.emailId);
    if (!isUserExist) {
      UserModel user = UserModel(userModel.name, userModel.emailId,
          userModel.password, userModel.lastSeen, userModel.createdOn);
      UserBL().addUser(user);
      Get.snackbar("Registered", "Account Register Successfully.");
    } else {
      Get.snackbar("Already Exists", "User Already Exist.");
    }
  }

  static Future<User?> signUpWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        UserModel userModel = UserModel(user!.displayName.toString(),
            user.email.toString(), "NA", DateTime.now(), DateTime.now());
        signUp(userModel);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Get.snackbar("Already Exists", "User Already Exist.");
        } else if (e.code == 'invalid-credential') {
          Get.snackbar("Invalid Credential", "Account Credential is Invalid.");
        }
      } catch (e) {
        Get.snackbar(
            "Please Try Again", "Something went wrong,please try again.");
      }
    }

    return user;
  }

  Future<void> logoutGoogle() async {
    await googleSignIn.signOut();
    Get.back(); // navigate to your wanted page after logout.
  }

  static void signIn(String emailId, String password) async {
    bool isUserExist = await UserBL.loginUser(emailId, password);
    if (isUserExist) {
      SPHelper().setIsLoggedIn(true);
      Get.offAllNamed(StringConstant.chatScreen);
    } else {
      Get.snackbar(
          "Invalid Credential", "Enter Correct Email Id And Password.");
    }
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
        bool isUserExist =
            await UserBL.loginUserWithEmail(user!.email.toString());
        if (isUserExist) {
          SPHelper().setIsLoggedIn(true);
          Get.offAllNamed(StringConstant.chatScreen);
        } else {
          Get.snackbar("No User Found", "No User Account Found.");
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          Get.snackbar("Already Exists", "User Already Exist.");
        } else if (e.code == 'invalid-credential') {
          Get.snackbar("Invalid Credential", "Account Credential is Invalid.");
        }
      } catch (e) {
        Get.snackbar(
            "Please Try Again", "Something went wrong,please try again.");
      }
    }

    return user;
  }
}
