import 'package:sheet_widget_demo/provider/provider_api.dart';
import 'package:sheet_widget_demo/provider/provider_api_page_demo.dart';

class ProviderViewModel {
  ProviderApiDemoState state;

  ProviderViewModel(this.state) {
    this.state = state;
  }

  providerApi(ProviderPageApi provider) async {
    provider.dataList = state.providerData.dataList;

    if(provider.dataList == null || provider.dataList.isEmpty )
      {
        provider.dataList = await ProviderPageApi().providerApi();
         state.isRefresh = false;
        if(provider.dataList != null && provider.dataList.isNotEmpty){
          state.providerData.dataList = provider.dataList;
        }
        provider.notifyListeners();
      }
  }
}
