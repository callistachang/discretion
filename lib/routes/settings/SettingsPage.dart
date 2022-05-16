import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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

  Widget createFunction(String title) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.lightGreenAccent),
          borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Switch(
            value: data[title]!,
            onChanged: (value) {
              setState(() {
                data[title] = value;
              });
            },
            activeTrackColor: Colors.lightGreenAccent,
            activeColor: Colors.green,
          ),
        ],
      ),
    );
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
              Text('Settings', style: Theme.of(context).textTheme.headline1),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start', style: Theme.of(context).textTheme.bodyText2),
                    TextButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now());
                        },
                        child: Text(
                          '8:00',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('End', style: Theme.of(context).textTheme.bodyText2),
                    TextButton(
                        onPressed: () {
                          DatePicker.showTimePicker(context,
                              showTitleActions: true, onChanged: (date) {
                            print('change $date in time zone ' +
                                date.timeZoneOffset.inHours.toString());
                          }, onConfirm: (date) {
                            print('confirm $date');
                          }, currentTime: DateTime.now());
                        },
                        child: Text(
                          '8:00',
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
              ]),
              SizedBox(height: 14),
              Text('Functions', style: Theme.of(context).textTheme.headline1),
              // createFunction("Record audio")
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: data.entries.map((e) => createFunction(e.key)).toList()),
            ],
          ),

        ));
  }
}
