import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:sheet_widget_demo/ApiCallingWithPagination/demo_page_api.dart';
import 'package:sheet_widget_demo/provider/provider_api.dart';
import 'package:sheet_widget_demo/provider/provider_api_view_model.dart';
import 'package:sheet_widget_demo/utils/color.dart';

class ProviderApiDemo extends StatefulWidget {
  const ProviderApiDemo({Key key}) : super(key: key);

  @override
  ProviderApiDemoState createState() => ProviderApiDemoState();
}

class ProviderApiDemoState extends State<ProviderApiDemo> {
  DemoPageApi demoPageApi = DemoPageApi();
  ProviderViewModel model;
  ProviderPageApi providerData;
  bool isRefresh = false;

  @override
  Widget build(BuildContext context) {
    print("currant page-->$runtimeType");
    // ignore: unnecessary_statements
    providerData = Provider.of<ProviderPageApi>(context, listen: false);

    model ?? (model = ProviderViewModel(this));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: Text("Provider demo"),
      ),
      body: RefreshIndicator(
        onRefresh: () {
          isRefresh = true;
          providerData.dataList = [];
          setState(() {});
          return Future.delayed(Duration(milliseconds: 300));
        },
        backgroundColor: themeColor,
        color: white,
        child: ChangeNotifierProvider<ProviderPageApi>(
          create: (BuildContext context) {
            return ProviderPageApi();
          },
          child: Consumer<ProviderPageApi>(
            builder: (context, provider, _) {
              if (provider.dataList.length == 0 || isRefresh) {
                model.providerApi(provider);
              }
              return (provider.dataList != null && provider.dataList.isNotEmpty)
                  ? ListView.builder(
                      itemCount: provider.dataList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Slidable(
                          actionPane: SlidableDrawerActionPane(),
                          actionExtentRatio: 0.25,
                          secondaryActions: <Widget>[
                            Container(
                              height: 80.0,
                              margin: EdgeInsets.only(
                                top: 5,
                                bottom: 5,
                              ),
                              child: IconSlideAction(
                                caption: 'Delete',
                                color: Colors.red,
                                icon: Icons.delete,
                                onTap: () {
                                  provider.dataList.removeAt(index);
                                  setState(() {});
                                },
                              ),
                            ),
                          ],
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: themeColor,
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Text(
                                    " id : ${provider.dataList[index].id}",
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(13),
                                  child: Text(
                                      " author : ${provider.dataList[index].author}"),
                                ),
                              ],
                            ),
                          ),
                        );
                      })
                  : (isRefresh)
                      ? SizedBox()
                      : Center(
                          child: CircularProgressIndicator(),
                        );
            },
          ),
        ),
      ),
    );
  }
}
