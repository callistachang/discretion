import 'package:flutter/material.dart';
import 'package:safe_zone/components/Navbar.dart';

const HOME_PAGE_ROUTE = "/";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isDoubleTapOn = false;
  bool isTripleTapOn = false;
  Map<String, List> data = {"8:00 - 16:00": ["Record audio", "Send message"], "16:00 - 18:00": ["Did some other stuff"]};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
        appBar: AppBar(
          title: const Text('Safe Zone'),
          actions: <Widget>[
            // IconButton(
            //   icon: const Icon(Icons.add_alert),
            //   onPressed: () {
            //     ScaffoldMessenger.of(context).showSnackBar(
            //         const SnackBar(content: Text('This is a snackbar')));
            //   },
            // ),
            // IconButton(
            //   icon: const Icon(Icons.navigate_next),
            //   tooltip: 'Go to the next page',
            //   onPressed: () {
            //     Navigator.push(context, MaterialPageRoute<void>(
            //       builder: (BuildContext context) {
            //         return Scaffold(
            //           appBar: AppBar(
            //             title: const Text('Next page'),
            //           ),
            //           body: const Center(
            //             child: Text(
            //               'This is the next page',
            //               style: TextStyle(fontSize: 24),
            //             ),
            //           ),
            //         );
            //       },
            //     ));
            //   },
            // ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Dashboard',
                  style: Theme.of(context).textTheme.headline1
              ),
              SizedBox(height: 10),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Tap-tap',
                        style: Theme.of(context).textTheme.headline1
                    ),
                    Switch(
                      value: isDoubleTapOn,
                      onChanged: (value) {
                        setState(() {
                          isDoubleTapOn = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ]
              ),
              SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 2),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: data.entries.map((e) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(e.key, style: Theme.of(context).textTheme.bodyText2),
                        SizedBox(width: 20),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: e.value.map((v) => Text(v, style: Theme.of(context).textTheme.bodyText2)).toList()
                        )],
                    )).toList()
                ),
              ),
              Spacer(),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        'Tap-tap-tap',
                        style: Theme.of(context).textTheme.headline1
                    ),
                    Switch(
                      value: isTripleTapOn,
                      onChanged: (value) {
                        setState(() {
                          isTripleTapOn = value;
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ]
              ),
              SizedBox(height: 10),
              Flexible(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(width: 1, color: Colors.green, style: BorderStyle.solid),
                      color: Colors.blue[900]
                  ),
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
        )
    );
  }
}
