import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../widgets/activity_feed.dart';
import '../widgets/main_drawer.dart';
import './add_seltzer_screen.dart';
import '../screens/add_seltzer_screen.dart';
import '../screens/user_profile_screen.dart';

class SeltzerFeedScreen extends StatefulWidget {
  static const routeName = '/seltzer-feed';
  @override
  _SeltzerFeedScreenState createState() => _SeltzerFeedScreenState();
}

class _SeltzerFeedScreenState extends State<SeltzerFeedScreen> {
  var _isInit = true;
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Activity'),
        actions: <Widget>[
          DropdownButton(
            icon: Icon(Icons.more_vert),
            underline: Container(),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Log Out'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: ActivityFeed(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: RaisedButton.icon(
                        onPressed: () {
                          Navigator.of(context)
                              .pushNamed(AddSeltzerScreen.routeName);
                        },
                        icon: Icon(Icons.add),
                        label: Text('Rate a new Seltzer'),
                        color: Theme.of(context).accentColor,
                        elevation: 0,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(UserProfileScreen.routeName);
                      },
                      icon: Icon(Icons.person),
                      color: Theme.of(context).accentColor,
                    ),
                  ],
                ),
              ],
            ),
    );
  }
}
