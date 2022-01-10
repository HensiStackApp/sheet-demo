import 'dart:convert';
import 'package:http/http.dart';

class PlaceApiProvider {
  final client = Client();

  PlaceApiProvider(this.sessionToken);

  final sessionToken;

  // String apiKey = Platform.isIOS
  //     ? StringResources.IosAPIKe
  //     : StringResources.AndroidAPIKey;

  final apiKey = 'AIzaSyB_kIX5UrOzY9KC14LVNRAIsZCkx3xBXeA';

  Future<List<Suggestion>> fetchSuggestions(String input, String lang) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&types=address&language=$lang&components=country:in&key=$apiKey&sessiontoken=$sessionToken';
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        print(result);
        return result['predictions']
            .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      throw Exception(result['error_message']);
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }

  distance(double lat1, double lat2, double lon1, double lon2) async {
    print(lat1);
    print(lon1);
    print(lat2);
    print(lon2);
    final request =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=$lat1,$lat2&destinations=$lon1,$lon2&key=$apiKey";
    final response = await client.get(Uri.parse(request));

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        print("result-->$result");
        // return result['predictions']
        //     .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
        //     .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
    } else {
      throw Exception('Failed to fetch suggestion');
    }
  }
}

class Suggestion {
  final String placeId;
  final String description;

  Suggestion(this.placeId, this.description);

  @override
  String toString() {
    return 'Suggestion(description: $description, placeId: $placeId)';
  }
}
