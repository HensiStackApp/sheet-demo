import 'package:flutter/material.dart';

class ChoiceChips extends StatefulWidget {
  ChoiceChips({Key key}) : super(key: key);

  @override
  _ChoiceChipsState createState() => _ChoiceChipsState();
}

class _ChoiceChipsState extends State<ChoiceChips> {
  String _isSelected = "";
  List<String> selectedChoices = [];
  List chipName = ['all', 'pending', 'accept'];

  _buildChoiceList() {
    List<Widget> choices = [];
    chipName.forEach((item) {
      choices.add(Container(
        child: ChoiceChip(
          label: Text(item),
          selected: _isSelected == item,
          onSelected: (selected) {
            setState(() {
              _isSelected = item;
            });
          },
        ),
      ));
    });
    return choices;
  }

  buildChoiceList() {
    List<Widget> choices = [];
    chipName.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              print(selectedChoices.contains(item));
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    return Scaffold(
      appBar: AppBar(
        title: Text("Chips"),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 10.0, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Single chip",
              style: TextStyle(fontSize: 18),
            ),
            Wrap(
              spacing: 5.0,
              runSpacing: 3.0,
              children: _buildChoiceList(),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Multi chip",
              style: TextStyle(fontSize: 18),
            ),
            Wrap(
              spacing: 5.0,
              runSpacing: 3.0,
              children: buildChoiceList(),
            ),
          ],
        ),
      ),
    );
  }
}
