import 'package:flutter/material.dart';
import 'package:safe_zone/routes/home/HomePage.dart';
import 'package:safe_zone/routes/message/MessagePage.dart';
import 'package:safe_zone/routes/ringtone/RingtonePage.dart';
import 'package:safe_zone/routes/settings/SettingsPage.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Test Account'),
            accountEmail: Text('test_account@email.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fwww.omgtb.com%2Fwp-content%2Fuploads%2F2021%2F04%2F620_NC4xNjE-1-scaled.jpg&f=1&nofb=1',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => Navigator.pushNamed(context, HOME_PAGE_ROUTE),
          ),
          ListTile(
            leading: Icon(Icons.message),
            title: Text('Message'),
            onTap: () => Navigator.pushNamed(context, MESSAGE_PAGE_ROUTE),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Ringtone'),
            onTap: () => Navigator.pushNamed(context, RINGTONE_PAGE_ROUTE),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () => Navigator.pushNamed(context, SETTINGS_PAGE_ROUTE),
          ),
        ],
      ),
    );
  }
}
