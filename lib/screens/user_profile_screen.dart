import 'package:flutter/material.dart';

import '../widgets/profile/user_profile_info.dart';
import '../widgets/main_drawer.dart';
import '../widgets/profile/profile_screen_arguments.dart';
import '../screens/add_seltzer_screen.dart';
import '../screens/seltzer_feed_screen.dart';

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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: UserProfileInfo(args.profileUid),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: RaisedButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddSeltzerScreen.routeName);
                  },
                  icon: Icon(Icons.add),
                  label: Text('Rate a new Seltzer'),
                  color: Theme.of(context).accentColor,
                  elevation: 0,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
              IconButton(
                icon: Icon(Icons.list),
                color: Theme.of(context).accentColor,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(SeltzerFeedScreen.routeName);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
