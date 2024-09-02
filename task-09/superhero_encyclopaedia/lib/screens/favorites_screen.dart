import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superhero_encyclopaedia/services/favorites_manager.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoritesManager.favorites.length,
        itemBuilder: (context, index) {
          final hero = favoritesManager.favorites[index];
          return ListTile(
            title: Text(hero.name),
            leading: hero.images['sm'] != null ? Image.network(hero.images['sm']!) : null,
            onTap: () {
              Navigator.pushNamed(
                context,
                '/hero-detail',
                arguments: hero,
              );
            },
          );
        },
      ),
    );
  }
}
