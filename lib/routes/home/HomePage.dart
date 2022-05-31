import 'dart:convert';

import 'package:discretion/components/Navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wechat_camera_picker/wechat_camera_picker.dart';

import 'LocationService.dart';

const HOME_PAGE_ROUTE = "/";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String twoTapValue = 'Call Top Contact';
  late String threeTapValue = 'Record Video';
  int lastTap = 1;
  int consecutiveTaps = 1;

  late SharedPreferences prefs;

  void sharedPreferenceInit() async {
    prefs = await SharedPreferences.getInstance();
    twoTapValue = prefs.getString("twoTap");
    threeTapValue = prefs.getString("threeTap");
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    sharedPreferenceInit();
  }

  void sendSMSToContacts(String defaultMessage, List<String> recipients) async {
    await sendSMS(message: defaultMessage, recipients: recipients)
        .then((value) {
      print("Location sent to contacts");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Location sent to contacts"),
      ));
    }).catchError((onError) {
      print("Something went wrong");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
  }

  void executeAction(setting, Map<String, dynamic> kwargs) async {
    switch (setting) {
      case "Call Top Contact":
        {
          if (kwargs["phoneNumbers"] == null) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("No contacts configured"),
            ));
            break;
          }
          await FlutterPhoneDirectCaller.callNumber(kwargs["phoneNumbers"][0]);
        }
        break;
      case "Record Video":
        {
          await CameraPicker.pickFromCamera(
            context,
            pickerConfig: const CameraPickerConfig(
                enableRecording: true,
                onlyEnableRecording: true,
                enableTapRecording: true),
          );
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Video saved"),
          ));
        }
        break;
      case 'Send Location to Contacts':
        {
          LocationService service = new LocationService();
          Position pos = await service.getCurrentPosition();
          final maps = Uri.https(
              "google.com", "maps", {"q": "${pos.latitude},${pos.longitude}"});
          sendSMSToContacts(
              "Here is my current location: $maps", kwargs["phoneNumbers"]);
        }
        break;
      case "Send Message to Contacts":
        {
          sendSMSToContacts(kwargs["defaultMessage"], kwargs["phoneNumbers"]);
        }
        break;
      default:
        {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("No action configured"),
          ));
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavBar(),
        appBar: AppBar(
          title: const Text('Safe Zone'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard', style: Theme.of(context).textTheme.headline1),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  Map<String, dynamic> kwargs = {
                    "defaultMessage": prefs.getString("defaultMessage"),
                  };
                  if (prefs.getString("contacts") != null) {
                    kwargs["phoneNumbers"] = new Map<String, String>.from(
                            json.decode(prefs.getString("contacts")))
                        .values
                        .toList();
                  }
                  executeAction(twoTapValue, kwargs);
                },
                onDoubleTap: () {
                  Map<String, dynamic> kwargs = {
                    "defaultMessage": prefs.getString("defaultMessage"),
                  };
                  if (prefs.getString("contacts") != null) {
                    kwargs["phoneNumbers"] = new Map<String, String>.from(
                        json.decode(prefs.getString("contacts")))
                        .values
                        .toList();
                  }
                  executeAction(threeTapValue, kwargs);
                },
                child: Center(
                  child: Container(
                    alignment: Alignment.center,
                    child: const Text(
                      'Discretion',
                      style: TextStyle(fontSize: 24),
                    ),
                    height: 300,
                    width: 300,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(1000)),
                  ),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Text("Tap 1x to $twoTapValue"),
                    SizedBox(height: 10),
                    Text("Tap 2x to $threeTapValue"),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
