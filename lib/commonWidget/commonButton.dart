import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/utils/color.dart';

Widget button(BuildContext context, String text, Function onTap) {
  return MaterialButton(
    shape: BeveledRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
      side: BorderSide(color: white),
    ),
    color: themeColor,
    minWidth: 20,
    onPressed: onTap,
    child: Text(
      text,
      style: TextStyle(color: white),
    ),
  );
}

Widget elevatedButton(Function onTap, String text) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(primary: themeColor),
    onPressed: onTap,
    child: Text(text),
  );
}
