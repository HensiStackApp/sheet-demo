import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sheet_widget_demo/commonWidget/commonTextFormField.dart';
import 'package:sheet_widget_demo/shared_prefs/share_preferences.dart';
import 'package:sheet_widget_demo/Form_page/userDetail_page.dart';
import 'package:sheet_widget_demo/utils/color.dart';
import 'package:sheet_widget_demo/utils/validation.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key key}) : super(key: key);

  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController bodController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final f = DateFormat('dd-MM-yyyy');
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10, top: 30),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.53,
                    width: MediaQuery.of(context).size.width * 0.95,
                    decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: ListView(
                        children: [
                          textFormField(
                              text: 'Name*',
                              controller: nameController,
                              validation: (val) => validateName(val)),
                          SizedBox(
                            height: 20,
                          ),
                          textFormField(
                              text: 'Email*',
                              controller: emailController,
                              validation: (val) => validateEmail(val),
                              keyboardType: TextInputType.emailAddress),
                          SizedBox(
                            height: 20,
                          ),
                          textFormField(
                              text: 'PhoneNo*',
                              controller: phoneController,
                              validation: (val) => validatePhoneNumber(val),
                              keyboardType: TextInputType.phone),
                          SizedBox(
                            height: 20,
                          ),
                          textFormField(
                              onTap: () {
                                setState(() {
                                  FocusScope.of(context)
                                      .requestFocus(FocusNode());
                                  _selectDate(context);
                                });
                              },
                              text: 'BirthOfDate*',
                              controller: bodController,
                              validation: (val) => validateBod(val)),
                          SizedBox(
                            height: 20,
                          ),
                          textFormField(
                              text: 'Address*',
                              controller: addressController,
                              validation: (val) => validateAddress(val)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20),
                  child: InkWell(
                    onTap: () async {
                      if (formKey.currentState.validate()) {
                        await Shared_Preferences.prefSetString(
                            Shared_Preferences.Name, nameController.text);
                        await Shared_Preferences.prefSetString(
                            Shared_Preferences.Email, emailController.text);
                        await Shared_Preferences.prefSetString(
                            Shared_Preferences.PhoneNo, phoneController.text);
                        await Shared_Preferences.prefSetString(
                            Shared_Preferences.Bod, bodController.text);
                        await Shared_Preferences.prefSetString(
                            Shared_Preferences.Address, addressController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UserDetailsPage(),
                            ));

                        print("register");
                        clear();
                      }
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "Register",
                        style: TextStyle(fontSize: 18, color: themeColor),
                      )),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: themeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: themeColor)),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UserDetailsPage(),
                          ));
                      clear();
                    },
                    child: Container(
                      child: Center(
                          child: Text(
                        "view detail",
                        style: TextStyle(fontSize: 18, color: themeColor),
                      )),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          color: themeColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(width: 2, color: themeColor)),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }

  clear() {
    nameController.clear();
    emailController.clear();
    phoneController.clear();
    addressController.clear();
    bodController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 1),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        bodController.text = f.format(selectedDate).toString().substring(0, 10);
      });
  }
}
