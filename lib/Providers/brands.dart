import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/brand.dart';

class Brands with ChangeNotifier {
  List<Brand> _brands = [];

  final String authToken;

  Brands(this.authToken, this._brands);

  List<Brand> get items {
    return [..._brands];
  }

  Brand findById(String id) {
    if (_brands == []) {
      return null; // TODO: remove this and fix logic that causes findById to be called before fetchAndSetBrands completes
    }
    return _brands.firstWhere((brand) => brand.id == id);
  }

  Brand findByName(String name) {
    return _brands.firstWhere((brand) => brand.name == name);
  }

// TODO: don't fetch and set all brands, only the ones needed to render reviewed seltzer cards
  Future<void> fetchAndSetBrands() async {
    final url =
        'https://seltzer-rating-app-default-rtdb.firebaseio.com/seltzerBrands.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Brand> loadedBrands = [];
      extractedData.forEach((brandId, brandData) {
        loadedBrands.add(Brand(
          id: brandId,
          name: brandData['name'],
          imageUrl: brandData['imageUrl'],
        ));
      });
      _brands = loadedBrands;
      notifyListeners();
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> addBrand(Brand brand) async {
    final url =
        'https://seltzer-rating-app-default-rtdb.firebaseio.com/seltzerBrands.json?auth=$authToken';
    try {
      final response = await http.post(url,
          body: json.encode({
            'name': brand.name,
            'imageUrl': brand.imageUrl,
          }));
      final newBrand = Brand(
          name: brand.name,
          imageUrl: brand.imageUrl,
          id: json.decode(response.body)['name']);
      _brands.add(newBrand);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }
}
