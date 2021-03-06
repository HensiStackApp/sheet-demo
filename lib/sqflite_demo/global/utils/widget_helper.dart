import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/sqflite_demo/global/constant/assets_constant.dart';
import 'package:sheet_widget_demo/utils/color.dart';

//  {START PAGE NAVIGATION}
void navigationPush(BuildContext context, StatefulWidget route) {
  Navigator.push(context, MaterialPageRoute(
    builder: (context) {
      return route;
    },
  ));
}

void navigationPop(BuildContext context, StatefulWidget route) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void navigationStateLessPush(BuildContext context, StatelessWidget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void navigationStateLessPop(BuildContext context, StatelessWidget route) {
  Navigator.pop(context, MaterialPageRoute(builder: (context) {
    return route;
  }));
}

void delay(BuildContext context, int duration, StatefulWidget route) {
  Future.delayed(const Duration(seconds: 3), () {
    navigationPush(context, route);
  });
}

//  {END PAGE NAVIGATION}
//  {START APPBAR}
AppBar getAppBar(BuildContext context, String title) {
  return AppBar(
    centerTitle: true,
    title: new Text(
      title,
      style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

AppBar getAppBarWithBackBtn(BuildContext context, String title) {
  return AppBar(
    leading: new IconButton(
        icon: Icon(
          Icons.keyboard_backspace,
          color: white,
        ),
        onPressed: () {
          Navigator.pop(context);
        }),
    centerTitle: true,
    title: new Text(
      title,
      style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );
}

//  {END APPBAR}
//  {START LOAD IMAGE}
FadeInImage loadImg(String url, int placeHolderPos) {
  return new FadeInImage.assetNetwork(
      fit: BoxFit.fill, placeholder: _getPlaceHolder(placeHolderPos), image: url);
}

ClipRRect loadCircleImg(String imgUrl, int placeHolderPos, double radius) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: new FadeInImage.assetNetwork(
        height: radius,
        width: radius,
        fit: BoxFit.fill,
        placeholder: _getPlaceHolder(placeHolderPos),
        image: imgUrl),
  );
}

String _getPlaceHolder(int placeHolderPos) {
  switch (placeHolderPos) {
    case 0:
      return AssetsConstant.LOGO_IMG;
    default:
      return AssetsConstant.LOGO_IMG;
  }
}

//  {END LOAD IMAGE}

Divider getDivider() {
  return Divider(
    color: grey,
    height: 1,
  );
}

//  {START TEXT VIEW}
Text getTxt(String message, FontWeight fontsWeight) {
  return Text(message,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontFamily: AssetsConstant.ZILLASLAB_FONT,
          fontWeight: fontsWeight == null ? FontWeight.normal : fontsWeight));
}

Text getTxtAppColor(String message, double fontsSize, FontWeight fontsWeight) {
  return Text(
    message,
    style: fontsSize == null
        ? _getFontStyle(themeColor, fontsWeight)
        : _getFontSizeStyle(themeColor, fontsSize, fontsWeight),
  );
}

Text getTxtWhiteColor(String message, double fontsSize, FontWeight fontsWeight) {
  return Text(
    message,
    style: fontsSize == null
        ? _getFontStyle(white, fontsWeight)
        : _getFontSizeStyle(white, fontsSize, fontsWeight),
  );
}

Text getTxtBlackColor(String message, double fontsSize, FontWeight fontsWeight) {
  return Text(
    message,
    style: fontsSize == null
        ? _getFontStyle(black, fontsWeight)
        : _getFontSizeStyle(black, fontsSize, fontsWeight),
  );
}

Text getTxtGreyColor(String message, double fontsSize, FontWeight fontsWeight) {
  return Text(
    message,
    style: fontsSize == null
        ? _getFontStyle(grey, fontsWeight)
        : _getFontSizeStyle(grey, fontsSize, fontsWeight),
  );
}

Text getTxtColor(String message, Color txtColor, double fontsSize, FontWeight fontsWeight) {
  return Text(
    message,
    style: fontsSize == null
        ? _getFontStyle(txtColor, fontsWeight)
        : _getFontSizeStyle(txtColor, fontsSize, fontsWeight),
  );
}

TextStyle _getFontStyle(Color txtColor, FontWeight fontsWeight) {
  return TextStyle(
      color: txtColor,
      decoration: TextDecoration.none,
      fontFamily: AssetsConstant.ZILLASLAB_FONT,
      fontWeight: fontsWeight == null ? FontWeight.normal : fontsWeight);
}

TextStyle _getFontSizeStyle(Color txtColor, double fontsSize, FontWeight fontsWeight) {
  return TextStyle(
      color: txtColor,
      fontSize: fontsSize,
      decoration: TextDecoration.none,
      fontFamily: AssetsConstant.ZILLASLAB_FONT,
      fontWeight: fontsWeight == null ? FontWeight.normal : fontsWeight);
}
//  {END TEXT VIEW}

void showSnackBar(BuildContext context, String message) {
  var snackbar = SnackBar(
    content: getTxtWhiteColor(message, null, null),
    backgroundColor: themeColor,
    duration: Duration(seconds: 3),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
}

showAlertDialog(BuildContext context, String title, String msg) {
  showDialog(
    context: context,
    builder: (_) {
      return AlertDialog(
        title: getTxtBlackColor(title, null, FontWeight.bold),
        content: getTxt(msg, null),
      );
    },
  );
}

Widget buildTextFied(BuildContext context, String labelText, Color fieldColor, bool isPassowrd) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0),
    child: Theme(
      data: Theme.of(context).copyWith(
        primaryColor: fieldColor, //.withOpacity(0.5),
      ),
      child: TextField(
        obscureText: isPassowrd,
        focusNode: FocusNode(),
        style: TextStyle(
          color: fieldColor,
        ),
        decoration: InputDecoration(
            labelText: labelText,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyText2
                .copyWith(color: fieldColor) //.withOpacity(0.7)),
            ),
      ),
    ),
  );
}
