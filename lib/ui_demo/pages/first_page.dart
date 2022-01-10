import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/ui_demo/commmon/common_container.dart';
import 'package:sheet_widget_demo/utils/color.dart';
import 'package:showcaseview/showcaseview.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  GlobalKey _one = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one]));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      extendBody: true,
      body: Stack(
        children: [
          Container(
            height: size.height * 0.25,
            decoration: BoxDecoration(
                color: red,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: EdgeInsets.only(
                  top: size.height * 0.04,
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
                    "MyShop",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.more_time,
                        color: white,
                        size: 25,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Icon(
                          Icons.more_vert,
                          color: white,
                          size: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: size.height * 0.13,
                left: size.height * 0.04,
                right: size.height * 0.04),
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Showcase(
                        key: _one,
                        description: 'Tap to see menu options',
                        child: container(
                            height: size.height * 0.18,
                            width: size.width * 0.37,
                            name: "Analytics",
                            imgHeight: size.height * 0.06,
                            url: "images/1.png"),
                      ),
                      container(
                          height: size.height * 0.18,
                          width: size.width * 0.37,
                          name: "My Shop",
                          imgHeight: size.height * 0.06,
                          url: "images/2.png"),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      container(
                          height: size.height * 0.18,
                          width: size.width * 0.37,
                          name: "Reservations",
                          imgHeight: size.height * 0.06,
                          url: "images/3.png"),
                      container(
                          height: size.height * 0.18,
                          width: size.width * 0.37,
                          name: "catelog",
                          imgHeight: size.height * 0.06,
                          url: "images/4.png"),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Row(
                    children: [
                      container(
                          height: size.height * 0.15,
                          width: size.width * 0.26,
                          name: "Deals",
                          imgHeight: size.height * 0.04,
                          url: "images/5.png"),
                      SizedBox(
                        width: size.width * 0.025,
                      ),
                      container(
                          height: size.height * 0.15,
                          width: size.width * 0.26,
                          name: "Accounting",
                          imgHeight: size.height * 0.04,
                          url: "images/6.png"),
                      SizedBox(
                        width: size.width * 0.025,
                      ),
                      container(
                          height: size.height * 0.15,
                          width: size.width * 0.26,
                          name: "Favourite",
                          imgHeight: size.height * 0.04,
                          url: "images/7.png"),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.025,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: size.height * 0.06, right: size.height * 0.06),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        container(
                            height: size.height * 0.15,
                            width: size.width * 0.26,
                            name: "Gifts",
                            imgHeight: size.height * 0.04,
                            url: "images/8.png"),
                        container(
                            height: size.height * 0.15,
                            width: size.width * 0.26,
                            name: "Invite User",
                            imgHeight: size.height * 0.04,
                            url: "images/9.png"),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ShowCase extends StatelessWidget {
  const ShowCase({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ShowCaseWidget(
            builder: Builder(builder: (context) => FirstPage())));
  }
}
