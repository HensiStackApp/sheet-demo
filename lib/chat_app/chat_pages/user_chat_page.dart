// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sheet_widget_demo/fireBase_login/services/user_services.dart';
// import 'package:sheet_widget_demo/model/userModel.dart';
// import 'package:sheet_widget_demo/utils/color.dart';
//
// class UserChatPage extends StatefulWidget {
//   final String peerId, name;
//
//   const UserChatPage({Key key, this.name, this.peerId}) : super(key: key);
//
//   @override
//   _UserChatPageState createState() => _UserChatPageState();
// }
//
// class _UserChatPageState extends State<UserChatPage> {
//   TextEditingController msgController = TextEditingController();
//   List<QueryDocumentSnapshot> listMessage = new List.from([]);
//   List msg = [];
//   String groupChatId = '';
//   UserServices userServices = UserServices();
//   var users = FirebaseAuth.instance.currentUser;
//
//   @override
//   void initState() {
//     readLocal();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(70),
//         child: AppBar(
//           title: Row(
//             children: <Widget>[
//               Container(
//                 width: 50,
//                 height: 50,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                     color: white,
//                     width: 3,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 15),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Text(
//                     widget.name,
//                     style: Theme.of(context).textTheme.subtitle1,
//                     overflow: TextOverflow.clip,
//                   ),
//                   Text(
//                     "Online",
//                     style: Theme.of(context).textTheme.subtitle2.apply(
//                           color: white,
//                         ),
//                   )
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           child: Stack(
//             children: [chatUi(), bottomBar()],
//           ),
//         ),
//       ),
//     );
//   }
//
//   bottomBar() {
//     return Padding(
//       padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.75),
//       child: Container(
//         margin: EdgeInsets.all(10.0),
//         height: 61,
//         child: Row(
//           children: <Widget>[
//             Expanded(
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: white,
//                   borderRadius: BorderRadius.circular(35.0),
//                   boxShadow: [BoxShadow(offset: Offset(0, 3), blurRadius: 5, color: grey)],
//                 ),
//                 child: Row(
//                   children: <Widget>[
//                     // IconButton(icon: Icon(Icons.face), onPressed: () {}),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10.0),
//                         child: TextFormField(
//                           controller: msgController,
//                           decoration: InputDecoration(
//                               hintText: "Type Something...", border: InputBorder.none),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.photo_camera),
//                       onPressed: () {},
//                     ),
//                     IconButton(
//                       icon: Icon(Icons.attach_file),
//                       onPressed: () {},
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             IconButton(
//                 onPressed: () async {
//                   if (msgController.text.isNotEmpty) {
//                     ChatData chatData = ChatData(
//                       hasUnSeenMsg: true,
//                       isOnline: false,
//                       lastMsgTime: DateTime.now(),
//                       msg: msgController.text,
//                       msgFrom: users.uid,
//                       msgTo: widget.peerId,
//                       seen: false,
//                       type: 0,
//                       unseenCount: '1',
//                     );
//                     await userServices.createMsg(chatData, groupChatId);
//                     msgController.clear();
//                     FocusScope.of(context).requestFocus(FocusNode());
//                   }
//                 },
//                 icon: Icon(Icons.send))
//             /*Container(
//               padding: const EdgeInsets.all(15.0),
//               decoration: BoxDecoration(color: themeColor, shape: BoxShape.circle),
//               child: InkWell(
//                 child: Icon(
//                   Icons.keyboard_voice,
//                   color: white,
//                 ),
//                 onLongPress: () {
//                   setState(() {
//                     _showBottom = true;
//                     */
//             /*_showBottom
//                               ? Positioned(
//                                   bottom: 90,
//                                   left: 25,
//                                   right: 25,
//                                   child: Container(
//                                     padding: EdgeInsets.all(25.0),
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       boxShadow: [
//                                         BoxShadow(
//                                             offset: Offset(0, 5),
//                                             blurRadius: 15.0,
//                                             color: Colors.grey)
//                                       ],
//                                     ),
//                                     child: GridView.count(
//                                       mainAxisSpacing: 21.0,
//                                       crossAxisSpacing: 21.0,
//                                       shrinkWrap: true,
//                                       crossAxisCount: 3,
//                                       children: List.generate(
//                                         icons.length,
//                                         (i) {
//                                           return Container(
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(15.0),
//                                               color: grey.shade200,
//                                               border: Border.all(color: themeColor, width: 2),
//                                             ),
//                                             child: IconButton(
//                                               icon: Icon(
//                                                 icons[i],
//                                                 color: themeColor,
//                                               ),
//                                               onPressed: () {},
//                                             ),
//                                           );
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 )
//                               : Container();*/
//             /*
//                   });
//                 },
//               ),
//             )*/
//           ],
//         ),
//       ),
//     );
//   }
//
//   chatUi() {
//     if (groupChatId.isNotEmpty) {
//       return StreamBuilder(
//           stream: FirebaseFirestore.instance
//               .collection('msgCollection')
//               .doc(groupChatId)
//               .collection(groupChatId)
//               .orderBy('latMsgTime', descending: true)
//               .snapshots(),
//           builder: (context, snapshot) {
//             print(snapshot.hasData);
//             if (snapshot.hasData) {
//               listMessage.addAll(snapshot.data.docs);
//
//               print("-->${listMessage.length}");
//               print("-->${snapshot.data.docs.length}");
//               return ListView.builder(
//                   shrinkWrap: true,
//                   itemCount: snapshot.data.docs.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 100,
//                       height: 100,
//                       color: Colors.yellow,
//                     );
//                   });
//
//               // return ListView.builder(
//               //     shrinkWrap: true,
//               //     itemCount: snapshot.data.docs.length,
//               //     itemBuilder: (_, index) {
//               //       var doc = snapshot.data.docs[index];
//               //       print("-->");
//               //       print("-->${snapshot.data.docs.length}");
//               //       print(doc.get['msg']);
//               //       return Container(
//               //         width: 100,
//               //         height: 100,
//               //         color: Colors.yellow,
//               //       );
//               //       /* return Column(
//               //       children: [
//               //         doc['type'] == 1
//               //             ? Row(
//               //                 mainAxisAlignment: MainAxisAlignment.start,
//               //                 children: <Widget>[
//               //                   Padding(
//               //                     padding: const EdgeInsets.all(8.0),
//               //                     child: Container(
//               //                       constraints: BoxConstraints(
//               //                           maxWidth: MediaQuery.of(context).size.width * .6),
//               //                       padding: const EdgeInsets.all(15.0),
//               //                       decoration: BoxDecoration(
//               //                         color: themeColor.withOpacity(0.5),
//               //                         borderRadius: BorderRadius.only(
//               //                           topRight: Radius.circular(25),
//               //                           bottomLeft: Radius.circular(25),
//               //                           bottomRight: Radius.circular(25),
//               //                         ),
//               //                       ),
//               //                       child: Text(
//               //                         doc['msg'],
//               //                         // "hello",
//               //                         style: Theme.of(context).textTheme.bodyText2.apply(
//               //                               color: Colors.black87,
//               //                             ),
//               //                       ),
//               //                     ),
//               //                   ),
//               //                   SizedBox(width: 5),
//               //                   Text(
//               //                     doc['lastMsgTime'],
//               //                     // "${messages[i]['time']}",
//               //                     // "10:28 AM",
//               //                     style: Theme.of(context)
//               //                         .textTheme
//               //                         .bodyText1
//               //                         .apply(color: Colors.grey),
//               //                   ),
//               //                 ],
//               //               )
//               //             : SizedBox(),
//               //         doc['type'] == 0
//               //             ? Row(
//               //                 mainAxisAlignment: MainAxisAlignment.end,
//               //                 children: <Widget>[
//               //                   Text(
//               //                     doc['lastMsgTime'],
//               //                     // "${messages[i]['time']}",
//               //                     // "10:28 AM",
//               //                     style: Theme.of(context)
//               //                         .textTheme
//               //                         .bodyText1
//               //                         .apply(color: Colors.grey),
//               //                   ),
//               //                   SizedBox(width: 5),
//               //                   Padding(
//               //                     padding: const EdgeInsets.all(8.0),
//               //                     child: Container(
//               //                       constraints: BoxConstraints(
//               //                           maxWidth: MediaQuery.of(context).size.width * .6),
//               //                       padding: const EdgeInsets.all(15.0),
//               //                       decoration: BoxDecoration(
//               //                         color: grey.withOpacity(0.5),
//               //                         borderRadius: BorderRadius.only(
//               //                           topRight: Radius.circular(25),
//               //                           bottomLeft: Radius.circular(25),
//               //                           topLeft: Radius.circular(25),
//               //                         ),
//               //                       ),
//               //                       child: Text(
//               //                         doc['msg'],
//               //                         // "${messages[i]['message']}",
//               //                         // "hello",
//               //                         style: Theme.of(context).textTheme.bodyText2.apply(
//               //                               color: Colors.black87,
//               //                             ),
//               //                       ),
//               //                     ),
//               //                   ),
//               //                 ],
//               //               )
//               //             : SizedBox(),
//               //       ],
//               //     );*/
//               //     });
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           });
//     } else {
//       return Center(
//         child: CircularProgressIndicator(),
//       );
//     }
//   }
//
//   readLocal() async {
//     var id = users.uid;
//     if (id.hashCode <= widget.peerId.hashCode) {
//       groupChatId = '$id-${widget.peerId}';
//     } else {
//       groupChatId = '${widget.peerId}-$id';
//     }
//     print("{group chat id -->> $groupChatId}");
//     setState(() {});
//   }
// }

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:sheet_widget_demo/chat_app/photoView_page.dart';
import 'package:sheet_widget_demo/commonWidget/commonButton.dart';
import 'package:sheet_widget_demo/fireBase_login/services/user_services.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class UserChatPage extends StatefulWidget {
  final String peerId, name, token;

  const UserChatPage({Key key, this.name, this.peerId, this.token})
      : super(key: key);

  @override
  _UserChatPageState createState() => _UserChatPageState();
}

