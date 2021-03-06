import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../reviewed_seltzer.dart';

class UserActivity extends StatelessWidget {
  final String id;

  UserActivity(this.id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('reviewedSeltzers')
          .where('reviewerId', isEqualTo: id)
          .orderBy('timestamp')
          .snapshots(),
      builder: (ctx, reviewsSnapshot) {
        if (reviewsSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.yellow,
            ),
          );
        }
        final reviewsDocs = reviewsSnapshot.data.documents;
        print('************** reviews length **************');
        print(reviewsDocs);
        if (reviewsDocs.length == 0) {
          return Text('user has no reviews');
        }
        return ListView.builder(
          reverse: true,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: reviewsDocs.length,
          itemBuilder: (c, index) => ReviewedSeltzer(
              firstName: reviewsDocs[index]['reviewerFirstName'],
              lastName: reviewsDocs[index]['reviewerLastName'],
              brand: reviewsDocs[index]['brandName'],
              flavor: reviewsDocs[index]['flavor'],
              rating: reviewsDocs[index]['rating'],
              id: reviewsDocs[index].documentID),
        );
      },
    );
  }
}
