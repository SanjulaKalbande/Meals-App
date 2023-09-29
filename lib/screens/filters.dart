import 'package:flutter/material.dart';

import 'package:meals_app/screens/tabs.dart';
import 'package:meals_app/widgets/main_drawer.dart';

enum Filter{
  glutenFree,
  lactoseFree,
  vegetarian,
  vegan,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool>currentFilters;
  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterState = false;
  var _lactoseFreeFilterState = false;
  var _vegetarianFilterState = false;
  var _veganFilterState = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _glutenFreeFilterState = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterState = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterState = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterState = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text(
          "Filters Screen",
        ),
      ),
      // drawer: MainDrawer(
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).push(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),

      body: WillPopScope(
        onWillPop: () async{
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilterState,
            Filter.lactoseFree: _lactoseFreeFilterState,
            Filter.vegetarian: _vegetarianFilterState,
            Filter.vegan: _veganFilterState
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(value: _glutenFreeFilterState,
              onChanged: (isChecked){
              setState(() {
                _glutenFreeFilterState = isChecked;
              });
            },
              title: Text('Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text("Only includes gluten free meals",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 22, right: 24),
              ),
            SwitchListTile(value: _lactoseFreeFilterState,
              onChanged: (isChecked){
                setState(() {
                  _lactoseFreeFilterState = isChecked;
                });
              },
              title: Text('Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text("Only includes lactose free meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 22, right: 24),
            ),
            SwitchListTile(value: _vegetarianFilterState,
              onChanged: (isChecked){
                setState(() {
                  _vegetarianFilterState = isChecked;
                });
              },
              title: Text('Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text("Only includes vegetarian meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 22, right: 24),
            ),
            SwitchListTile(value: _veganFilterState,
              onChanged: (isChecked){
                setState(() {
                  _veganFilterState = isChecked;
                });
              },
              title: Text('Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text("Only includes vegan meals",
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 22, right: 24),
            ),

          ],
        ),
      ),
    );
  }
}
