import 'package:flutter/foundation.dart';

class Brand with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;

  Brand({
    @required this.id,
    @required this.name,
    @required this.imageUrl,
  });
}
