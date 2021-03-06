import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import './widgets/profile/profile_screen_arguments.dart';
import './screens/seltzer_feed_screen.dart';
import './screens/add_seltzer_screen.dart';
import './screens/add_brand_info_screen.dart';
import './screens/auth_screen.dart';
import './screens/splash_screen.dart';
import './screens/user_profile_screen.dart';
import './screens/edit_user_profile_screen.dart';
import './screens/search_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Seltzer Ratings",
        theme: ThemeData(
          primaryColor: Colors.blueGrey[700],
          primaryColorDark: Colors.blueGrey[900],
          accentColor: Colors.teal[100],
          cardColor: Colors.grey[100],
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (ctx, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return SplashScreen();
            }
            if (userSnapshot.hasData) {
              // print('logged in');
              return SeltzerFeedScreen();
            }
            // print('logged out');
            return AuthScreen();
          },
        ),
        onGenerateRoute: (settings) {
          if (settings.name == UserProfileScreen.routeName) {
            final ProfileScreenArguments args = settings.arguments;
          }
        },
        routes: {
          SeltzerFeedScreen.routeName: (ctx) => SeltzerFeedScreen(),
          AddSeltzerScreen.routeName: (ctx) => AddSeltzerScreen(),
          AddBrandInfoScreen.routeName: (ctx) => AddBrandInfoScreen(),
          UserProfileScreen.routeName: (ctx) => UserProfileScreen(),
          EditUserProfileScreen.routeName: (ctx) => EditUserProfileScreen(),
          SearchScreen.routeName: (ctx) => SearchScreen(),
          // UserSignUpScreen.routeName: (ctx) => UserSignUpScreen(),
        });
  }
}
