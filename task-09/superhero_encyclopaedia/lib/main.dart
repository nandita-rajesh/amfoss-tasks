import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:superhero_encyclopaedia/screens/hero_list_screen.dart';
import 'package:superhero_encyclopaedia/screens/hero_detail_screen.dart';
import 'package:superhero_encyclopaedia/screens/favorites_screen.dart';
import 'package:superhero_encyclopaedia/services/favorites_manager.dart';
import 'package:superhero_encyclopaedia/models/hero.dart' as custom_hero;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FavoritesManager(),
        ),
      ],
      child: MaterialApp(
        title: 'Superhero Encyclopedia',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HeroListScreen(),
        routes: {
          '/favorites': (context) => FavoritesScreen(),
          '/hero-detail': (context) {
            final hero = ModalRoute.of(context)!.settings.arguments as custom_hero.Hero;
            return HeroDetailScreen(hero: hero);
          },
        },
      ),
    );
  }
}
