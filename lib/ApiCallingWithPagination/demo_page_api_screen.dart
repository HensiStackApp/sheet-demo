import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sheet_widget_demo/utils/color.dart';
import 'demo_page_view_model.dart';

class DemoPageApiScreen extends StatefulWidget {
  const DemoPageApiScreen({Key key}) : super(key: key);

  @override
  DemoPageApiScreenState createState() => DemoPageApiScreenState();
}

class DemoPageApiScreenState extends State<DemoPageApiScreen> {
  ScrollController scrollController = ScrollController();
  DemoPageViewModel demoPageViewModel;
  int limit = 10;
  int page = 1;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          demoPageViewModel.demoData.length <= 20) {
        loadData();
      } else if (scrollController.position.pixels == scrollController.position.maxScrollExtent &&
          demoPageViewModel.demoData.length >= 20) {
        Fluttertoast.showToast(
          msg: 'No more data.!',
          textColor: white,
          backgroundColor: red,
        );
        print('Record over');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    // ignore: unnecessary_statements
    demoPageViewModel ?? (demoPageViewModel = DemoPageViewModel(this));
    return Scaffold(
      appBar: AppBar(
        title: Text("pagination"),
      ),
      body: demoPageViewModel.demoData == null || demoPageViewModel.demoData.length == 0
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: black,
              ),
            )
          : Container(
              child: ListView.builder(
                  controller: scrollController,
                  itemCount: demoPageViewModel.demoData.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == demoPageViewModel.demoData.length - 1 &&
                        demoPageViewModel.demoData.length <= 20) {
                      return Center(
                        child: CircularProgressIndicator(
                          backgroundColor: black,
                        ),
                      );
                    }
                    return Padding(
                      padding: EdgeInsets.all(8),
                      child: Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: themeColor, borderRadius: BorderRadius.circular(12)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.all(5),
                                child: Text("${demoPageViewModel.demoData[index].id}")),
                            Container(
                              margin: EdgeInsets.all(5),
                              child: Text("${demoPageViewModel.demoData[index].author}"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }

  Future loadData() async {
    print('loading data');
    demoPageViewModel.paginationAPI(limit: limit + 5, page: 1);
    limit = limit + 5;
    setState(() {});
  }
}
