import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:superhero_encyclopaedia/models/hero.dart';

class HeroService {
  static Future<List<Hero>> getHeroes() async {
    final String response = await rootBundle.loadString('assets/superheroes.json');
    final data = json.decode(response) as List;
    return data.map((json) => Hero.fromJson(json)).toList();
  }
}
