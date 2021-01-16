import 'package:flutter/material.dart';

import '../widgets/profile/user_profile_info.dart';
import '../widgets/reviewed_seltzer.dart';
import '../widgets/main_drawer.dart';
import '../widgets/profile/user_activity.dart';

class UserProfileScreen extends StatefulWidget {
  static const routeName = '/user-profile';
  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile Screen'),
      ),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: Center
          (child: UserProfileInfo(),
        ),
      ),
    );
  }
}
