import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PhotoviewPage extends StatefulWidget {
  final String imgUrl;

  const PhotoviewPage({Key key, this.imgUrl}) : super(key: key);

  @override
  _PhotoviewPageState createState() => _PhotoviewPageState();
}

class _PhotoviewPageState extends State<PhotoviewPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            child: PhotoView(
          imageProvider: NetworkImage(widget.imgUrl),
        )),
      ),
    );
  }
}
