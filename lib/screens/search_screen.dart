import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/main_drawer.dart';
import '../widgets/search/user_search_results.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = '/search-screen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var _searchString = '';
  final _controller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      drawer: AppDrawer(),
      body: Column(
        children: [
          TextField(
            autocorrect: false,
            decoration: InputDecoration(labelText: 'Enter a username'),
            onChanged: (value) {
              setState(() {
                _searchString = value;
              });
            },
          ),
          Expanded(child: UserSearchResults(_searchString)),
        ],
      ),
    );
  }
}
