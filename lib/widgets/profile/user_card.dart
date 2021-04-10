import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './number_seltzers.dart';
import './follow_button.dart';
import '../../screens/edit_user_profile_screen.dart';

class UserCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String id;
  final String userUID;
  final String imageUrl;
  final bool isMe;
  final int totalRankedSeltzers = 5;

  UserCard(
    this.firstName,
    this.lastName,
    this.username,
    this.id,
    this.userUID,
    this.imageUrl,
    this.isMe,
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: isMe
                ? Stack(
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person),
                        radius: 30,
                      ),
                      Positioned(
                        bottom: -10,
                        right: -10,
                        child: CircleAvatar(
                          backgroundColor: Theme.of(context).accentColor,
                          child: IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(EditUserProfileScreen.routeName);
                            },
                          ),
                          radius: 12,
                        ),
                      ),
                    ],
                    overflow: Overflow.visible,
                  )
                : CircleAvatar(
                    child: Icon(Icons.person),
                    radius: 30,
                  ),
            title: Text(
              '$firstName $lastName',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            subtitle: Text(
              '$username',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
            trailing: FollowButton(false, userUID, id),
          ),
          const SizedBox(height: 8),
          NumberSeltzers(id),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
