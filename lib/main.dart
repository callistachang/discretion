import 'package:flutter/material.dart';
import 'package:discretion/routes/home/HomePage.dart';
import 'package:discretion/routes/message/MessagePage.dart';
import 'package:discretion/routes/ringtone/RingtonePage.dart';
import 'package:discretion/routes/settings/SettingsPage.dart';

void main() => runApp(const SafeZoneApp());

class SafeZoneApp extends StatelessWidget {
  const SafeZoneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Safe Zone",
      home: HomePage(),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent[400],
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 32.0, fontWeight: FontWeight.bold, color: Colors.white),
          bodyText2: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
      routes: <String, WidgetBuilder>{
        MESSAGE_PAGE_ROUTE: (BuildContext context) => MessagePage(),
        RINGTONE_PAGE_ROUTE: (BuildContext context) => RingtonePage(),
        SETTINGS_PAGE_ROUTE: (BuildContext context) => SettingsPage()
      },
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
    );
  }
}
