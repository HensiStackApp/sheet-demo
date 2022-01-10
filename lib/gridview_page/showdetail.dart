import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class ShowDetailPage extends StatefulWidget {
  final Color color;
  final String name;

  const ShowDetailPage({Key key, this.name, this.color}) : super(key: key);

  @override
  _ShowDetailPageState createState() => _ShowDetailPageState();
}

class _ShowDetailPageState extends State<ShowDetailPage> {
  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.color,
        title: Text(widget.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.7,
          decoration: BoxDecoration(color: widget.color, borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              widget.name,
              style: TextStyle(color: white, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
