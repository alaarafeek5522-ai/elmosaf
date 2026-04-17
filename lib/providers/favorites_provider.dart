import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:elmosaf/models/product_model.dart';

class FavoritesProvider extends ChangeNotifier {
  List<Product> _favorites = [];
  
  List<Product> get favorites => _favorites;

  bool isFavorite(Product product) {
    return _favorites.any((p) => p.id == product.id);
  }

  void toggleFavorite(Product product) {
    if (isFavorite(product)) {
      _favorites.removeWhere((p) => p.id == product.id);
    } else {
      _favorites.add(product);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> jsonList = _favorites.map((p) => json.encode(p.toJson())).toList();
    await prefs.setStringList('favorites', jsonList);
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? jsonList = prefs.getStringList('favorites');
    
    if (jsonList != null) {
      _favorites = jsonList.map((jsonStr) {
        return Product.fromJson(json.decode(jsonStr));
      }).toList();
      notifyListeners();
    }
  }

  void clearFavorites() {
    _favorites.clear();
    _saveFavorites();
    notifyListeners();
  }
}
