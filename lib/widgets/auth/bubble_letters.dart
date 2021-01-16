import 'package:flutter/material.dart';

class BubbleLetters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueGrey[100],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(width: 5),
                CircleAvatar(
                  child: Text('S'),
                ),
                CircleAvatar(
                  child: Text('E'),
                ),
                CircleAvatar(
                  child: Text('L'),
                ),
                CircleAvatar(
                  child: Text('T'),
                ),
                CircleAvatar(
                  child: Text('Z'),
                ),
                CircleAvatar(
                  child: Text('E'),
                ),
                CircleAvatar(
                  child: Text('R'),
                ),
                SizedBox(width: 15),
              ],
            ),
            SizedBox(height: 10),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 15),
                  CircleAvatar(
                    child: Text('R'),
                  ),
                  CircleAvatar(
                    child: Text('A'),
                  ),
                  CircleAvatar(
                    child: Text('T'),
                  ),
                  CircleAvatar(
                    child: Text('I'),
                  ),
                  CircleAvatar(
                    child: Text('N'),
                  ),
                  CircleAvatar(
                    child: Text('G'),
                  ),
                  CircleAvatar(
                    child: Text('S'),
                  ),
                  SizedBox(width: 5),
                ]),
          ],
        ),
      ),
    );
  }
}
