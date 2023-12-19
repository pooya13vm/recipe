import 'package:flutter/material.dart';
import 'package:recipe/data/dummy_data.dart';
import 'package:recipe/models/meal.dart';
import 'package:recipe/screens/categoriesScreen.dart';
import 'package:recipe/screens/filtersScreen.dart';
import 'package:recipe/screens/mealsScreen.dart';
import 'package:recipe/widgets/main_drawer.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({super.key});

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Meal> favoriteList = [];
  final List<Meal> mainList = [];
  Map<Filter, bool> selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void toggleFavorite(Meal meal) {
    if (favoriteList.contains(meal)) {
      setState(() {
        favoriteList.remove(meal);
      });
    } else {
      setState(() {
        favoriteList.add(meal);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mainList.addAll(dummyMeals);
  }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFav: toggleFavorite,
      mainList: mainList,
    );

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        title: "",
        meals: favoriteList,
        onToggleFav: toggleFavorite,
      );
    }

    void _setScreen(String filterItem) async {
      Navigator.of(context).pop();
      if (filterItem == "Filters") {
        final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(
            builder: (ctx) => FilterScreen(currentFilters: selectedFilters),
          ),
        );

        setState(() {
          selectedFilters = result ?? selectedFilters;
        });

        if (result?[Filter.glutenFree] == true) {
          setState(() {
            mainList.removeWhere((item) => item.isGlutenFree == false);
          });
        }
        if (result?[Filter.lactoseFree] == true) {
          setState(() {
            mainList.removeWhere((item) => item.isLactoseFree == false);
          });
        }
        if (result?[Filter.vegetarian] == true) {
          setState(() {
            mainList.removeWhere((item) => item.isVegetarian == false);
          });
        }
        if (result?[Filter.vegan] == true) {
          setState(() {
            mainList.removeWhere((item) => item.isVegan == false);
          });
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedPageIndex == 0 ? "Categories" : "Favorite list"),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          _selectPage(index);
        },
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: "Categories"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Favorites")
        ],
      ),
    );
  }
}
