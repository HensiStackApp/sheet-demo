import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/utils/color.dart';

Widget container({
  double height,
  double width,
  String name,
  String url,
  double imgHeight,
}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: grey,
            offset: Offset(0, 0.0), //(x,y)
            blurRadius: 2.0,
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          height: imgHeight,
          child: Image.asset(url),
        ),
        Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

Widget container2(
    {double height, double width, String name, String url, Function onTap}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: grey,
            offset: Offset(0, 0.0), //(x,y)
            blurRadius: 2.0,
          ),
        ]),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: onTap,
          child: Stack(
            children: [
              Container(
                width: 90,
                height: 80,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: red.shade50),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, left: 25),
                child: Container(
                  height: 35,
                  child: Image.asset(
                    url,
                    color: red,
                  ),
                ),
              ),
            ],
          ),
        ),
        Text(
          name,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

Widget showIndicator(bool show) {
  return show
      ? Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Container(height: 2, width: 18, color: red),
        )
      : SizedBox();
}
