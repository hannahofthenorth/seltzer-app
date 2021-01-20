import 'package:flutter/material.dart';

import '../widgets/profile/user_profile_info.dart';
import '../widgets/reviewed_seltzer.dart';
import '../widgets/main_drawer.dart';
import '../widgets/profile/profile_screen_arguments.dart';
import '../widgets/profile/user_activity.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile';

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final ProfileScreenArguments args =
        ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile Screen'),
      ),
      drawer: AppDrawer(),
      // TODO: I want to wrap this with a column somehow so I can have a bottom navigaiton
      // bar at the bottom of this screen
      body: SingleChildScrollView(
        child: Center(
          child: UserProfileInfo(args.profileUid),
        ),
      ),
    );
  }
}
