import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/chat_app/chat_pages/user_chat_page.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class ChatHomepage extends StatefulWidget {
  const ChatHomepage({Key key}) : super(key: key);

  @override
  _ChatHomepageState createState() => _ChatHomepageState();
}

class _ChatHomepageState extends State<ChatHomepage> {
  var users = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          title: Text("Chats"),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: FloatingActionButton(
      //   elevation: 5,
      //   backgroundColor: themeColor,
      //   child: Icon(Icons.camera),
      //   onPressed: () {},
      // ),
      // bottomNavigationBar: BottomAppBar(
      //   shape: CircularNotchedRectangle(),
      //   notchMargin: 7.0,
      //   child: Row(
      //     mainAxisSize: MainAxisSize.max,
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: <Widget>[
      //       IconButton(
      //         icon: Icon(Icons.message, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.view_list, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       SizedBox(width: 25),
      //       IconButton(
      //         icon: Icon(Icons.call, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.person_outline, color: Colors.black45),
      //         onPressed: () {},
      //       ),
      //     ],
      //   ),
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("user")
              .orderBy("date", descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (_, index) {
                  if (snapshot.data.docs[index]['userID'] == users.uid) {
                    return SizedBox();
                  } else {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        InkWell(
                          onTap: () {
                            print(snapshot.data.docs[index]['token']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => UserChatPage(
                                    name: snapshot.data.docs[index]
                                        ['firstName'],
                                    peerId: snapshot.data.docs[index]['userID'],
                                    token: snapshot.data.docs[index]['token'],
                                  ),
                                ));
                          },
                          child: ListTile(
                            tileColor: grey.shade200,
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: themeColor,
                                border: Border.all(
                                  color: white,
                                  width: 3,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                      color: grey.withOpacity(.3),
                                      offset: Offset(0, 5),
                                      blurRadius: 25)
                                ],
                              ),
                              child: Stack(
                                children: <Widget>[
                                  Positioned.fill(
                                    child: CircleAvatar(
                                      radius: 30.0,
                                      child: new Text(getShortName(snapshot
                                          .data.docs[index]['firstName'])),
                                      backgroundColor: themeColor,
                                    ),
                                  ),
                                  // friendsList[index]['isOnline'] == true
                                  //     ? Align(
                                  //         alignment: Alignment.topRight,
                                  //         child: Container(
                                  //           height: 15,
                                  //           width: 15,
                                  //           decoration: BoxDecoration(
                                  //             border: Border.all(
                                  //               color: white,
                                  //               width: 3,
                                  //             ),
                                  //             shape: BoxShape.circle,
                                  //             color: green,
                                  //           ),
                                  //         ),
                                  //       )
                                  //     : Container(),
                                ],
                              ),
                            ),
                            title: Text(
                                "${snapshot.data.docs[index]['firstName']}"),
                            /* subtitle: Text("${friendsList[index]['msg']}"),
                          trailing: Container(
                            width: 100,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    friendsList[index]['seen']
                                        ? Icon(
                                            Icons.check,
                                            size: 15,
                                          )
                                        : Container(height: 15, width: 15),
                                    Text("${friendsList[index]['lastMsgTime']}")
                                  ],
                                ),
                                SizedBox(
                                  height: 5.0,
                                ),
                                friendsList[index]['hasUnSeenMsgs']
                                    ? Container(
                                        alignment: Alignment.center,
                                        height: 25,
                                        width: 25,
                                        decoration: BoxDecoration(
                                          color: themeColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          "${friendsList[index]['unseenCount']}",
                                          style: TextStyle(color: white),
                                        ),
                                      )
                                    : Container(
                                        height: 25,
                                        width: 25,
                                      ),
                              ],
                            ),
                          ),*/
                          ),
                        ),
                        Divider(
                          height: 5,
                          color: grey,
                        ),
                      ],
                    );
                  }
                },
              );
            }
          },
        ),
      ),
    );
  }

  String getShortName(String name) {
    String shortName = "";
    if (name.isNotEmpty) {
      shortName = name.substring(0, 1);
    }
    return shortName;
  }
}
