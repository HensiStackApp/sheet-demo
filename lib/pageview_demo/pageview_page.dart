import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class PageViewHomePage extends StatefulWidget {
  const PageViewHomePage({Key key}) : super(key: key);

  @override
  _PageViewHomePageState createState() => _PageViewHomePageState();
}

class _PageViewHomePageState extends State<PageViewHomePage> {
  PageController controller = PageController();
  var currentPageValue = 1.0;

  @override
  Widget build(BuildContext context) {
    print("current page-->$runtimeType");
    controller.addListener(() {
      setState(() {
        currentPageValue = controller.page;
      });
    });
    return Scaffold(
        body: PageView.builder(
      controller: controller,
      itemBuilder: (context, position) {
        if (position == currentPageValue.floor()) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? themeColor2 : themeColor4,
              child: Center(
                child: Text(
                  "page $position",
                  style: TextStyle(color: white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else if (position == currentPageValue.floor() + 1) {
          return Transform(
            transform: Matrix4.identity()..rotateX(currentPageValue - position),
            child: Container(
              color: position % 2 == 0 ? themeColor2 : themeColor4,
              child: Center(
                child: Text(
                  "page $position",
                  style: TextStyle(color: white, fontSize: 22.0),
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: position % 2 == 0 ? themeColor2 : themeColor4,
            child: Center(
              child: Text(
                "page $position",
                style: TextStyle(color: white, fontSize: 22.0),
              ),
            ),
          );
        }
      },
      itemCount: 3,
    )
        /* PageView(
      controller: controller,
      physics: BouncingScrollPhysics(),
      children: <Widget>[
        Container(
          color: themeColor1,
          child: Center(
              child: Text(
            "page1",
            style: TextStyle(fontSize: 25, color: white),
          )),
        ),
        Container(
          color: themeColor2,
          child: Center(
              child: Text(
            "page2",
            style: TextStyle(fontSize: 25, color: white),
          )),
        ),
        Container(
          color: themeColor3,
          child: Center(
              child: Text(
            "page3",
            style: TextStyle(fontSize: 25, color: white),
          )),
        ),
      ],
    )*/
        );
  }
}
