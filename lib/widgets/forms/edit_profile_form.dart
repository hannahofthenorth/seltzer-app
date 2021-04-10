import 'package:flutter/material.dart';

class EditProfileForm extends StatefulWidget {
  final void Function(
    String firstName,
    String lastName,
    String username,
    String email,
  ) submitFn;

  EditProfileForm(this.submitFn);

  @override
  _EditProfileFormState createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final _formKey = GlobalKey<FormState>();
  var _userFirstName = 'firstName';
  var _userLastName = 'lastName';
  var _userUsername = 'username';
  var _userEmail = 'email@address';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userFirstName.trim(),
        _userLastName.trim(),
        _userUsername.trim(),
        _userEmail.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              key: ValueKey('firstName'),
              initialValue: _userFirstName,
              decoration: InputDecoration(
                labelText: 'firstName',
              ),
              validator: (value) {
                if (value.isEmpty || value.length < 2) {
                  return 'Please enter your name';
                }
                return null;
              },
              onSaved: (value) {
                _userFirstName = value;
              },
            ),
            TextFormField(
              key: ValueKey('lastName'),
              initialValue: _userLastName,
              decoration: InputDecoration(
                labelText: 'lastName',
              ),
              validator: (value) {
                if (value.isEmpty || value.length < 1) {
                  return 'Please enter your last name';
                }
                return null;
              },
              onSaved: (value) {
                _userLastName = value;
              },
            ),
            TextFormField(
              key: ValueKey('username'),
              initialValue: _userUsername,
              decoration: InputDecoration(
                labelText: 'username',
              ),
              validator: (value) {
                if (value.isEmpty || value.length < 4) {
                  return 'Please enter at least 4 characters for your username';
                }
                return null;
              },
              onSaved: (value) {
                _userUsername = value;
              },
            ),
            TextFormField(
              key: ValueKey('email'),
              initialValue: _userEmail,
              decoration: InputDecoration(
                labelText: 'email',
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value.isEmpty || !value.contains('@')) {
                  return 'Please enter an email address';
                }
                return null;
              },
              onSaved: (value) {
                _userEmail = value;
              },
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              child: Text('Save Changes'),
              onPressed: _trySubmit,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (states.contains(MaterialState.pressed))
                      return Theme.of(context).primaryColor.withOpacity(0.5);
                    return Theme.of(context)
                        .accentColor; // Use the component's default.
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
