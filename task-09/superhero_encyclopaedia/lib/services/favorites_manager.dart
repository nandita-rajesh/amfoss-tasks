import 'package:flutter/material.dart';
import 'package:superhero_encyclopaedia/models/hero.dart' as custom_hero; // Add a prefix


class FavoritesManager extends ChangeNotifier {
  final List<custom_hero.Hero> _favorites = [];

  List<custom_hero.Hero> get favorites => _favorites;

  bool isFavorite(custom_hero.Hero hero) {
    return _favorites.contains(hero);
  }

  void addFavorite(custom_hero.Hero hero) {
    if (!_favorites.contains(hero)) {
      _favorites.add(hero);
      notifyListeners();
    }
  }

  void removeFavorite(custom_hero.Hero hero) {
    if (_favorites.contains(hero)) {
      _favorites.remove(hero);
      notifyListeners();
    }
  }
}
