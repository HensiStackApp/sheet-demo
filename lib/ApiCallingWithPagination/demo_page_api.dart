import 'package:http/http.dart' as http;

import 'demo_page_model.dart';

class DemoPageApi {
  paginationApi({int page, int limit}) async {
    String url = 'https://picsum.photos/v2/list?page=$page&limit=$limit';
    print('url---> $url');
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        print('response code: ${response.body}');
        return demoPageApiModelFromJson(response.body);
      } else {
        print('response: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('catch error in Pagination API --->$e');
      return null;
    }
  }
}
