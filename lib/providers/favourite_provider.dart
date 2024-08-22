import 'package:flutter/material.dart';

class FavouriteProvider extends ChangeNotifier {
  // state
  final Map<String, bool> _favourite = {};

  // getter

  Map<String, bool> get favorite => _favourite;

  // toggle favourite
  void toggleFavourite(String productId) {
    if (_favourite.containsKey(productId)) {
// if product id already cotains, remove from favourite map
      _favourite[productId] = !_favourite[productId]!;
    } else {
      // add favourite list
      _favourite[productId] = true;
    }
    notifyListeners();
  }

  // method to check whether Favourite or not
  bool isFavourite(String productId) {
    return _favourite[productId] ?? false;
  }
}
