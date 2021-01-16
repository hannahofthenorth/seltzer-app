import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './user_card.dart';
import './top_three_card.dart';
import './user_activity.dart';

class UserProfileInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: Firestore.instance
                .collection('users')
                .where('userId', isEqualTo: futureSnapshot.data.uid)
                .snapshots(),
            builder: (c, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              final userDocs = userSnapshot.data.documents;
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    UserCard(
                      userDocs[0]['firstName'],
                      userDocs[0]['lastName'],
                      userDocs[0]['username'],
                      userDocs[0]['userId'],
                      '',
                    ),
                    TopThreeCard(),
                    UserActivity(futureSnapshot.data.uid),
                  ],
                ),
              );
            });
      },
    );
  }
}
