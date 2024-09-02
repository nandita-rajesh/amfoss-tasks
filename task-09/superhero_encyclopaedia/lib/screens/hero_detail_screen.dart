import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superhero_encyclopaedia/models/hero.dart' as custom_hero;
import 'package:superhero_encyclopaedia/services/favorites_manager.dart';

class HeroDetailScreen extends StatelessWidget {
  final custom_hero.Hero hero; 

  HeroDetailScreen({required this.hero});

  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);

    bool isFavorite = favoritesManager.isFavorite(hero);

    return Scaffold(
      appBar: AppBar(
        title: Text(hero.name),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : Colors.grey,
            ),
            onPressed: () {
              if (isFavorite) {
                favoritesManager.removeFavorite(hero);
              } else {
                favoritesManager.addFavorite(hero);
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              hero.images['lg'] != null
                  ? Image.network(hero.images['lg']!)
                  : Container(height: 200, color: Colors.grey, child: Center(child: Text('No Image Available'))),
              SizedBox(height: 16.0),
              
              Text(
                hero.name,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              SizedBox(height: 16.0),

              Text(
                'Superpowers:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...hero.powerstats.entries.map((entry) => Text(
                '${entry.key}: ${entry.value}',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
              SizedBox(height: 16.0),

              Text(
                'Appearance:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...hero.appearance.entries.map((entry) => Text(
                '${entry.key}: ${entry.value}',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
              SizedBox(height: 16.0),

              Text(
                'Biography:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...hero.biography.entries.map((entry) => Text(
                '${entry.key}: ${entry.value}',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
              SizedBox(height: 16.0),

              Text(
                'Work:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...hero.work.entries.map((entry) => Text(
                '${entry.key}: ${entry.value}',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
              SizedBox(height: 16.0),

              Text(
                'Connections:',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              ...hero.connections.entries.map((entry) => Text(
                '${entry.key}: ${entry.value}',
                style: Theme.of(context).textTheme.bodyLarge,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
