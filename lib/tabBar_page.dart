import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sheet_widget_demo/Form_page/formPage.dart';
import 'package:sheet_widget_demo/generated/l10n.dart';
import 'package:sheet_widget_demo/gridview_page/gridview.dart';
import 'package:sheet_widget_demo/home_page/home.dart';
import 'package:sheet_widget_demo/utils/color.dart';
import 'package:toast/toast.dart';
import 'commonWidget/commonButton.dart';
import 'fireBase_login/FireBase_LoginPage.dart';
import 'fireBase_login/services/auth_services.dart';

class TabBarPage extends StatefulWidget {
  String userName;
  TabBarPage({Key key,this.userName}) : super(key: key);

  @override
  _TabBarPageState createState() => _TabBarPageState();
}

class _TabBarPageState extends State<TabBarPage> with TickerProviderStateMixin {
  TabController tabController;
  String _chosenValue;
  var currentUser = FirebaseAuth.instance.currentUser;
  AuthServices authServices = AuthServices();
  @override
  void initState() {
    tabController = TabController(initialIndex: 0, length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            S.of(context).widgetDemo,
            maxLines: 2,
          ),
          actions: [
            DropdownButton(
              focusColor: white,
              value: _chosenValue,
              style: TextStyle(color: white),
              iconEnabledColor: white,
              items: <String>[
                'us_en',
                'br',
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: black),
                  ),
                );
              }).toList(),
              hint: Text(
                S.of(context).chooseLanguage,
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w500),
              ),
              onChanged: (String value) {
                setState(() {
                  _chosenValue = value;
                  _select(value);
                });
              },
            ),
          ],
          bottom: TabBar(
            controller: tabController,
            tabs: [
              SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Home",
                    ),
                  )),
              SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    "Form",
                  ),
                ),
              ),
              SizedBox(
                  height: 50,
                  child: Center(
                    child: Text(
                      "Grid",
                    ),
                  )),
            ],
          ),
        ),

        backgroundColor: grey.shade200,
        drawer: Drawer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width,
                color: themeColor,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      child: Center(
                          child: Text(getShortName(widget.userName) ?? getShortName(currentUser.displayName)??"")),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: white,
                          width: 1,
                        ),
                      ),
                    ),
                    title: Text(
                      S.of(context).profile,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(widget.userName ?? currentUser.displayName??""),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(S.of(context).message),
                            content: Text(S.of(context).areYouWantToLogOut),
                            actions: [
                              elevatedButton(() {
                                Navigator.pop(context);
                              }, S.of(context).No),
                              elevatedButton(() async {
                                EasyLoading.show(
                                    indicator: CircularProgressIndicator(
                                  backgroundColor: themeColor,
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(white),
                                ));
                                await authServices.authSignOut();

                                Navigator.pop(context);
                                EasyLoading.dismiss();
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LogInPage()));
                                Toast.show(
                                    S.of(context).signOutSuccessful, context,
                                    duration: 7);
                              }, S.of(context).Yes)
                            ],
                          );
                        });
                  },
                  child: Container(
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      color: themeColor,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.logout,
                              color: white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              S.of(context).logout,
                              style: TextStyle(color: white, fontSize: 20),
                            ),
                          ],
                        ),
                      )))
            ],
          ),
        ),
        // bottomNavigationBar: TabBar(
        //   controller: tabController,
        //   tabs:
        //   [
        //     SizedBox(
        //         height: 50,
        //         child: Center(
        //           child: Text(
        //             "Home",
        //           ),
        //         )),
        //     SizedBox(
        //       height: 50,
        //       child: Center(
        //         child: Text(
        //           "Form",
        //         ),
        //       ),
        //     ),
        //     SizedBox(
        //         height: 50,
        //         child: Center(
        //           child: Text(
        //             "Grid",
        //           ),
        //         )),
        //   ],
        //   labelColor: themeColor,
        //   unselectedLabelStyle: TextStyle(color: themeColor),
        // ),
        body: TabBarView(
            controller: tabController,
            children: [HomePage(), FormPage(), GridPage()]),
      ),
    );
  }

  void _select(String language) {
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

  String getShortName(String name) {
    String shortName = "";
    if (name.isNotEmpty) {
      shortName = name.substring(0, 1);
    }
    return shortName;
  }
}
