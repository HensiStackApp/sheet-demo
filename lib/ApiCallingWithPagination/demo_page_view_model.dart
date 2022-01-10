import 'demo_page_api.dart';
import 'demo_page_api_screen.dart';
import 'demo_page_model.dart';

class DemoPageViewModel {
  DemoPageApiScreenState demoPageApiScreenState;
  List<DemoPageApiModel> demoData;

  DemoPageViewModel(this.demoPageApiScreenState) {
    paginationAPI(limit: demoPageApiScreenState.limit, page: demoPageApiScreenState.page);
  }

  paginationAPI({int page, int limit}) async {
    List<DemoPageApiModel> data = await DemoPageApi().paginationApi(page: page, limit: limit);
    if (data != null) {
      print('Data --> ${data.length}');
      demoData = data;
      // ignore: invalid_use_of_protected_member
      demoPageApiScreenState.setState(() {});
    } else {
      print('Data null');
    }
  }
}
