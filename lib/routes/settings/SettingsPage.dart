import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

const SETTINGS_PAGE_ROUTE = "/settings";

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Map<String, bool> data = {
    "Record audio": true,
    "Record video": false,
    "Send location": false,
    "Send message": true,
    "Call": false,
    "Make sound": false
  };
  static String timeFormatPattern = "hh:mm:ss a";
  String startTimeString = DateFormat(timeFormatPattern).format(DateTime.now());
  String endTimeString = DateFormat(timeFormatPattern).format(DateTime.now());

  // String twoTapValue = 'Record Audio';

  late String twoTapValue = 'Record Audio';
  late String threeTapValue = 'Record Video';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('2-Tap', style: Theme.of(context).textTheme.headline1),
            DropdownButton<String>(
              value: twoTapValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  print(newValue);
                  twoTapValue = newValue!;
                  prefs.setString("twoTap", twoTapValue);
                });
                // sharedPreferenceInit();
              },
              items: <String>[
                'Record Audio',
                'Record Video',
                'Send Location to Contacts',
                'Send Message to Contacts'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height:30),
            Text('3-Tap', style: Theme.of(context).textTheme.headline1),
            DropdownButton<String>(
              value: threeTapValue,
              icon: const Icon(Icons.arrow_downward),
              elevation: 16,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              underline: Container(
                height: 2,
                color: Colors.white,
              ),
              onChanged: (String? newValue) {
                setState(() {
                  threeTapValue = newValue!;
                  prefs.setString("threeTap", threeTapValue);
                });
                // sharedPreferenceInit();
              },
              items: <String>[
                'Record Audio',
                'Record Video',
                'Send Location to Contacts',
                'Send Message to Contacts'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            )

          ],
        ),
      ),
    );
    // Text('3-Tap', style: Theme.of(context).textTheme.headline1),

    // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('Start', style: Theme.of(context).textTheme.bodyText2),
    //       TextButton(
    //           onPressed: () {
    //             DatePicker.showTimePicker(context,
    //                 showTitleActions: true, onChanged: (date) {
    //               setState(() {
    //                 startTimeString =
    //                     DateFormat(timeFormatPattern).format(date);
    //               });
    //             }, currentTime: DateTime.now());
    //           },
    //           child: Text(
    //             startTimeString,
    //             style: TextStyle(color: Colors.blue, fontSize: 24),
    //           )),
    //     ],
    //   ),
    //   Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text('End', style: Theme.of(context).textTheme.bodyText2),
    //       TextButton(
    //           onPressed: () {
    //             DatePicker.showTimePicker(context,
    //                 showTitleActions: true, onConfirm: (date) {
    //               setState(() {
    //                 endTimeString =
    //                     DateFormat(timeFormatPattern).format(date);
    //               });
    //             }, currentTime: DateTime.now());
    //           },
    //           child: Text(
    //             endTimeString,
    //             style: TextStyle(color: Colors.blue, fontSize: 24),
    //           )),
    //     ],
    //   ),
    // ]),
    // SizedBox(height: 14),
    // Text('Functions', style: Theme.of(context).textTheme.headline1),
    // // createFunction("Record audio")
    // Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children:
    //         data.entries.map((e) => createFunction(e.key)).toList()),
    //     ],
    //   ),
    // ));
  }
}
