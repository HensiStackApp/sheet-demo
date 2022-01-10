import 'package:flutter/material.dart';

class HideShowWidgetPage extends StatefulWidget {
  const HideShowWidgetPage({Key key}) : super(key: key);

  @override
  _HideShowWidgetPageState createState() => _HideShowWidgetPageState();
}

class _HideShowWidgetPageState extends State<HideShowWidgetPage> {
  bool isShow = false;

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        title: Text("Hide show widget"),
      ),
      body: Column(
        children: [
          isShow == true
              ? Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: AspectRatio(
                        aspectRatio: 2 / 1.3,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isShow = false;
                            });
                          },
                          child: Container(
                            child: Image.network(
                              "https://images.unsplash.com/photo-1541963463532-d68292c34b19?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // FractionalTranslation(
                    //   translation: Offset(8.5, 5.7),
                    //   child: Container(
                    //     height: 40,
                    //     width: 40,
                    //     decoration: BoxDecoration(
                    //         color: grey.shade300,
                    //         border: Border.all(color: themeColor),
                    //         borderRadius: BorderRadius.circular(30)),
                    //     child: IconButton(
                    //         icon: Icon(
                    //           Icons.clear,
                    //           color: black,
                    //         ),
                    //         onPressed: () {
                    //           setState(() {
                    //             isShow = false;
                    //           });
                    //         }),
                    //   ),
                    // )
                  ],
                )
              : Container(),
          Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.1),
              child: Column(
                children: [
                  IconButton(
                      icon: Icon(Icons.image),
                      onPressed: () {
                        setState(() {
                          isShow = true;
                        });
                      }),
                  Text("Show image")
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
