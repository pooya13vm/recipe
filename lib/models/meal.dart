enum Complexity { simple, challenging, hard }

enum Affordability { affordable, pricey, luxurious }

class Meal {
  const Meal(
      {required this.id,
      required this.categories,
      required this.title,
      required this.affordability,
      required this.complexity,
      required this.imageUrl,
      required this.duration,
      required this.ingredients,
      required this.steps,
      required this.isGlutenFree,
      required this.isLactoseFree,
      required this.isVegan,
      required this.isVegetarian});

  final String id;
  final List<String> categories;
  final String title;
  final Affordability affordability;
  final Complexity complexity;
  final String imageUrl;
  final double duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;
}
