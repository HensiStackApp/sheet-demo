import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/commonWidget/commonTextFormField.dart';
import 'package:sheet_widget_demo/fireBase_login/login_with_phone/otp_page.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({Key key}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  TextEditingController phoneController = TextEditingController();
  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
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
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Text(
                        "SignIn With PhoneNumber",
                        style:
                            TextStyle(fontSize: 25, color: themeColor, fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: textFormField(
                            text: "Phone Number",
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            prefix: Padding(
                              padding: EdgeInsets.all(4),
                              child: Text('+91'),
                            ),
                            validation: (val) => phoneNumber(val)),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      register(),
                    ],
                  ),
                ),
              ),
            ],
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
              "Register",
              style: TextStyle(color: darkBlue, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      onTap: () {
        if (formKey.currentState.validate()) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OtpPage(
                  phone: phoneController.text.trim(),
                ),
              ));
        }
      },
    );
  }
}

String phoneNumber(String value) {
  if (value.isEmpty) {
    return "This field is required";
  } else if (value.length != 10) {
    return "Phone Number must be of 10 digit";
  } else {
    return null;
  }
}
