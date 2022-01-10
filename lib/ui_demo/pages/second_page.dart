import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/ui_demo/commmon/common_container.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        body: Stack(
          children: [
            Container(
              color: white,
              child: Container(
                height: size.height * 0.27,
                decoration: BoxDecoration(
                    color: red,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(70))),
                child: Padding(
                  padding: EdgeInsets.only(
                      top: size.height * 0.05,
                      left: size.width * 0.03,
                      right: size.width * 0.03),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(
                        Icons.menu,
                        color: white,
                        size: 35,
                      ),
                      Text(
                        "TheShop",
                        style: TextStyle(
                            color: white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Icon(
                        Icons.more_vert,
                        color: white,
                        size: 25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.height * 0.27),
              child: Container(
                color: red,
                child: Container(
                  decoration: BoxDecoration(
                      color: white,
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(70))),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.2,
                  left: size.height * 0.05,
                  right: size.height * 0.05),
              child: Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        container2(
                            height: size.height * 0.2,
                            width: size.width * 0.37,
                            name: "Favourite",
                            url: "images/7.png"),
                        container2(
                            height: size.height * 0.2,
                            width: size.width * 0.37,
                            name: "Analytics",
                            url: "images/1.png"),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        container2(
                            height: size.height * 0.2,
                            width: size.width * 0.37,
                            name: "Reservations",
                            url: "images/3.png"),
                        container2(
                            onTap: () async {
                              print("hello");
                              await showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Confirmation'),
                                    content: Text('Do you want to save?'),
                                    actions: <Widget>[
                                      RaisedButton(
                                        color: Colors.red, // background
                                        textColor: Colors.white, // foreground
                                        onPressed: () {},
                                        child: Text('NEXT'),
                                      )
                                    ],
                                  );
                                },
                              );
                            },
                            height: size.height * 0.2,
                            width: size.width * 0.37,
                            name: "Deals",
                            url: "images/5.png"),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        container2(
                            height: size.height * 0.2,
                            width: size.width * 0.37,
                            name: "Catelog",
                            url: "images/4.png"),
                        container2(
                            height: size.height * 0.2,
                            width: size.width * 0.37,
                            name: "My Shop",
                            url: "images/2.png"),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: size.height * 0.72,
              ),
              child: Stack(
                children: [
                  Container(
                    // height: size.height * 0.8,
                    width: size.width,
                    // color: yellow,
                    child:
                        Image.asset("images/bottomImage.png", fit: BoxFit.fill),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: size.height * 0.05,
                        ),
                        child: Container(
                          height: 25,
                          child: Image.asset(
                            "images/i.png",
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Center(
                          child: Text(
                              "You can select several products and them your \n own shop, create new deals for your shop,start \n selling today!",
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center),
                        ),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
