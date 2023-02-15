import 'package:duration/duration.dart';

enum RecipeType {
  food,
  drink,
}

class Recipe {
  final String id;
  final RecipeType type;
  final String name;
  final Duration duration;
  final List<String> ingredients;
  final List<String> preparation;
  final String imageURL;

  const Recipe({
    required this.id,
    required this.type,
    required this.name,
    required this.duration,
    required this.ingredients,
    required this.preparation,
    required this.imageURL,
  });

  String get getDurationString => prettyDuration(this.duration);

  Recipe.fromMap(Map<String, dynamic> data, String id) : this(
    id: id,
    type: RecipeType.values[data['type']],
    name: data['name'],
    duration: Duration(minutes: data['duration']),
    ingredients: new List<String>.from(data['ingredients']),
    preparation: new List<String>.from(data['preparation']),
    imageURL: data['imageURL'],
  );
}
