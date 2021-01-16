import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './reviewed_seltzer.dart';

class ActivityFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Firestore.instance
            .collection('reviewedSeltzers')
            .orderBy(
              'timestamp',
              descending: true,
            )
            .snapshots(),
        builder: (ctx, seltzerShapshot) {
          if (seltzerShapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final reviewedSeltzerDocs = seltzerShapshot.data.documents;
          return ListView.builder(
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
          );
        });
  }
}
