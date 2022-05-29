import 'package:flutter/material.dart';
import 'package:safe_zone/components/Navbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

const HOME_PAGE_ROUTE = "/";

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              ElevatedButton(
                child: const Text(
                  'Discretion',
                  style: TextStyle(fontSize: 24),
                ),
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.height,
                      MediaQuery.of(context).size.width),
                  shape: const CircleBorder(),
                ),
              ),
              Center(
                child: Column(
                  children: [
                    Text("Tap 2x to $twoTapValue"),
                    SizedBox(height: 10),
                    Text("Tap 3x to $threeTapValue"),
                    SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
