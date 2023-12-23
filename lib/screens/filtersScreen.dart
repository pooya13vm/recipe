import 'package:flutter/material.dart';
// import 'package:recipe/screens/tabs.dart';
// import 'package:recipe/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:recipe/providers/filter_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({
    super.key,
  });

  @override
  ConsumerState<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  var glutenFree = false;
  var lactoseFree = false;
  var vegetarian = false;
  var vegan = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    glutenFree = activeFilters[Filter.glutenFree]!;
    lactoseFree = activeFilters[Filter.lactoseFree]!;
    vegetarian = activeFilters[Filter.vegetarian]!;
    vegan = activeFilters[Filter.vegan]!;
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
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filtersProvider.notifier).setAllFilters({
            Filter.glutenFree: glutenFree,
            Filter.lactoseFree: lactoseFree,
            Filter.vegetarian: vegetarian,
            Filter.vegan: vegan,
          });
          // Navigator.of(context).pop();
          return true;
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
      required this.title,
      required this.setValue});

  final bool value;
  final String title;
  final void Function(bool) setValue;

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
