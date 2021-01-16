import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CheersComment extends StatefulWidget {
  final String reviewedSeltzerId;

  CheersComment(this.reviewedSeltzerId);

  @override
  _CheersCommentState createState() => _CheersCommentState();
}

class _CheersCommentState extends State<CheersComment> {
  String _comment;

  void addCheers() async {
    print('cheers!');
    final user = await FirebaseAuth.instance.currentUser();
    Firestore.instance
        .collection('reviewedSeltzers')
        .document(widget.reviewedSeltzerId)
        .collection('cheers')
        .add({'cheersUid': user.uid});
  }

  void addComment() async {
    print('comment added!');
    final user = await FirebaseAuth.instance.currentUser();
    return;
    Firestore.instance
        .collection('reviewedSeltzers')
        .document(widget.reviewedSeltzerId)
        .collection('comment')
        .add({
      'commentUid': user.uid,
      'comment': _comment,
      'timestamp': Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              TextButton(
                child: const Text('CHEERS'),
                onPressed: addCheers,
              ),
              const SizedBox(width: 8),
              TextButton(
                child: const Text('COMMENT'),
                onPressed: addComment,
              ),
              const SizedBox(width: 8),
            ],
          );
        });
  }
}
