import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/main_drawer.dart';
import '../widgets/forms/add_brand_info_form.dart';
import '../screens/seltzer_feed_screen.dart';

class AddBrandInfoScreen extends StatefulWidget {
  static const routeName = '/add-brand-info';

  @override
  _AddBrandInfoScreenState createState() => _AddBrandInfoScreenState();
}

class _AddBrandInfoScreenState extends State<AddBrandInfoScreen> {
  var _isLoading = false;

  void _submitBrandInfoForm(
    String brand,
    String imageUrl,
  ) async {
    try {
      setState(() {
        _isLoading = true;
      });

      Firestore.instance.collection('brands').add({
        'brand': brand,
        'imageUrl': imageUrl,
      });
    } catch (error) {
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pushReplacementNamed(SeltzerFeedScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Brand Info'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AddBrandInfoForm(_isLoading, _submitBrandInfoForm),
      ),
      drawer: AppDrawer(),
    );
  }
}
