import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sheet_widget_demo/commonWidget/commonTextFormField.dart';
import 'package:sheet_widget_demo/fireBase_login/login_with_phone/loginWithPhone.dart';
import 'package:sheet_widget_demo/fireBase_login/services/auth_services.dart';
import 'package:sheet_widget_demo/fireBase_login/services/user_services.dart';
import 'package:sheet_widget_demo/model/userModel.dart';
import 'package:sheet_widget_demo/tabBar_page.dart';
import 'package:sheet_widget_demo/utils/color.dart';
import 'package:sheet_widget_demo/utils/validation.dart';
import 'package:toast/toast.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key key}) : super(key: key);

  @override
  _LogInPageState createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // static final FacebookLogin facebookSignIn = new FacebookLogin();
  FirebaseMessaging _messaging;
  var users = FirebaseAuth.instance.currentUser;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  String verificationId;
  final formKey = new GlobalKey<FormState>();
  AuthServices authServices = AuthServices();
  UserServices userServices = UserServices();

  @override
  void initState() {
    // TODO: implement initState
    msg();
    super.initState();
  }

  Future<void> msg() async {
    await Firebase.initializeApp();
    _messaging = FirebaseMessaging.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: themeColor2
              // gradient: LinearGradient(
              //     begin: Alignment.topCenter,
              //     end: Alignment.bottomCenter,
              //     colors: [themeColor5, themeColor4, themeColor3, themeColor2]),
              ),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [themeColor5, themeColor4, themeColor3, themeColor2]),
                        border: Border.all(
                          width: 2,
                          color: themeColor,
                        ),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0),
                      child: Column(
                        children: [
                          Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 40, color: themeColor, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: textFormField(
                                text: "Enter Email",
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                validation: (val) => validateEmail(val)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: textFormField(
                                text: "Password",
                                controller: passwordController,
                                validation: (val) => validatePassword(val)),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          register(),
                          SizedBox(
                            height: 10,
                          ),
                          loginWithPhone(),
                          SizedBox(
                            height: 10,
                          ),
                          loginWithGoogle(),
                          SizedBox(
                            height: 10,
                          ),
                          loginWithFb()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  register() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: darkBlue, width: 1),
        ),
        height: 40,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Login With Email & Password",
              style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: () {
        if (formKey.currentState.validate()) {
          authServices.signUpWithEmail(
              password: passwordController.text, email: emailController.text, context: context);
          setState(() {});
        }
      },
    );
  }

  loginWithPhone() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: darkBlue, width: 1),
        ),
        height: 40,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Login With PhoneNumber",
              style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginWithPhone(),
          ),
        );
      },
    );
  }

  loginWithGoogle() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: darkBlue, width: 1),
        ),
        height: 40,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset("images/search.png"),
              height: 25,
              width: 30,
            ),
            Text(
              "SignIn with google",
              style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: () async {
        await authServices.authSignOut();
        var firebaseUser = await authServices.signWithGoogle();
        if (firebaseUser != null) {
          UserData userData = UserData(
            email: firebaseUser.email,
            userID: firebaseUser.uid,
            firstName: firebaseUser.displayName,
            lastName: firebaseUser.displayName,
            token: await _messaging.getToken(),
          );
          await userServices.createUser(userData);
          var currentUser = FirebaseAuth.instance.currentUser;
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TabBarPage(userName: currentUser.displayName,)));
          Toast.show('login SuccessFully', context);
          // login SuccessFully
        }
      },
    );
  }

  loginWithFb() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: darkBlue, width: 1),
        ),
        height: 40,
        width: 200,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Image.asset("images/fb.png"),
              height: 25,
              width: 30,
            ),
            Text(
              "SignIn with Facebook",
              style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: () async {
        try {
          EasyLoading.show(
              indicator: CircularProgressIndicator(
            color: themeColor,
          ));
          UserCredential userCredential = await authServices.signWithFaceBook(context);
          if (userCredential != null) {
            print('FB Account Details --> ${userCredential.user.email}');
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => TabBarPage(userName: userCredential.user.email,)));
            Toast.show("Facebook Sign In SuccessFully", context, duration: 7);
          } else {
            print('else-->');
          }
          EasyLoading.dismiss();

        } catch (e) {
          Toast.show(e.toString(), context, duration: 10);
        }
      },
    );
  }
}
