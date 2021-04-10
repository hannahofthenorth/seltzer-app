import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Cheers extends StatelessWidget {
  final String reviewedSeltzerId;
  final String loggedInUID;

  Cheers(this.reviewedSeltzerId, this.loggedInUID);

  void addCheers() async {
    Firestore.instance
        .collection('reviewedSeltzers')
        .document(reviewedSeltzerId)
        .collection('cheers')
        .add({'cheersUid': loggedInUID});
  }

  void alreadyCheers() {
    print('duplicate cheers!');
    return;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('reviewedSeltzers')
          .document(reviewedSeltzerId)
          .collection('cheers')
          .snapshots()
          .map((QuerySnapshot snapshot) => snapshot.documents
              .map((DocumentSnapshot doc) => doc.data['cheersUid'])
              .toList()),
      builder: (ctx, cheersSnapshot) {
        if (cheersSnapshot.connectionState == ConnectionState.waiting) {
          return Expanded(
            child: Row(
              children: <Widget>[
                Expanded(child: SizedBox()),
                TextButton(
                  child: Text('CHEERS'),
                  onPressed: () {},
                  style: TextButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                )
              ],
            ),
          );
        }

        final cheersDocs = cheersSnapshot.data.toList();

        return Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: [
                    SizedBox(width: 15),
                    (cheersDocs.length > 0)
                        ? Text('${cheersDocs.length} cheers!')
                        : SizedBox(),
                  ],
                ),
              ),
              TextButton(
                child: Text('CHEERS'),
                onPressed: cheersDocs.contains(loggedInUID)
                    ? alreadyCheers
                    : addCheers,
                style: cheersDocs.contains(loggedInUID)
                    ? TextButton.styleFrom(
                        primary: Theme.of(context).accentColor)
                    : TextButton.styleFrom(
                        primary: Theme.of(context).primaryColor),
              ),
            ],
          ),
        );
      },
    );
  }
}
