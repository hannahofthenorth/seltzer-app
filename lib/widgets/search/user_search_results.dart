import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../screens/user_profile_screen.dart';
import '../../widgets/profile/profile_screen_arguments.dart';

class UserSearchResults extends StatelessWidget {
  final String searchString;

  UserSearchResults(this.searchString);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance
          .collection('users')
          .where('username', isGreaterThanOrEqualTo: searchString)
          .where('username', isLessThan: searchString + 'z')
          .snapshots(),
      builder: (ctx, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final searchMatchUsersDocs = userSnapshot.data.documents;

        return searchMatchUsersDocs.length == 0
            ? Text('No results found')
            : ListView.builder(
                itemCount: searchMatchUsersDocs.length,
                itemBuilder: (c, index) => InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacementNamed(
                        UserProfileScreen.routeName,
                        arguments: ProfileScreenArguments(
                            searchMatchUsersDocs[index]['userId']));
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    title: Text(
                        '${searchMatchUsersDocs[index]['firstName']} ${searchMatchUsersDocs[index]['lastName']}'),
                    subtitle:
                        Text('${searchMatchUsersDocs[index]['username']}'),
                  ),
                ),
              );
      },
    );
  }
}
