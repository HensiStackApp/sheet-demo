import 'package:flutter/material.dart';
import 'package:progress_hud/progress_hud.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class IndicatorPage extends StatefulWidget {
  const IndicatorPage({Key key}) : super(key: key);

  @override
  _IndicatorPageState createState() => _IndicatorPageState();
}

class _IndicatorPageState extends State<IndicatorPage> {
  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        title: Text("Indicator"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "progress hud",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 100,
              child: ProgressHUD(
                color: white,
                containerColor: themeColor,
                borderRadius: 5.0,
                text: 'Loading...',
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "LinearProgressIndicator",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            LinearProgressIndicator(
              backgroundColor: themeColor,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "CircularProgressIndicator",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(
              height: 10,
            ),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(themeColor),
            ),
          ],
        ),
      ),
    );
  }
}
