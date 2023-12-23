import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/models/meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealsNotifier() : super([]);

  void toggleFavorites(Meal meal) {
    final isFavorite = state.contains(meal);

    if (isFavorite) {
      // remove
      state = state.where((item) => item.id != meal.id).toList();
    } else {
      // add
      state = [meal, ...state];
    }
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoriteMealsNotifier, List<Meal>>(
  (ref) => FavoriteMealsNotifier(),
);
