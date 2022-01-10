import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sheet_widget_demo/utils/color.dart';

import '../../tabBar_page.dart';

class AuthServices {
  FacebookLogin facebookSignIn = FacebookLogin();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  signWithGoogle() async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(
        backgroundColor: themeColor,
        valueColor: AlwaysStoppedAnimation<Color>(white),
      ));

      GoogleSignInAccount googleUser = await googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      User firebaseUser =
          (await FirebaseAuth.instance.signInWithCredential(credential)).user;
      EasyLoading.dismiss();
      return firebaseUser;
    } catch (e) {
      Fluttertoast.showToast(msg: e.message);
      EasyLoading.dismiss();
      return null;
    }
  }

  authSignOut() async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(
        backgroundColor: themeColor,
        valueColor: AlwaysStoppedAnimation<Color>(white),
      ));
      firebaseAuth.signOut();
      await facebookSignIn.logOut();
      await googleSignIn.signOut();
      EasyLoading.dismiss();
    } catch (e) {
      EasyLoading.dismiss();
      Fluttertoast.showToast(msg: e.message);
    }
  }

  //SIGN UP METHOD
  Future signUpWithEmail(
      {String email, String password, BuildContext context}) async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(
        backgroundColor: themeColor,
        valueColor: AlwaysStoppedAnimation<Color>(white),
      ));
      UserCredential user = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      EasyLoading.dismiss();
      print("user $user");
      print("user- ${user.user.email}");
      if (user.user.email != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabBarPage(userName: user.user.email,)));
      }
      return user;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      print(e);
      Fluttertoast.showToast(msg: e.message);
    }
  }

  //SIGN IN METHOD
  Future signInWithEmail(
      {String email, String password, BuildContext context}) async {
    try {
      EasyLoading.show(
          indicator: CircularProgressIndicator(
        backgroundColor: themeColor,
        valueColor: AlwaysStoppedAnimation<Color>(white),
      ));
      UserCredential user = await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      EasyLoading.dismiss();
      print("user $user");
      print("user- ${user.user.email}");
      if (user.user.email != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => TabBarPage(userName: user.user.email,)));
      }
      return user;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      print(e);
      Fluttertoast.showToast(msg: e.message);
    }
  }

  signWithFaceBook(BuildContext context) async {
    // await facebookSignIn.logOut();
    // final result = await facebookSignIn.logIn(["email"]);
    // switch (result.status) {
    //   case FacebookLoginStatus.loggedIn:
    //     break;
    //   case FacebookLoginStatus.cancelledByUser:
    //     print("cancelled by user");
    //     break;
    //   case FacebookLoginStatus.error:
    //     print("error");
    //     break;
    // }
    await FacebookAuth.instance.logOut();
    final LoginResult result = await FacebookAuth.instance.login();
    if(result.status == LoginStatus.success){
      final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken.token);
      return await FirebaseAuth.instance.signInWithCredential(credential);
    }
    return null;
  }
}
