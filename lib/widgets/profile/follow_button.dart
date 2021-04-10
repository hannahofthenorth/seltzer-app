import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FollowButton extends StatefulWidget {
  final bool isFollowing;
  final String userUID;
  final String profileUID;

  FollowButton(this.isFollowing, this.userUID, this.profileUID);

  @override
  _FollowButtonState createState() => _FollowButtonState();
}

class _FollowButtonState extends State<FollowButton> {
  void followUser() {
    Firestore.instance
        .collection('users')
        .document(widget.userUID) // UID of the logged in user
        .collection('following')
        .add({'UID': widget.profileUID}); // UID of the profile being used
    Firestore.instance
        .collection('users')
        .document(widget.profileUID)
        .collection('followers')
        .add({'UID': widget.userUID});
    return;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .document(widget.profileUID)
          .collection('followers')
          .snapshots()
          .map((QuerySnapshot snapshot) => snapshot.documents
              .map((DocumentSnapshot doc) => doc.data['UID'])
              .toList()),
      builder: (ctx, followersSnapshot) {
        if (followersSnapshot.connectionState == ConnectionState.waiting) {
          return Expanded(child: SizedBox(width: 8));
        }
        final followers = followersSnapshot.data.toList();

        return followers.contains(widget.userUID)
            ? Expanded(child: SizedBox(width: 8))
            : IconButton(
                icon: Icon(Icons.follow_the_signs),
                onPressed: followUser,
              );
      },
    );
  }
}
