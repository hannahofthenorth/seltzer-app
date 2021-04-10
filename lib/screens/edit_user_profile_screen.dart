import 'package:flutter/material.dart';

import '../widgets/forms/edit_profile_form.dart';

class EditUserProfileScreen extends StatefulWidget {
  static const routeName = '/edit-user-profile';
  @override
  _EditUserProfileScreenState createState() => _EditUserProfileScreenState();
}

class _EditUserProfileScreenState extends State<EditUserProfileScreen> {
  void _submitEditedProfile(
    String firstName,
    String lastName,
    String username,
    String email,
  ) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit your profile'),
        // actions: <Widget>[IconButton(icon: Icon(Icons.save), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 8),
            CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white30,
              ),
              radius: 50.0,
            ),
            const SizedBox(height: 8),
            EditProfileForm(_submitEditedProfile),
          ],
        ),
      ),
    );
  }
}
