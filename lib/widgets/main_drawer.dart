import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/add_brand_info_screen.dart';
import '../screens/seltzer_feed_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.dynamic_feed),
            title: Text('Activity Feed'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SeltzerFeedScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('View your profile'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('Find friends to follow'),
            onTap: () {},
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.add),
            title: Text('Add Brand Info'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AddBrandInfoScreen.routeName);
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Log Out'),
          //   onTap: () {
          //     FirebaseAuth.instance.signOut();
          //   },
          // ),
        ],
      ),
    );
  }
}
