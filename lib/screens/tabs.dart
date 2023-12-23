import 'package:flutter/material.dart';
// import 'package:recipe/data/dummy_data.dart';
import 'package:recipe/models/meal.dart';
import 'package:recipe/screens/categoriesScreen.dart';
import 'package:recipe/screens/filtersScreen.dart';
import 'package:recipe/screens/mealsScreen.dart';
import 'package:recipe/widgets/main_drawer.dart';
//importing providers:
import 'package:recipe/providers/meals_provider.dart';
import 'package:recipe/providers/filter_provider.dart';
import 'package:recipe/providers/favorites_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

// it is a test for github
class _TabScreenState extends ConsumerState<TabScreen> {
  // final List<Meal> favoriteList = [];
  // final List<Meal> mainList = [];
  Map<Filter, bool> selectedFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  // @override
  // void initState() {
  //   super.initState();
  //   mainList.addAll(dummyMeals);
  // }

  int _selectedPageIndex = 0;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // states
    final mainList = ref.watch(filteredMealProvider);
    final favoriteList = ref.watch(favoritesProvider);

    Widget activePage = CategoriesScreen(
      mainList: mainList,
    );

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        title: "",
        meals: favoriteList,
      );
    }

    void _setScreen(String filterItem) async {
      Navigator.of(context).pop();
      if (filterItem == "Filters") {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (ctx) => const FilterScreen(),
          ),
        );
        final activeFilters = ref.watch(filtersProvider);
        // setState(() {
        //   selectedFilters = result ?? selectedFilters;
        // });

        // if (activeFilters[Filter.glutenFree] == true) {
        //   setState(() {
        //     mainList.removeWhere((item) => item.isGlutenFree == false);
        //   });
        // }
        // if (activeFilters[Filter.lactoseFree] == true) {
        //   setState(() {
        //     mainList.removeWhere((item) => item.isLactoseFree == false);
        //   });
        // }
        // if (activeFilters[Filter.vegetarian] == true) {
        //   setState(() {
        //     mainList.removeWhere((item) => item.isVegetarian == false);
        //   });
        // }
        // if (activeFilters[Filter.vegan] == true) {
        //   setState(() {
        //     mainList.removeWhere((item) => item.isVegan == false);
        //   });
        // }
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
