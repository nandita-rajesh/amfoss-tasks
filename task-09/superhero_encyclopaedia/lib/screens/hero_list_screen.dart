import 'package:flutter/material.dart';
import 'package:superhero_encyclopaedia/models/hero.dart' as custom_hero; 
import 'package:superhero_encyclopaedia/services/hero_service.dart';
import 'package:provider/provider.dart';
import 'package:superhero_encyclopaedia/services/favorites_manager.dart';

class HeroListScreen extends StatefulWidget {
  @override
  _HeroListScreenState createState() => _HeroListScreenState();
}

class _HeroListScreenState extends State<HeroListScreen> {
  List<custom_hero.Hero> heroes = [];
  List<custom_hero.Hero> filteredHeroes = [];
  TextEditingController searchController = TextEditingController();
  String selectedType = 'All';

  @override
  void initState() {
    super.initState();
    _fetchHeroes();
    searchController.addListener(() {
      filterHeroes();
    });
  }

  void _fetchHeroes() async {
    try {
      List<custom_hero.Hero> fetchedHeroes = await HeroService.getHeroes();
      setState(() {
        heroes = fetchedHeroes;
        filteredHeroes = heroes;
        print('Heroes fetched: ${heroes.length}');
      });
    } catch (e) {
      print('Error fetching heroes: $e'); 
    }
  }

  void filterHeroes() {
    String query = searchController.text.toLowerCase();
    setState(() {
      filteredHeroes = heroes.where((hero) {
        bool matchesQuery = hero.name.toLowerCase().contains(query);
        bool matchesType = selectedType == 'All' || hero.type == selectedType;
        print('Filtering: ${hero.name}, matchesQuery: $matchesQuery, matchesType: $matchesType'); 
        return matchesQuery && matchesType;
      }).toList();
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favoritesManager = Provider.of<FavoritesManager>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Superhero Encyclopedia'),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.pushNamed(context, '/favorites');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search Heroes...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: DropdownButton<String>(
              value: selectedType,
              items: ['All', 'Hero', 'Villain', 'Anti-Hero']
                  .map((type) => DropdownMenuItem<String>(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  selectedType = value ?? 'All';
                  print('Selected type: $selectedType'); 
                  filterHeroes();
                });
              },
              isExpanded: true,
            ),
          ),
          Expanded(
            child: filteredHeroes.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: filteredHeroes.length,
                    itemBuilder: (context, index) {
                      custom_hero.Hero hero = filteredHeroes[index];
                      bool isFavorite = favoritesManager.isFavorite(hero);
                      return ListTile(
                        leading: hero.images['sm'] != null
                            ? Image.network(
                                hero.images['sm']!,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              )
                            : Container(
                                width: 50,
                                height: 50,
                                color: Colors.grey,
                                child: Center(child: Text('No Image')),
                              ),
                        title: Text(hero.name),
                        subtitle: Text(hero.biography['fullName'] ?? ''), 
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/hero-detail',
                            arguments: hero,
                          );
                        },
                        trailing: IconButton(
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                          onPressed: () {
                            setState(() {
                              if (isFavorite) {
                                favoritesManager.removeFavorite(hero);
                              } else {
                                favoritesManager.addFavorite(hero);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
