// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
//
// class RealTimeDatabaseHomepage extends StatefulWidget {
//   const RealTimeDatabaseHomepage({Key key}) : super(key: key);
//
//   @override
//   _RealTimeDatabaseHomepageState createState() => _RealTimeDatabaseHomepageState();
// }
//
// class _RealTimeDatabaseHomepageState extends State<RealTimeDatabaseHomepage> {
//   final databaseReference = FirebaseDatabase.instance.reference();
//
//   @override
//   Widget build(BuildContext context) {
//     readData();
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Realtime Database Demo'),
//       ),
//       body: Center(
//           child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             RaisedButton(
//               child: Text('Create Data'),
//               color: Colors.redAccent,
//               onPressed: () {
//                 createData();
//               },
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             RaisedButton(
//               child: Text('Read/View Data'),
//               color: Colors.redAccent,
//               onPressed: () {
//                 readData();
//               },
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             RaisedButton(
//               child: Text('Update Data'),
//               color: Colors.redAccent,
//               onPressed: () {
//                 updateData();
//               },
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//             ),
//             SizedBox(
//               height: 8,
//             ),
//             RaisedButton(
//               child: Text('Delete Data'),
//               color: Colors.redAccent,
//               onPressed: () {
//                 deleteData();
//               },
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
//             ),
//           ],
//         ),
//       )), //center
//     );
//   }
//
//   void createData() {
//     databaseReference
//         .child("flutterDevsTeam1")
//         .set({'name': 'Deepak Nishad', 'description': 'Team Lead'});
//     databaseReference
//         .child("flutterDevsTeam2")
//         .set({'name': 'Yashwant Kumar', 'description': 'Senior Software Engineer'});
//     databaseReference
//         .child("flutterDevsTeam3")
//         .set({'name': 'Akshay', 'description': 'Software Engineer'});
//     databaseReference
//         .child("flutterDevsTeam4")
//         .set({'name': 'Aditya', 'description': 'Software Engineer'});
//     databaseReference
//         .child("flutterDevsTeam5")
//         .set({'name': 'Shaiq', 'description': 'Associate Software Engineer'});
//     databaseReference
//         .child("flutterDevsTeam6")
//         .set({'name': 'Mohit', 'description': 'Associate Software Engineer'});
//     databaseReference
//         .child("flutterDevsTeam7")
//         .set({'name': 'Naveen', 'description': 'Associate Software Engineer'});
//   }
//
//   void readData() {
//     databaseReference.once().then((DataSnapshot snapshot) {
//       print('Data : ${snapshot.value}');
//     });
//   }
//
//   void updateData() {
//     databaseReference.child('flutterDevsTeam1').update({'description': 'CEO'});
//     databaseReference.child('flutterDevsTeam2').update({'description': 'Team Lead'});
//     databaseReference.child('flutterDevsTeam3').update({'description': 'Senior Software Engineer'});
//   }
//
//   void deleteData() {
//     databaseReference.child('flutterDevsTeam1').remove();
//     databaseReference.child('flutterDevsTeam2').remove();
//     databaseReference.child('flutterDevsTeam3').remove();
//   }
// }

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/commonWidget/commondialog.dart';
import 'package:sheet_widget_demo/utils/color.dart';

import 'firebaseUtil/firebase_utils.dart';
import 'model/userModel.dart';

class UserDashboard extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<UserDashboard> implements AddUserCallback {
  bool _anchorToBottom = false;

  // instance of util class

  FirebaseDatabaseUtil databaseUtil;

  @override
  void initState() {
    super.initState();
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
  }

  @override
  void dispose() {
    super.dispose();
    databaseUtil.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    // it will show title of screen

    Widget _buildTitle(BuildContext context) {
      return new InkWell(
        child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text(
                'Firebase Database',
                style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  color: white,
                ),
              ),
            ],
          ),
        ),
      );
    }

//It will show new user icon
    List<Widget> _buildActions() {
      return <Widget>[
        new IconButton(
          icon: const Icon(
            Icons.group_add,
            color: white,
          ), // display pop for new entry
          onPressed: () => showEditWidget(null, false),
        ),
      ];
    }

    return new Scaffold(
      appBar: new AppBar(
        title: _buildTitle(context),
        actions: _buildActions(),
      ),

      // Firebase predefile list widget. It will get user info from firebase database
      body: new FirebaseAnimatedList(
        key: new ValueKey<bool>(_anchorToBottom),
        query: databaseUtil.getUser(),
        reverse: _anchorToBottom,
        sort: _anchorToBottom ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key) : null,
        itemBuilder:
            (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
          return new SizeTransition(
            sizeFactor: animation,
            child: showUser(snapshot),
          );
        },
      ),
    );
  }

  @override // Call util method for add user information
  void addUser(User user) {
    setState(() {
      databaseUtil.addUser(user);
    });
  }

  @override // call util method for update old data.
  void update(User user) {
    setState(() {
      databaseUtil.updateUser(user);
    });
  }

  //It will display a item in the list of users.

  Widget showUser(DataSnapshot res) {
    User user = User.fromSnapshot(res);

    var item = new Card(
      child: new Container(
          child: new Center(
            child: new Row(
              children: <Widget>[
                new CircleAvatar(
                  radius: 30.0,
                  child: new Text(getShortName(user)),
                  backgroundColor: themeColor,
                ),
                new Expanded(
                  child: new Padding(
                    padding: EdgeInsets.all(10.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          user.name,
                          // set some style to text
                          style: new TextStyle(fontSize: 20.0, color: grey),
                        ),
                        new Text(
                          user.email,
                          // set some style to text
                          style: new TextStyle(fontSize: 20.0, color: grey),
                        ),
                        new Text(
                          user.mobile,
                          // set some style to text
                          style: new TextStyle(fontSize: 20.0, color: grey),
                        ),
                      ],
                    ),
                  ),
                ),
                new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: themeColor,
                      ),
                      onPressed: () => showEditWidget(user, true),
                    ),
                    new IconButton(
                      icon: const Icon(Icons.delete_forever, color: themeColor),
                      onPressed: () => deleteUser(user),
                    ),
                  ],
                ),
              ],
            ),
          ),
          padding: const EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0)),
    );

    return item;
  }

  //Get first letter from the name of user
  String getShortName(User user) {
    String shortName = "";
    if (user.name.isNotEmpty) {
      shortName = user.name.substring(0, 1);
    }
    return shortName;
  }

  //Display popup in user info update mode.
  showEditWidget(User user, bool isEdit) {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          new AddUserDialog().buildAboutDialog(context, this, isEdit, user),
    );
  }

  //Delete a entry from the Firebase console.
  deleteUser(User user) {
    setState(() {
      databaseUtil.deleteUser(user);
    });
  }
}
