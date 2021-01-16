import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/seltzer.dart';

class Seltzers with ChangeNotifier {
  List<Seltzer> _seltzers = [];

  final String authToken;
  final String userId;

  Seltzers(this.authToken, this.userId, this._seltzers);

  List<Seltzer> get items {
    return [..._seltzers];
  }

  Seltzer findById(String id) {
    return _seltzers.firstWhere((seltzer) => seltzer.id == id);
  }

  Future<void> fetchAndSetSeltzers() async {
    final url =
        'https://seltzer-rating-app-default-rtdb.firebaseio.com/reviewedSeltzers.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Seltzer> loadedSeltzers = [];
      extractedData.forEach((seltzerId, seltzerData) {
        loadedSeltzers.add(Seltzer(
          id: seltzerId,
          brand: seltzerData['brand'],
          flavor: seltzerData['flavor'],
          rating: seltzerData['rating'],
        ));
      });
      _seltzers = loadedSeltzers;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addSeltzer(Seltzer seltzer) async {
    final url =
        'https://seltzer-rating-app-default-rtdb.firebaseio.com/reviewedSeltzers.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'brand': seltzer.brand,
            'flavor': seltzer.flavor,
            'rating': seltzer.rating,
          }));
      final newSeltzer = Seltzer(
        brand: seltzer.brand,
        flavor: seltzer.flavor,
        rating: seltzer.rating,
        id: json.decode(response.body)['name'],
      );
      _seltzers.insert(0, newSeltzer);
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }
}
