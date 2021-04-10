import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/activity_feed.dart';
import '../widgets/main_drawer.dart';
import '../widgets/profile/profile_screen_arguments.dart';
import '../widgets/profile/view_profile.dart';
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
                setState(() {});
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
                  child: FutureBuilder(
                      future: FirebaseAuth.instance.currentUser(),
                      builder: (ctx, futureSnapshot) {
                        if (futureSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return StreamBuilder(
                            stream: Firestore.instance
                                .collection('users')
                                .document(futureSnapshot.data.uid)
                                .collection('following')
                                .snapshots()
                                .map((QuerySnapshot snapshot) => snapshot
                                    .documents
                                    .map((DocumentSnapshot doc) =>
                                        doc.data['UID'])
                                    .toList()),
                            builder: (c, followingSnapshot) {
                              if (followingSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }

                              List<dynamic> followingUIDs =
                                  followingSnapshot.data.toList();
                              followingUIDs.insert(0, futureSnapshot.data.uid);

                              return ActivityFeed(followingUIDs);
                            });
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
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
                    ViewProfile(),
                  ],
                ),
              ],
            ),
    );
  }
}
