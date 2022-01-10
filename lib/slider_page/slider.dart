import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({Key key}) : super(key: key);

  @override
  _SliderPageState createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  RangeValues currentRangeValues = const RangeValues(0, 60);
  int sliderValue = 1;

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        title: Text("Slider"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Simple Slider',
              style: TextStyle(fontSize: 18),
            ),
            Slider(
                min: 0,
                max: 100,
                divisions: 20,
                label: sliderValue.toDouble().toString(),
                value: sliderValue.toDouble(),
                activeColor: themeColor,
                inactiveColor: grey,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value.round();
                  });
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              'Range Slider',
              style: TextStyle(fontSize: 18),
            ),
            RangeSlider(
                min: 0,
                max: 100,
                divisions: 20,
                activeColor: themeColor,
                inactiveColor: grey,
                labels: RangeLabels(
                  currentRangeValues.start.round().toString(),
                  currentRangeValues.end.round().toString(),
                ),
                values: currentRangeValues,
                onChanged: (RangeValues values) {
                  setState(() {
                    currentRangeValues = values;
                  });
                }),
            SizedBox(
              height: 20,
            ),
            Text(
              ' Image Slider',
              style: TextStyle(fontSize: 18),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width,
              child: imageSlider(context),
            )
          ],
        ),
      ),
    );
  }
}

Swiper imageSlider(context) {
  return new Swiper(
    autoplay: true,
    itemBuilder: (BuildContext context, int index) {
      return Image.network(
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ9R6WVd7lIJePzBBD2MiZRy511oh9ONh0H_w&usqp=CAU",
        fit: BoxFit.cover,
      );
    },
    itemCount: 10,
    viewportFraction: 0.7,
    scale: 0.8,
  );
}
