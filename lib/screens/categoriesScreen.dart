import 'package:flutter/material.dart';
import 'package:recipe/data/dummy_data.dart';
import 'package:recipe/models/category.dart';
import 'package:recipe/models/meal.dart';
import 'package:recipe/screens/mealsScreen.dart';
import 'package:recipe/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onToggleFav, required this.mainList});

  final void Function(Meal meal) onToggleFav;
  final List<Meal> mainList;

  void _selectCategory(BuildContext context, Category category) {
    final filteredList = mainList
        .where(
          (item) => item.categories.contains(category.id),
        )
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
            title: category.title,
            meals: filteredList,
            onToggleFav: onToggleFav),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20),
      children: [
        for (var item in availableCategories)
          CategoryItem(
              category: item,
              onSelectCategory: () {
                _selectCategory(context, item);
              })
      ],
    );
  }
}
