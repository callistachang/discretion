import 'package:flutter/material.dart';

const MESSAGE_PAGE_ROUTE = "/message";

class MessagePage extends StatefulWidget {
  const MessagePage({Key? key}) : super(key: key);

  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  Map<String, bool> data = {"Sinney Shao": true, "Kamisato Ayaka": false};

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
              Switch(
                value: data[name]!,
                onChanged: (value) {
                  setState(() {
                    data[name] = value;
                  });
                },
                activeTrackColor: Colors.lightGreenAccent,
                activeColor: Colors.green,
              ),
            ],
          ),
        ),
        SizedBox(height: 10)
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Message'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact', style: Theme.of(context).textTheme.headline1),
              SizedBox(height: 10),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      data.entries.map((e) => createContact(e.key)).toList()),
              Spacer(),
              Center(
                child: Text(
                  "Message",
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
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
                        hintText: 'Type something here',
                        contentPadding: EdgeInsets.all(15),
                        border: InputBorder.none),
                    onChanged: (value) {
                      // Do something
                    },
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
