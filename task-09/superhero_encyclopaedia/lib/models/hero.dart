class Hero {
  final String name;
  final Map<String, dynamic> powerstats;
  final Map<String, dynamic> appearance;
  final Map<String, dynamic> biography;
  final Map<String, dynamic> work;
  final Map<String, dynamic> connections;
  final Map<String, dynamic> images;
  final String type; 
  bool isFavorite; 

  Hero({
    required this.name,
    required this.powerstats,
    required this.appearance,
    required this.biography,
    required this.work,
    required this.connections,
    required this.images,
    required this.type,
    this.isFavorite = false, 
  });

  factory Hero.fromJson(Map<String, dynamic> json) {
    String alignment = json['biography']['alignment'] ?? 'unknown';
    String type;
    switch (alignment) {
      case 'good':
        type = 'Hero';
        break;
      case 'bad':
        type = 'Villain';
        break;
      case 'neutral':
        type = 'Anti-Hero';
        break;
      default:
        type = 'All'; 
    }

    return Hero(
      name: json['name'],
      powerstats: json['powerstats'],
      appearance: json['appearance'],
      biography: json['biography'],
      work: json['work'],
      connections: json['connections'],
      images: json['images'],
      type: type,
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
