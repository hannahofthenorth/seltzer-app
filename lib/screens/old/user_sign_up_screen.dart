// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../Providers/user.dart';

// class UserSignUpScreen extends StatefulWidget {
//   static const routeName = '/user-sign-up-screen';
//   final authToken;

//   UserSignUpScreen(this.authToken);
//   @override
//   _UserSignUpScreenState createState() => _UserSignUpScreenState();
// }

// class _UserSignUpScreenState extends State<UserSignUpScreen> {
//   var _form = GlobalKey<FormState>();
//   var _isLoading = false;
//   var _newUser = User(
//     firstName: '',
//     lastName: '',
//     userName: '',
//     userId: '',
//   );

//   void _saveForm() async {
//     setState(() {
//       _isLoading = true;
//     });

//     final isValid = _form.currentState.validate();
//     if (!isValid) {
//       return;
//     }
//     _form.currentState.save();
//     try {
//       await Provider.of<User>(context, listen: false).addNewUser(_newUser, widget.authToken);
//     } catch (error) {
//       await showDialog(
//         context: context,
//         builder: (ctx) => AlertDialog(
//           title: Text('ERROR'),
//           content: Text(
//               'There was an error creating your user. Please try again later'),
//           actions: <Widget>[
//             FlatButton(
//               onPressed: () {
//                 Navigator.of(ctx).pop();
//               },
//               child: Text('ok'),
//             )
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text('user sign up screen -- works'),
//     );
//   }
// }
