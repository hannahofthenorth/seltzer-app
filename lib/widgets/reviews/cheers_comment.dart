import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './cheers.dart';
import './comments.dart';
import './add_comment.dart';

class CheersComment extends StatefulWidget {
  final String reviewedSeltzerId;

  CheersComment(this.reviewedSeltzerId);

  @override
  _CheersCommentState createState() => _CheersCommentState();
}

class _CheersCommentState extends State<CheersComment> {
  String _comment;
  bool addAComment = false;

  void addComment() {
    addAComment = !addAComment;

    setState(() {});

    return;
  }

  void sendComment(uid) {
    Firestore.instance
        .collection('reviewedSeltzers')
        .document(widget.reviewedSeltzerId)
        .collection('comment')
        .add({
      'commentUid': uid,
      'comment': _comment,
      'timestamp': Timestamp.now()
    });

    addAComment = !addAComment;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                    child: const Text('CHEERS'),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor)),
                const SizedBox(width: 8),
                TextButton(
                    child: const Text('COMMENT'),
                    onPressed: () {},
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor)),
                const SizedBox(width: 8),
              ],
            );
          }
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Cheers(widget.reviewedSeltzerId, futureSnapshot.data.uid),
                  const SizedBox(width: 8),
                  TextButton(
                    child: const Text('COMMENT'),
                    onPressed: () {
                      AddComment.globalKey.currentState.addAComment();
                    },
                    style: TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
              Comments(widget.reviewedSeltzerId),
              AddComment(widget.reviewedSeltzerId),
              // addAComment
              //     ? AnimatedContainer(
              //         duration: Duration(milliseconds: 300),
              //         height: addAComment ? 50 : 10,
              //         constraints: BoxConstraints(minHeight: 50),
              //         child: Row(
              //           children: [
              //             Expanded(
              //               child: TextField(
              //                 decoration: InputDecoration(
              //                     labelText: 'Enter a comment!'),
              //                 onChanged: (value) {
              //                   _comment = value;
              //                 },
              //               ),
              //             ),
              //             IconButton(
              //               icon: Icon(Icons.send),
              //               onPressed: () =>
              //                   sendComment(futureSnapshot.data.uid),
              //               color: Theme.of(context).accentColor,
              //             ),
              //           ],
              //         ),
              //       )
              //     : SizedBox()
            ],
          );
        });
  }
}
