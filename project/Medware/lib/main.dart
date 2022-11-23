import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:medware/screens/auth/screens.dart' as auth;
import 'package:medware/screens/main/main_screen.dart';
import 'package:medware/utils/api/notification/push_notification.dart';
import 'package:medware/utils/shared_preference/shared_preference.dart';

Future main() async {
  Intl.defaultLocale = 'th';
  initializeDateFormatting();

  WidgetsFlutterBinding.ensureInitialized();
  PushNotification.init();
  await SharedPreference.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'NotoSansThai',
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarIconBrightness: SharedPreference.getUserRole() == 1
                ? Brightness.light
                : Brightness.dark,
            statusBarColor: Colors.transparent,
          ),
        ),
      ),
      home: SharedPreference.getToken() != '' ? auth.screens[0] : MainScreen(),
      // home: const MainScreen(),
    );
  }
}
