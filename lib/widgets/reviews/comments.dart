import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Comments extends StatelessWidget {
  final String reviewedSeltzersID;

  Comments(this.reviewedSeltzersID);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('reviewedSeltzers')
          .document(reviewedSeltzersID)
          .collection('comment')
          .orderBy('timestamp')
          .snapshots(),
      builder: (ctx, commentSnapshots) {
        if (commentSnapshots.connectionState == ConnectionState.waiting) {
          return SizedBox();
        }
        if (commentSnapshots.data.documents.length == 0) {
          return SizedBox();
        }

        return ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: commentSnapshots.data.documents.length,
          itemBuilder: (ctx, i) {
            final commentDocs = commentSnapshots.data.documents[i];
            return StreamBuilder(
                stream: Firestore.instance
                    .collection('users')
                    .document(commentDocs['commentUid'])
                    .snapshots(),
                builder: (c, userSnapshot) {
                  if (userSnapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox();
                  }
                  return ListTile(
                    leading: Icon(Icons.format_color_fill),
                    title: Text(
                      userSnapshot.data['username'],
                      style: TextStyle(fontSize: 15),
                    ),
                    subtitle: Text(
                      commentDocs['comment'],
                      style: TextStyle(fontSize: 18),
                    ),
                  );
                });
          },
        );
      },
    );
  }
}
