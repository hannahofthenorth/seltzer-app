import 'package:flutter/foundation.dart';

class Seltzer with ChangeNotifier {
  final String id;
  final String brand;
  final String flavor;
  final double rating;
  final String review;

  Seltzer(
      {@required this.id,
      @required this.brand,
      @required this.flavor,
      @required this.rating,
      this.review});
}
