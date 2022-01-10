import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class ChoosePlacePage extends StatefulWidget {
  final locationCallBack;

  const ChoosePlacePage({Key key, this.locationCallBack}) : super(key: key);

  @override
  _ChoosePlacePageState createState() => _ChoosePlacePageState();
}

class _ChoosePlacePageState extends State<ChoosePlacePage> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    print("currant page -->$runtimeType");
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.pop(context, controller.text);
          return;
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                TextFormField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Choose start location",
                    prefixIcon: InkWell(
                        onTap: () {
                          Navigator.pop(context, controller.text);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: grey,
                        )),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 15),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: grey, width: 1.0),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: grey, width: 1.0),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: grey, width: 1.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: grey, width: 1.0),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.95,
                        color: grey.shade200,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
