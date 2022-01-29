import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sheet_widget_demo/ApiCallingWithPagination/demo_page_api_screen.dart';
import 'package:sheet_widget_demo/audioPlayer_page/audioPlayer.dart';
import 'package:sheet_widget_demo/blocPattern_demo/home_screen/home_page_screen.dart';
import 'package:sheet_widget_demo/chat_app/chat_pages/chat_home_page.dart';
import 'package:sheet_widget_demo/choiceChip_page/choiceChip.dart';
import 'package:sheet_widget_demo/commonWidget/commonButton.dart';
import 'package:sheet_widget_demo/fireBase_login/services/auth_services.dart';
import 'package:sheet_widget_demo/fireBase_login/services/user_services.dart';
import 'package:sheet_widget_demo/generated/l10n.dart';
import 'package:sheet_widget_demo/geoLocation/locationPage.dart';
import 'package:sheet_widget_demo/hideShow_page/hideShowWidget.dart';
import 'package:sheet_widget_demo/notification/notification_pages/notification_home_page.dart';
import 'package:sheet_widget_demo/pageview_demo/pageview_page.dart';
import 'package:sheet_widget_demo/payment_gateway/paymentHome.dart';
import 'package:sheet_widget_demo/piker_page/dateTimePicker.dart';
import 'package:sheet_widget_demo/provider/provider_api_page_demo.dart';
import 'package:sheet_widget_demo/realTimeDatabase/real_time_database_page.dart';
import 'package:sheet_widget_demo/saveImageGallery_page/saveImageGallery.dart';
import 'package:sheet_widget_demo/scanner/scanner_home_page.dart';
import 'package:sheet_widget_demo/sqflite_demo/sqfliteHome.dart';
import 'package:sheet_widget_demo/trip/geolocation_pages/google_map_page.dart';
import 'package:sheet_widget_demo/ui_demo/pages/home_page.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthServices authServices = AuthServices();
  UserServices userServices = UserServices();
  TextEditingController controller = TextEditingController();
  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  List gender = ['Male', 'Female'];
  List hobby = [
    {'name': 'reading', 'isCheck': false},
    {'name': 'movie', 'isCheck': false},
    {'name': 'dancing', 'isCheck': false}
  ];
  ImagePicker picker = ImagePicker();
  var images;
  String controllerValue = '';
  File imageFile;
  bool on = true;
  int value = -1;
  var currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      key: scaffoldKey,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(100.0),
      //   child: AppBar(
      //     title: Text(
      //       S.of(context).widgetDemo,
      //       maxLines: 2,
      //     ),
      //     actions: [
      //       DropdownButton(
      //         focusColor: white,
      //         value: _chosenValue,
      //         style: TextStyle(color: white),
      //         iconEnabledColor: white,
      //         items: <String>[
      //           'us_en',
      //           'br',
      //         ].map<DropdownMenuItem<String>>((String value) {
      //           return DropdownMenuItem<String>(
      //             value: value,
      //             child: Text(
      //               value,
      //               style: TextStyle(color: black),
      //             ),
      //           );
      //         }).toList(),
      //         hint: Text(
      //           S.of(context).chooseLanguage,
      //           style: TextStyle(
      //               color: white, fontSize: 14, fontWeight: FontWeight.w500),
      //         ),
      //         onChanged: (String value) {
      //           setState(() {
      //             _chosenValue = value;
      //             _select(value);
      //           });
      //         },
      //       ),
      //     ],
      //   ),
      // ),

      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageFile == null
                    ? Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            child: ClipOval(
                              child: Image.network(
                                "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                                width: 200,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          FractionalTranslation(
                            translation: Offset(2, 2),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: grey.shade300,
                                  border: Border.all(color: themeColor),
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: black,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(S.of(context).selectOne),
                                          content: Container(
                                            height: 100,
                                            child: Column(
                                              children: <Widget>[
                                                ElevatedButton(
                                                  onPressed: () {
                                                    getFromGallery();
                                                    Navigator.of(context).pop();
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: themeColor),
                                                  child: Text(S
                                                      .of(context)
                                                      .pickFromGallery),
                                                ),
                                                ElevatedButton(
                                                  onPressed: () {
                                                    getFromCamera();
                                                    Navigator.of(context).pop();
                                                    print(imageFile);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: themeColor),
                                                  child: Text(S
                                                      .of(context)
                                                      .pickFromCamera),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                            ),
                          )
                        ],
                      )
                    : Stack(
                        children: [
                          CircleAvatar(
                            radius: 60,
                            child: ClipOval(
                              child: Image.file(
                                imageFile,
                                fit: BoxFit.cover,
                                width: 200,
                                height: 150,
                              ),
                            ),
                          ),
                          FractionalTranslation(
                            translation: Offset(2, 2),
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: grey.shade300,
                                  border: Border.all(color: themeColor),
                                  borderRadius: BorderRadius.circular(30)),
                              child: IconButton(
                                  icon: Icon(
                                    Icons.camera_alt,
                                    color: black,
                                  ),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text("select one"),
                                          content: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              ElevatedButton(
                                                onPressed: () {
                                                  getFromGallery();
                                                  Navigator.of(context).pop();
                                                },
                                                child: Text(S
                                                    .of(context)
                                                    .pickFromGallery),
                                              ),
                                              Container(
                                                height: 40.0,
                                              ),
                                              ElevatedButton(
                                                onPressed: () {
                                                  getFromCamera();
                                                  Navigator.of(context).pop();
                                                  print(imageFile);
                                                },
                                                child: Text(S
                                                    .of(context)
                                                    .pickFromCamera),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  }),
                            ),
                          )
                        ],
                      ),
                SizedBox(height: 10),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            controller: controller,
                            validator: (val) => validateController(val),
                            // will disable paste operation
                            textAlign: TextAlign.start,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 12.0, horizontal: 15),
                              // suffixIcon: IconButton(icon: Icon(Icons.star,size: 25,color:Colors.red ,), onPressed: _popUpMonth),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(223, 227, 233, 10),
                                    width: 1.0),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(223, 227, 233, 10),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(223, 227, 233, 10),
                                    width: 1.0),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(223, 227, 233, 10),
                                    width: 1.0),
                              ),
                            ),
                          ),
                          width: 300,
                        ),
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      button(context, S.of(context).click, () {
                        if (formKey.currentState.validate()) {
                          controllerValue = controller.text;
                          setState(() {});
                        }
                      }),
                    ],
                  ),
                ),
                button(context, S.of(context).dateTimePicker, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DateTimePicker(),
                      ));
                }),
                Switch(
                    activeColor: themeColor,
                    value: on,
                    onChanged: (off) {
                      on = off;
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
                            duration: Duration(seconds: 1),
                            content: (off == true)
                                ? Text(S.of(context).on)
                                : Text(S.of(context).off)));
                      });
                    }),
                Text(S.of(context).selectGender),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return RadioListTile(
                        activeColor: themeColor,
                        title: Text(gender[index]),
                        value: index,
                        groupValue: value,
                        onChanged: (val) {
                          setState(() {
                            value = val;
                          });
                        });
                  },
                  itemCount: gender.length,
                ),
                Text(S.of(context).selectHobby),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CheckboxListTile(
                        activeColor: themeColor,
                        title: Text(hobby[index]['name']),
                        value: hobby[index]['isCheck'],
                        onChanged: (val) {
                          setState(() {
                            hobby[index]['isCheck'] = val;
                          });
                        });
                  },
                  itemCount: hobby.length,
                ),
                // button(context, S.of(context).slider, () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => SliderPage(),
                //       ));
                // }),
                // button(context, S.of(context).indicator, () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => IndicatorPage(),
                //       ));
                // }),
                button(context, S.of(context).choiceChip, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChoiceChips(),
                      ));
                }),
                button(context, S.of(context).audioPlayer, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioPlayerPage(),
                      ));
                }),
                button(context, S.of(context).hideShowWidget, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HideShowWidgetPage(),
                      ));
                }),
                button(context, S.of(context).saveImageInGallery, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SaveImageGalleryPage(),
                      ));
                }),
                button(context, S.of(context).apiCallingWithPagination, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DemoPageApiScreen(),
                      ));
                }),
                button(context, S.of(context).pageView, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageViewHomePage(),
                      ));
                }),
                button(context, S.of(context).sqfLiteDemo, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SqfLiteHome(),
                      ));
                }),
                button(context, S.of(context).providerDemo, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProviderApiDemo(),
                      ));
                }),
                button(context, S.of(context).blocDemo, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlocHomePage(),
                      ));
                }),
                button(context, S.of(context).geoLocation, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LocationHomePage(),
                      ));
                }),
                button(context, S.of(context).inAppPurchase, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentHomeApp(),
                      ));
                }),
                button(context, S.of(context).realTimeDatabase, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDashboard(),
                      ));
                }),
                button(context, S.of(context).qrCodeScanner, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QRViewExample(),
                      ));
                }),
                button(context, S.of(context).chatApp, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatHomepage(),
                      ));
                }),
                button(context, S.of(context).notificationApp, () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NotificationHomePage(),
                      ));
                }),
                button(context, "ui app", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UiHomePage(),
                      ));
                }),

                button(context, "create trip", () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMapPage1(),
                      ));
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void select(String language) {
    print("dd " + language);

    setState(() {
      if (language == "br") {
        S.load(
          Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
        );
      } else {
        S.load(
          Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        );
      }
    });
  }

  getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  String getShortName(String name) {
    String shortName = "";
    if (name.isNotEmpty) {
      shortName = name.substring(0, 1);
    }
    return shortName;
  }
}

String validateController(String value) {
  if (value.length == 0) {
    return "This field is required";
  } else {
    return null;
  }
}
