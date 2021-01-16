import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './number_seltzers.dart';

class UserCard extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String username;
  final String id;
  final String imageUrl;
  final int totalRankedSeltzers = 5;

  UserCard(
    this.firstName,
    this.lastName,
    this.username,
    this.id,
    this.imageUrl,
  );
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
              radius: 30,
            ),
            title: Text('$firstName $lastName'),
            subtitle: Text('$username'),
          ),
          const SizedBox(height: 8),
          NumberSeltzers(id),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
