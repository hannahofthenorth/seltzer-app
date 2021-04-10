import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './reviews/bubbles.dart';
import './reviews/cheers_comment.dart';

class ReviewedSeltzer extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String brand;
  final String flavor;
  final double rating;
  final String id;

  ReviewedSeltzer({
    @required this.firstName,
    @required this.lastName,
    @required this.brand,
    @required this.flavor,
    @required this.rating,
    @required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 8),
            Text('$firstName $lastName just cracked open a cold one!'),
            SizedBox(height: 4),
            ListTile(
              leading: StreamBuilder(
                  stream: Firestore.instance.collection('brands').snapshots(),
                  builder: (context, brandsSnapshot) {
                    if (brandsSnapshot.data == null) {
                      return Icon(
                        Icons.local_drink,
                      );
                    }
                    final brandsDocs = brandsSnapshot.data.documents;
                    var _brandsList = [];
                    for (var i = 0; i < brandsDocs.length; i++) {
                      _brandsList.add(brandsDocs[i]['brand']);
                    }
                    if (!_brandsList.contains(brand)) {
                      return Icon(Icons.local_drink);
                    } else {
                      return Container(
                        width: 75,
                        height: 75,
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Image.network(brandsDocs[_brandsList
                              .indexWhere((br) => br == brand)]['imageUrl']),
                        ),
                      );
                    }
                  }),
              title: Text(
                brand,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: Text(
                flavor,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 15,
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(width: 10),
                  Bubbles(rating, 35.0),
                  const SizedBox(width: 8),
                  Text('$rating bubbles'),
                ],
              ),
            ),
            CheersComment(id),
          ],
        ),
      ),
    );
  }
}
