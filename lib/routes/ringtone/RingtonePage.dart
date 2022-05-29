import 'package:flutter/material.dart';
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
    "Cosmic"
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
                height: 650,
              ),
            ],
          ),
        ));
  }
}
