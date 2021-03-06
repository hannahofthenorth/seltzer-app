import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NumberSeltzers extends StatelessWidget {
  final String id;
  NumberSeltzers(this.id);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('reviewedSeltzers')
          .where('reviewerId', isEqualTo: id)
          .snapshots(),
      builder: (ctx, seltzerSnapshot) {
        if (seltzerSnapshot.connectionState == ConnectionState.waiting) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: SizedBox()),
              Icon(Icons.bubble_chart),
              Text('seltzers reviewed and counting!'),
              Expanded(child: SizedBox()),
            ],
          );
        }
        final seltzerTotal = seltzerSnapshot.data.documents.length;
        if (seltzerTotal == 1) {
          return Text('$seltzerTotal seltzer reviewed and counting!');
        }
        return Text('$seltzerTotal seltzers reviewed and counting!');
      },
    );
  }
}
