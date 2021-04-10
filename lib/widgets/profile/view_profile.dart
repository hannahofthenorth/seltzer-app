import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../screens/user_profile_screen.dart';
import '../../widgets/profile/profile_screen_arguments.dart';

class ViewProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseAuth.instance.currentUser(),
      builder: (ctx, futureSnapshot) {
        if (futureSnapshot.connectionState == ConnectionState.waiting) {
          print('waiting');
          return SizedBox();
        }
        return IconButton(
            icon: Icon(Icons.person),
            color: Theme.of(context).accentColor,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(
                  UserProfileScreen.routeName,
                  arguments: ProfileScreenArguments(futureSnapshot.data.uid));
            });
      },
    );
  }
}
