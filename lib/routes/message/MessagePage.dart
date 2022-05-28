import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';

const MESSAGE_PAGE_ROUTE = "/message";

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  TextEditingController textarea = TextEditingController();
  TextEditingController newContactName = TextEditingController();
  TextEditingController newNumber = TextEditingController();

  late Map<String, String> data = {"Callista Chang": "6596504510"};
  late SharedPreferences prefs;

  void sharedPreferenceInit() async {
    prefs = await SharedPreferences.getInstance();
    String stringData = prefs.getString("contacts");
    data = new Map<String, String>.from(json.decode(stringData));
    // ignore: unnecessary_null_comparison
    if (data == null) {
      data = {"Callista Chang": "6596504510"};
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    sharedPreferenceInit();
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  _openPopup(context) {
    Alert(
        context: context,
        title: "LOGIN",
        content: Column(
          children: <Widget>[
            TextField(
              controller: newContactName,
              decoration: InputDecoration(
                icon: Icon(Icons.contact_page),
                labelText: 'Contact Name',
              ),
            ),
            TextField(
              controller: newNumber,
              decoration: InputDecoration(
                icon: Icon(Icons.phone),
                labelText: 'Phone Number',
              ),
            ),
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () {
              setState(() {
                data[newContactName.text] = newNumber.text;
                prefs.setString("contacts", json.encode(data));
              });
              Navigator.pop(context);
            },
            child: Text(
              "Create Contact",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  Widget createContact(String name) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(color: Colors.lightGreenAccent),
              borderRadius: BorderRadius.circular(5)),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name),
              TextButton(
                  onPressed: () {
                    String number = data[name] as String;
                    _sendSMS(textarea.text, [number]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Message sent to $name, $number"),
                    ));
                  },
                  child: Text("Send"))
            ],
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    textarea.text = "I'm currently in danger.";

    return Scaffold(
        appBar: AppBar(
          title: const Text('Message'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Contact', style: Theme.of(context).textTheme.headline1),
                  IconButton(
                      onPressed: () => {_openPopup(context)},
                      icon: Icon(Icons.add))
                ],
              ),
              SizedBox(height: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      data.entries.map((e) => createContact(e.key)).toList()),
              Spacer(),
              Text(
                "Default Message",
                style: Theme.of(context).textTheme.headline1,
              ),
              // Center(
              //   child: Text(
              //     "Default Message",
              //     style: Theme.of(context).textTheme.headline1,
              //   ),
              // ),
              SizedBox(height: 10),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          width: 1,
                          color: Colors.green,
                          style: BorderStyle.solid),
                      color: Colors.blue[900]),
                  child: TextField(
                    minLines: 10,
                    maxLines: 20,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        border: InputBorder.none),
                    controller: textarea,
                    // onChanged: (value) {
                    //   // Do something
                    // },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
