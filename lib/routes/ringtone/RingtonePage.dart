import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

const RINGTONE_PAGE_ROUTE = "/ringtone";

class RingtonePage extends StatefulWidget {
  const RingtonePage({Key? key}) : super(key: key);

  @override
  _RingtonePageState createState() => _RingtonePageState();
}

class _RingtonePageState extends State<RingtonePage> {
  List<String> data = [
    "Radar",
    "Apex",
    "Beacon",
    "Bulletin",
    "Chimes",
    "Circuit",
    "Constellation",
    "Cosmic",
    "A",
    "B",
    "C",
    "D",
    "E"
  ];
  String currentRingtone = "Radar";
  static String timeFormatPattern = "hh:mm:ss a";
  String delayTimeString = DateFormat(timeFormatPattern).format(DateTime.now());

  Widget createRingtoneRow(String name) {
    return ListTile(
        title: Text(name),
        leading: Radio(
          value: name,
          groupValue: currentRingtone,
          onChanged: (String? value) => setState(() {
            currentRingtone = name;
          }),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sound'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: ListView(
                  shrinkWrap: true,
                  children:
                      data.map((name) => createRingtoneRow(name)).toList(),
                ),
                height: 400,
              ),
              SizedBox(height: 10),
              Center(
                child: Text(
                  "Delay",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              SizedBox(height: 10),
              Flexible(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: Colors.green,
                          style: BorderStyle.solid),
                      color: Colors.blue[500]),
                  child: TextButton(
                      onPressed: () {
                        DatePicker.showTimePicker(context,
                            showTitleActions: true, onConfirm: (date) {
                          setState(() {
                            delayTimeString =
                                DateFormat(timeFormatPattern).format(date);
                          });
                        }, currentTime: DateTime.now());
                      },
                      child: Text(
                        delayTimeString,
                        style: TextStyle(color: Colors.white, fontSize: 40),
                      )),
                ),
              ),
            ],
          ),
        ));
  }
}
