import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TopThreeCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Text('Top 3 Seltzers'),
                Text('Seltzer #1'),
                Text('Seltzer #2'),
                Text('Seltzer #3'),
              ],
            ),
            Column(
              children: <Widget>[
                Text('Top 3 Brands'),
                Text('Brand #1'),
                Text('Seltzer #2'),
                Text('Seltzer #3'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
