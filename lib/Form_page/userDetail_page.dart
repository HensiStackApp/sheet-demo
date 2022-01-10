import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:sheet_widget_demo/shared_prefs/share_preferences.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class UserDetailsPage extends StatefulWidget {
  const UserDetailsPage({Key key}) : super(key: key);

  @override
  _UserDetailsPageState createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  String name = "", email = "", phoneNo = "", address = "", bod = "";

  @override
  initState() {
    // TODO: implement initState
    userDetails();
    super.initState();
  }

  userDetails() async {
    name = await Shared_Preferences.prefGetString(Shared_Preferences.Name, "");
    email = await Shared_Preferences.prefGetString(Shared_Preferences.Email, "");
    phoneNo = await Shared_Preferences.prefGetString(Shared_Preferences.PhoneNo, "");
    address = await Shared_Preferences.prefGetString(Shared_Preferences.Address, "");
    bod = await Shared_Preferences.prefGetString(Shared_Preferences.Bod, "");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        title: Text("Register User Details"),
        backgroundColor: themeColor,
      ),
      body: Center(
        child: Container(
          height: 140,
          width: MediaQuery.of(context).size.width * 0.95,
          decoration: BoxDecoration(
              color: themeColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("User Name "),
                        Text("User Email "),
                        Text("User PhoneNo "),
                        Text("User Birth of date "),
                        Text("User Address "),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(":- "),
                        Text(":- "),
                        Text(":- "),
                        Text(":- "),
                        Text(":- "),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(" $name"),
                        Text(" $email"),
                        Text(" $phoneNo"),
                        Text(" $bod"),
                        Text(" $address"),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        marginEnd: 18,
        marginBottom: 20,
        activeBackgroundColor: themeColor,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.accessibility),
              backgroundColor: themeColor1,
              label: 'First',
              //labelStyle: TextTheme(fontSize: 18.0),
              onTap: () => print('FIRST CHILD')),
          SpeedDialChild(
            child: Icon(Icons.brush),
            backgroundColor: themeColor2,
            label: 'Second',
            //labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
          ),
          SpeedDialChild(
            child: Icon(Icons.keyboard_voice),
            backgroundColor: themeColor3,
            label: 'Third',
            //labelStyle: TextTheme(fontSize: 18.0),
            onTap: () => print('THIRD CHILD'),
          ),
        ],
      ),
    );
  }
}
