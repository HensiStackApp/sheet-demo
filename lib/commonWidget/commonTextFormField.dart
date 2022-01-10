import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/utils/color.dart';

Widget textFormField(
    {TextEditingController controller,
    Widget prefix,
    Function validation,
    String text,
    Function onTap,
    TextInputType keyboardType}) {
  return TextFormField(
    onTap: onTap,
    controller: controller,
    validator: validation,
    enabled: true,
    enableInteractiveSelection: false,
    textAlign: TextAlign.start,
    cursorColor: Colors.black87,
    keyboardType: keyboardType,
    decoration: InputDecoration(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelText: text,
      isDense: true,
      prefix: prefix,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: themeColor, width: 1.0),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: themeColor, width: 1.0),
        borderRadius: BorderRadius.circular(5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: themeColor, width: 1.0),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(color: themeColor, width: 1.0),
      ),
    ),
  );
}
