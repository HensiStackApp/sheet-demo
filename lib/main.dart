import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:sheet_widget_demo/fireBase_login/FireBase_LoginPage.dart';
import 'package:sheet_widget_demo/generated/l10n.dart';
import 'package:sheet_widget_demo/provider/provider_api.dart';
import 'package:sheet_widget_demo/tabBar_page.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:sheet_widget_demo/utils/color.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  if (defaultTargetPlatform == TargetPlatform.android) {
    InAppPurchaseAndroidPlatformAddition.enablePendingPurchases();
  }
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ProviderPageApi()),
  ], child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var users = FirebaseAuth.instance.currentUser;
  Locale _locale;
  setLocale(Locale value) {
    setState(() {
      _locale = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        localizationsDelegates: [
          // 1
          S.delegate,
          // 2
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        locale: _locale,
        theme: ThemeData(
            primaryColor: themeColor,
            accentColor: themeColor,
            fontFamily: 'NunitoSans'),
        debugShowCheckedModeBanner: false,
        home: (users == null) ? LogInPage() : TabBarPage(userName: "abc",),
        builder: EasyLoading.init(),
      ),
    );
  }
}
