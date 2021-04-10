import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './reviewed_seltzer.dart';

class ActivityFeed extends StatelessWidget {
  final List<dynamic> following;
  final ScrollController _scrollController = ScrollController();

  ActivityFeed(this.following);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('reviewedSeltzers')
            .where('reviewerId', whereIn: following)
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (ctx, seltzerShapshot) {
          if (seltzerShapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.teal,
              ),
            );
          }
          final reviewedSeltzerDocs = seltzerShapshot.data.documents;
          return PrimaryScrollController(
            controller: _scrollController,
            child: ListView.builder(
              primary: true,
              itemCount: reviewedSeltzerDocs.length,
              itemBuilder: (ctx, i) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    ReviewedSeltzer(
                        firstName: reviewedSeltzerDocs[i]['reviewerFirstName'],
                        lastName: reviewedSeltzerDocs[i]['reviewerLastName'],
                        brand: reviewedSeltzerDocs[i]['brandName'],
                        flavor: reviewedSeltzerDocs[i]['flavor'],
                        rating: reviewedSeltzerDocs[i]['rating'],
                        id: reviewedSeltzerDocs[i].documentID)
                  ],
                ),
              ),
            ),
          );
        });
  }
}
