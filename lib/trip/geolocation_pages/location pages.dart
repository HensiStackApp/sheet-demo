import 'package:flutter/material.dart';
import 'package:sheet_widget_demo/trip/geolocation_pages/place_service.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class LocationPage extends StatefulWidget {
  final sessionToken;
  const LocationPage({Key key, this.sessionToken}) : super(key: key);

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  TextEditingController searchController = TextEditingController();
  String query = "";
  PlaceApiProvider apiClient;
  @override
  void initState() {
    super.initState();
    apiClient = PlaceApiProvider(widget.sessionToken);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Location"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 10, left: 15, right: 15),
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ThemeData().colorScheme.copyWith(
                      primary: themeColor,
                    ),
              ),
              child: TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search), hintText: " Search here.."),
                validator: (value) {
                  if (value.isEmpty) {
                    return "Please enter address.";
                  }
                  return null;
                },
                onChanged: (value) {
                  query = value;
                  setState(() {});
                },
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: query == ""
                  ? null
                  : apiClient.fetchSuggestions(
                      query, Localizations.localeOf(context).languageCode),
              builder: (context, snapshot) => query == ''
                  ? Container(
                      padding: EdgeInsets.all(16.0),
                      child: Text("enterYourAddress"),
                    )
                  : snapshot.hasData
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) => ListTile(
                            title: Text((snapshot.data[index] as Suggestion)
                                .description),
                            onTap: () {
                              Navigator.pop(
                                  context, snapshot.data[index] as Suggestion);
                            },
                          ),
                          itemCount: snapshot.data.length,
                        )
                      : Center(child: CircularProgressIndicator()),
            ),
          )
        ],
      ),
    );
  }
}
