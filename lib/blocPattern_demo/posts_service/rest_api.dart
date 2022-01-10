import 'package:http/http.dart' as http;
import 'package:sheet_widget_demo/blocPattern_demo/model/posts_model.dart';

class PostApi {
  static const String base_Url = 'https://jsonplaceholder.typicode.com/posts?';
  static const limit = 20;

  Future<List<PostsModel>> postsApi([int start = 0]) async {
    String url = base_Url + '_start=$start&_limit=$limit';
    print('Url --> $url');
    try {
      http.Response response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        if (response.body != null) {
          return postsModelFromJson(response.body);
        } else {
          return null;
        }
      } else {
        print('Status Code --> ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Catch error in postsApi method --> $e');
      return null;
    }
  }
}
