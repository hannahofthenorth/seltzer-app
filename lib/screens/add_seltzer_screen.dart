import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/seltzer.dart';
import './seltzer_feed_screen.dart';
import '../bubble_icons.dart';
import '../widgets/reviews/bubbles.dart';

class AddSeltzerScreen extends StatefulWidget {
  static const routeName = '/add-seltzer';
  @override
  _AddSeltzerScreenState createState() => _AddSeltzerScreenState();
}

class _AddSeltzerScreenState extends State<AddSeltzerScreen> {
  final _brandFocusNode = FocusNode();
  final _flavorFocusNode = FocusNode();
  final _reviewFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  double _currentSliderValue = 0;
  var _newSeltzer = Seltzer(
    id: null,
    brand: '',
    flavor: '',
    rating: null,
    review: '',
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _brandFocusNode.dispose();
    _flavorFocusNode.dispose();
    _reviewFocusNode.dispose();
    super.dispose();
  }

  void _saveForm() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    final userData =
        await Firestore.instance.collection('users').document(user.uid).get();
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();

    await Firestore.instance.collection('reviewedSeltzers').add({
      'brandName': _newSeltzer.brand,
      'flavor': _newSeltzer.flavor,
      'rating': _newSeltzer.rating == null ? 0 : _newSeltzer.rating, 
      'review': _newSeltzer.review,
      'timestamp': Timestamp.now(),
      'reviewerId': user.uid,
      'reviewerUsername': userData['username'],
      'reviewerFirstName': userData['firstName'],
      'reviewerLastName': userData['lastName']
    });
    Navigator.of(context).pushReplacementNamed(SeltzerFeedScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Seltzer Rating'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Seltzer Brand',
                          ),
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_flavorFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a brand';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newSeltzer = Seltzer(
                                brand: value,
                                flavor: _newSeltzer.flavor,
                                rating: _newSeltzer.rating,
                                id: null,
                                review: _newSeltzer.review);
                          },
                        ),
                      ),
                      Card(
                        child: TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Seltzer Flavor'),
                          focusNode: _flavorFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a flavor';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _newSeltzer = Seltzer(
                                brand: _newSeltzer.brand,
                                flavor: value,
                                rating: _newSeltzer.rating,
                                id: null,
                                review: _newSeltzer.review);
                          },
                        ),
                      ),
                      Divider(),
                      Card(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Leave a review (optional)'),
                          maxLines: 5,
                          keyboardType: TextInputType.multiline,
                          focusNode: _reviewFocusNode,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (_) {},
                          validator: (value) {
                            return null;
                          },
                          onSaved: (value) {
                            _newSeltzer = Seltzer(
                              brand: _newSeltzer.brand,
                              flavor: _newSeltzer.flavor,
                              rating: _newSeltzer.rating,
                              id: null,
                              review: value,
                            );
                          },
                        ),
                      ),
                      Divider(),
                      Card(
                        child: Column(
                          children: [
                            Text('Rate the Seltzer!'),
                            SizedBox(height: 32),
                            Container(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 12.0,
                                    ),
                                    valueIndicatorShape:
                                        PaddleSliderValueIndicatorShape()),
                                child: Slider(
                                  value: _currentSliderValue,
                                  min: 0,
                                  max: 5,
                                  divisions: 20,
                                  label: _currentSliderValue.toString(),
                                  onChanged: (double value) {
                                    setState(() {
                                      _currentSliderValue = value;
                                      _newSeltzer = Seltzer(
                                          brand: _newSeltzer.brand,
                                          flavor: _newSeltzer.flavor,
                                          rating: value,
                                          id: null,
                                          review: _newSeltzer.review);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          RaisedButton(
            onPressed: () => _saveForm(),
            // icon: Icon(BubbleIcons.filled_bubbles),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(height: 50, child: Bubbles(_currentSliderValue, 40)),
                Text(
                  'Rate this Seltzer',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            color: Theme.of(context).accentColor,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }
}
