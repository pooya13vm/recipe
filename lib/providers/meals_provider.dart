import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/data/dummy_data.dart';
import 'package:recipe/models/meal.dart';
import 'package:recipe/providers/filter_provider.dart';

// final mealsProvider = Provider((ref) => dummyMeals);
class MealsNotifier extends StateNotifier<List<Meal>> {
  MealsNotifier() : super([...dummyMeals]);

  // void filterList(type) {
  //   if (type == "isGluten") {
  //     state = state.where((item) => item.isGlutenFree == false).toList();
  //   }
  //   if (type == "isLactose") {
  //     state = state.where((item) => item.isLactoseFree == false).toList();
  //   }
  //   if (type == "isVegetarian") {
  //     state = state.where((item) => item.isVegetarian == false).toList();
  //   }
  //   if (type == "isVegan") {
  //     state = state.where((item) => item.isVegan == false).toList();
  //   }
  void filterList(List<Meal> meals, String type) {
    if (type == "isGluten") {
      meals.retainWhere((item) => item.isGlutenFree == false);
    }
    if (type == "isLactose") {
      meals.retainWhere((item) => item.isLactoseFree == false);
    }
    if (type == "isVegetarian") {
      meals.retainWhere((item) => item.isVegetarian == false);
    }
    if (type == "isVegan") {
      meals.retainWhere((item) => item.isVegan == false);
    }
  }
}

final mealsProvider = StateNotifierProvider<MealsNotifier, List<Meal>>(
  (ref) => MealsNotifier(),
);

final filteredMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);

  List<Meal> filteredMeals = [...meals];

  // if (activeFilters[Filter.glutenFree] == true) {
  //   ref.read(mealsProvider.notifier).filterList("isGluten");
  // }
  // if (activeFilters[Filter.lactoseFree] == true) {
  //   ref.read(mealsProvider.notifier).filterList("isLactose");
  // }
  // if (activeFilters[Filter.vegetarian] == true) {
  //   ref.read(mealsProvider.notifier).filterList("isVegetarian");
  // }
  // if (activeFilters[Filter.vegan] == true) {
  //   ref.read(mealsProvider.notifier).filterList("isVegan");
  // }
  if (activeFilters[Filter.glutenFree] == true) {
    ref.read(mealsProvider.notifier).filterList(filteredMeals, "isGluten");
  }
  if (activeFilters[Filter.lactoseFree] == true) {
    ref.read(mealsProvider.notifier).filterList(filteredMeals, "isLactose");
  }
  if (activeFilters[Filter.vegetarian] == true) {
    ref.read(mealsProvider.notifier).filterList(filteredMeals, "isVegetarian");
  }
  if (activeFilters[Filter.vegan] == true) {
    ref.read(mealsProvider.notifier).filterList(filteredMeals, "isVegan");
  }

  return filteredMeals;
});
