import 'package:flutter/material.dart';
// import 'package:recipe/screens/tabs.dart';
// import 'package:recipe/widgets/main_drawer.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var glutenFree = false;
  var lactoseFree = false;
  var vegetarian = false;
  var vegan = false;

  @override
  void initState() {
    super.initState();
    glutenFree = widget.currentFilters[Filter.glutenFree]!;
    lactoseFree = widget.currentFilters[Filter.lactoseFree]!;
    vegetarian = widget.currentFilters[Filter.vegetarian]!;
    vegan = widget.currentFilters[Filter.vegan]!;
  }

  void setGluten(bool state) {
    setState(() {
      glutenFree = state;
    });
  }

  void setLactose(bool state) {
    setState(() {
      lactoseFree = state;
    });
  }

  void setVegetarian(bool state) {
    setState(() {
      vegetarian = state;
    });
  }

  void setVegan(bool state) {
    setState(() {
      vegan = state;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter"),
      ),
      // drawer: MainDrawer(onSelectedScreen: (identifier) {
      //   Navigator.of(context).pop();
      //   if (identifier == "Meals") {
      //     Navigator.of(context).pushReplacement(
      //       MaterialPageRoute(builder: (ctx) => const TabScreen()),
      //     );
      //   }
      // }),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop(
            {
              Filter.glutenFree: glutenFree,
              Filter.lactoseFree: lactoseFree,
              Filter.vegetarian: vegetarian,
              Filter.vegan: vegan,
            },
          );
          return false;
        },
        child: Column(children: [
          FilterItem(
              value: glutenFree, setValue: setGluten, title: "Gluten-free"),
          FilterItem(
              value: lactoseFree, setValue: setLactose, title: "lactose-Free"),
          FilterItem(
              value: vegetarian, setValue: setVegetarian, title: "Vegetarian"),
          FilterItem(value: vegan, setValue: setVegan, title: "Vegan"),
        ]),
      ),
    );
  }
}

class FilterItem extends StatelessWidget {
  const FilterItem(
      {super.key,
      required this.value,
      required this.setValue,
      required this.title});

  final bool value;
  final void Function(bool isChecked) setValue;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: value,
      onChanged: (isChecked) {
        setValue(isChecked);
      },
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text('only include $title meals',
          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              )),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }
}