class _UserChatPageState extends State<UserChatPage> {
  TextEditingController msgController = TextEditingController();
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  final ScrollController listScrollController = ScrollController();
  List msg = [];
  File imageFile;
  bool isLoading = false;
  String groupChatId = '';
  String imageUrl = '';
  int loadData = 8;
  UserServices userServices = UserServices();
  var users = FirebaseAuth.instance.currentUser.uid;
  var currentUser = FirebaseAuth.instance.currentUser;
  var length = 0;

  @override
  void initState() {
    readLocal();
    print(currentUser.displayName);
    getAllData().then((value) {
      setState(() {
        print(value);
        length = value;
        print(length);
      });
    });
    super.initState();
  }

  getAllData() async {
    QuerySnapshot value = await FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .get();
    print(value.docs.length);
    return value.docs.length;
  }

  readLocal() async {
    var id = users;
    if (id.hashCode <= widget.peerId.hashCode) {
      groupChatId = '$id-${widget.peerId}';
    } else {
      groupChatId = '${widget.peerId}-$id';
    }
    print("{group chat id -->> $groupChatId}");
    setState(() {});
  }

  void onSendMessage({String content, int type}) {
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(
        documentReference,
        {
          'idFrom': users,
          'idTo': widget.peerId,
          'timestamp': DateTime.now(),
          'content': content,
          'type': type,
          'read': false,
        },
      );
    });
  }

  // static String returnTime(DateTime dt) {
  //   final DateFormat formatter = DateFormat('h:mm a');
  //   // final DateFormat formatter = DateFormat('d MMM ,h:mm a');
  //   String time = formatter.format(dt);
  //   return time;
  // }

  String getVerboseDateTimeRepresentation(DateTime dateTime) {
    DateTime now = DateTime.now();
    DateTime yesterday = now.subtract(Duration(days: 1));
    String roughTimeString = DateFormat('jm').format(dateTime);
    DateTime justNow = DateTime.now().subtract(Duration(minutes: 1));
    DateTime localDateTime = dateTime.toLocal();
    if (!localDateTime.difference(justNow).isNegative) {
      return 'Just now';
    }
    if (localDateTime.day == now.day &&
        localDateTime.month == now.month &&
        localDateTime.year == now.year) {
      return roughTimeString;
    }
    if (localDateTime.day == yesterday.day &&
        localDateTime.month == yesterday.month &&
        localDateTime.year == yesterday.year) {
      return 'Yesterday, ' + roughTimeString;
    }
    if (now.difference(localDateTime).inDays < 4) {
      String weekday = DateFormat('EEEE').format(localDateTime);
      return '$weekday, $roughTimeString';
    }
    return '${DateFormat('yMd').format(dateTime)}, $roughTimeString';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          title: Row(
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                child: Center(child: Text(getShortName(widget.name))),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: white,
                    width: 1,
                  ),
                ),
              ),
              SizedBox(width: 15),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.name,
                    style: Theme.of(context).textTheme.subtitle1,
                    overflow: TextOverflow.clip,
                  ),
                  Text(
                    "Online",
                    style: Theme.of(context).textTheme.subtitle2.apply(
                          color: white,
                        ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height * 0.87,
          child: Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.79,
                child: chatUi(),
              ),
              (loadData >= length)
                  ? Container()
                  : Align(
                      alignment: Alignment.topCenter,
                      child: button(context, 'load more!', () {
                        loadData = loadData + 8;
                        setState(() {});
                      })),
              bottomBar()
            ],
          ),
        ),
      ),
    );
  }

  bottomBar() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.77),
      child: Container(
        margin: EdgeInsets.all(10.0),
        height: 61,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: [
                    BoxShadow(offset: Offset(0, 3), blurRadius: 5, color: grey)
                  ],
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: TextFormField(
                          controller: msgController,
                          decoration: InputDecoration(
                              hintText: "Type a message...",
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                          onTap: () {
                            getImage();
                          },
                          child: Icon(Icons.image)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: InkWell(
                          onTap: () {
                            getImageFromCamera();
                          },
                          child: Icon(Icons.camera_alt)),
                    ),
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  if (msgController.text.isNotEmpty) {
                    onSendMessage(
                      content: msgController.text,
                      type: 0,
                    );
                    print(widget.token);
                    pushNotification(
                        token: widget.token,
                        message: msgController.text,
                        receiverName: currentUser.displayName);
                    FocusScope.of(context).requestFocus(FocusNode());
                    msgController.clear();
                  }
                },
                icon: Icon(Icons.send))
            /*Container(
              padding: const EdgeInsets.all(15.0),
              decoration: BoxDecoration(color: themeColor, shape: BoxShape.circle),
              child: InkWell(
                child: Icon(
                  Icons.keyboard_voice,
                  color: white,
                ),
                onLongPress: () {
                  setState(() {
                    _showBottom = true;
                    */
            /*_showBottom
                              ? Positioned(
                                  bottom: 90,
                                  left: 25,
                                  right: 25,
                                  child: Container(
                                    padding: EdgeInsets.all(25.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 5),
                                            blurRadius: 15.0,
                                            color: Colors.grey)
                                      ],
                                    ),
                                    child: GridView.count(
                                      mainAxisSpacing: 21.0,
                                      crossAxisSpacing: 21.0,
                                      shrinkWrap: true,
                                      crossAxisCount: 3,
                                      children: List.generate(
                                        icons.length,
                                        (i) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(15.0),
                                              color: grey.shade200,
                                              border: Border.all(color: themeColor, width: 2),
                                            ),
                                            child: IconButton(
                                              icon: Icon(
                                                icons[i],
                                                color: themeColor,
                                              ),
                                              onPressed: () {},
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                )
                              : Container();*/
            /*
                  });
                },
              ),
            )*/
          ],
        ),
      ),
    );
  }

  chatUi() {
    return groupChatId.isNotEmpty
        ? StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('messages')
                .doc(groupChatId)
                .collection(groupChatId)
                .orderBy('timestamp', descending: true)
                .limit(loadData)
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                listMessage.addAll(snapshot.data.docs);
                print("-->${listMessage.length}");
                print("-->${listMessage.length}");
                return ListView.builder(
                  controller: listScrollController,
                  reverse: true,
                  shrinkWrap: true,
                  // physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  padding: EdgeInsets.all(10.0),
                  itemBuilder: (context, index) =>
                      buildItem(index, snapshot.data.docs[index]),
                  itemCount: snapshot.data.docs.length,
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }

  /* Widget buildItem(int index, DocumentSnapshot document) {
    if (document != null) {
      if (document.get('idFrom') == users) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  returnTime(document.get('timestamp').toDate()).toString(),
                  style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.grey),
                ),
                SizedBox(width: 5),
                document.get('type') == 0
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          constraints:
                              BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
                          padding: const EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            color: grey.withOpacity(0.5),
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                              topLeft: Radius.circular(25),
                            ),
                          ),
                          child: Text(
                            document.get('content'),
                            style: Theme.of(context).textTheme.bodyText2.apply(
                                  color: Colors.black87,
                                ),
                          ),
                        ),
                      )
                    : document.get('type') == 1
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PhotoviewPage(
                                                imgUrl: document.get('content'),
                                              )));
                                },
                                child: Image.network(
                                  document.get('content'),
                                ),
                              ),
                            ),
                          )
                        : SizedBox(),
              ],
            )
          ],
        );
      } else {
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            document.get('type') == 0
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * .6),
                      padding: const EdgeInsets.all(15.0),
                      decoration: BoxDecoration(
                        color: themeColor.withOpacity(0.5),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Text(
                        document.get('content'),
                        style: Theme.of(context).textTheme.bodyText2.apply(
                              color: Colors.black87,
                            ),
                      ),
                    ),
                  )
                : document.get('type') == 1
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PhotoviewPage(
                                            imgUrl: document.get('content'),
                                          )));
                            },
                            child: Image.network(
                              document.get('content'),
                            ),
                          ),
                        ),
                      )
                    : SizedBox(),
            SizedBox(width: 5),
            Text(
              returnTime(document.get('timestamp').toDate()).toString(),
              style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.grey),
            ),
          ],
        );
      }
    }
  }*/

  Widget buildItem(int index, DocumentSnapshot document) {
    if (document != null) {
      if (document.get('idFrom') == users) {
        // Right (my message)
        return Container(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  // Text(
                  //   getVerboseDateTimeRepresentation(document.get('timestamp').toDate()).toString(),
                  //   style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.grey),
                  // ),
                  // SizedBox(width: 5),
                  document.get('type') == 0
                      // Text
                      ? Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    constraints: BoxConstraints(
                                        maxWidth:
                                            MediaQuery.of(context).size.width *
                                                .6),
                                    padding: const EdgeInsets.all(5.0),
                                    decoration: BoxDecoration(
                                      color: grey.withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10),
                                        topLeft: Radius.circular(10),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        document.get('content'),
                                        style: TextStyle(color: white),
                                      ),
                                    ),
                                  ),
                                  // document.get('read') == true
                                  //     ? Icon(Icons.check)
                                  //     : Icon(Icons.done_all),
                                ],
                              ),
                              Text(
                                getVerboseDateTimeRepresentation(
                                        document.get('timestamp').toDate())
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .apply(color: grey),
                              ),
                            ],
                          ),
                        )
                      : document.get('type') == 1
                          // Image
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoviewPage(
                                      imgUrl: document.get('content'),
                                      // appbarText: 'Full Photo'
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        document.get("content"),
                                        width: 200.0,
                                        height: 150.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    getVerboseDateTimeRepresentation(
                                            document.get('timestamp').toDate())
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .apply(color: grey),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                ],
                mainAxisAlignment: MainAxisAlignment.end,
              ),
            ],
          ),
          margin: EdgeInsets.only(bottom: 5.0),
        );
      } else {
        // Left (peer message)
        return Container(
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  document.get('type') == 0
                      ? Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width *
                                              .6),
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: BoxDecoration(
                                    color: themeColor.withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Text(document.get('content'),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                  )),
                              Text(
                                getVerboseDateTimeRepresentation(
                                        document.get('timestamp').toDate())
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .apply(color: grey),
                              ),
                            ],
                          ))
                      : document.get('type') == 1
                          ? InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhotoviewPage(
                                      imgUrl: document.get('content'),
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        document.get('content'),
                                        width: 200.0,
                                        height: 150.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    getVerboseDateTimeRepresentation(
                                            document.get('timestamp').toDate())
                                        .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .apply(color: grey),
                                  ),
                                ],
                              ),
                            )
                          : Container(),
                  // SizedBox(width: 5),
                  // Text(
                  //   getVerboseDateTimeRepresentation(document.get('timestamp').toDate()).toString(),
                  //   style: Theme.of(context).textTheme.bodyText1.apply(color: Colors.grey),
                  // ),
                ],
              ),
            ],
            crossAxisAlignment: CrossAxisAlignment.start,
          ),
          margin: EdgeInsets.only(bottom: 5.0),
        );
      }
    } else {
      return SizedBox();
    }
  }

  String getShortName(String name) {
    String shortName = "";
    if (name.isNotEmpty) {
      shortName = name.substring(0, 1);
    }
    return shortName;
  }

  Future getImage() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });

        uploadFile();
      }
    }
  }

  Future getImageFromCamera() async {
    ImagePicker imagePicker = ImagePicker();
    PickedFile pickedFile;

    pickedFile = await imagePicker.getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
      if (imageFile != null) {
        setState(() {
          isLoading = true;
        });

        uploadFile();
      }
    }
  }

  Future uploadFile() async {
    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(imageFile);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Stack(
            children: [
              Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        );
      },
    );
    try {
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
      setState(() {
        isLoading = false;
        Navigator.of(context, rootNavigator: false).pop();
        onSendMessage(content: imageUrl, type: 1);
      });
    } on FirebaseException catch (e) {
      setState(() {
        isLoading = false;
      });
      Fluttertoast.showToast(msg: e.message ?? e.toString());
    }
  }

  Future pushNotification(
      {String message, String receiverName, String token}) async {
    String baseUrl = 'https://fcm.googleapis.com/fcm/send';
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization':
          'key=AAAAa94-gIU:APA91bFROXU3Zm1OlHYLpBaio0MP36F81GdKnHog6N3V5T2vozYQpe1uwg15J31oN5fBse7pSah7i3sXP35keZRPamDyk9SmJ6V0uY0P9x-PlWVWJ6cNUVlv9Agh0rc_osGLuG5ubJWo',
    };
    print('Headers --> $headers');
    String body = jsonEncode({
      "notification": {
        "body": message,
        "title": receiverName,
      },
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done",
        "open_val": "B",
      },
      "registration_ids": [token]
    });
    print('body --> $body');
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: headers,
      body: body,
    );
    print('Status code : ${response.statusCode}');
    print('Body : ${response.body}');
    if (response.statusCode == 200 || response.statusCode == 201) {
      var message = jsonDecode(response.body);
      return message;
    } else {
      print('Status code : ${response.statusCode}');
    }
  }
}
