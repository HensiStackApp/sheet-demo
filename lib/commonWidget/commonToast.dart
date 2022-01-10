import 'package:fluttertoast/fluttertoast.dart';
import 'package:sheet_widget_demo/utils/color.dart';

toast({String text}) {
  return Fluttertoast.showToast(
    timeInSecForIosWeb: 30,
    msg: text,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.SNACKBAR,
    backgroundColor: red.withOpacity(0.5),
    textColor: white,
    fontSize: 16.0,
  );
}
