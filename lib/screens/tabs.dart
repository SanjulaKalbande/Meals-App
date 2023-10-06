import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/show_meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorites_provider.dart';
import 'package:meals_app/provider/filters_provider.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget{
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedpageIndex = 0;

  @override
  void _selectPage(int index){
    setState(() {
      _selectedpageIndex = index;
    });
  }

  void _setScreen(String identifier) async{
    Navigator.of(context).pop();
    if(identifier == "filters"){
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder:(ctx) => const FiltersScreen()
          ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    //read to get data from provider, or watch to set up a listener
    //that will make sure that build method executes again as our data changes
    final availableMeals = ref.watch(filteredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";

    if(_selectedpageIndex == 1){
      final favoriteMeals = ref.watch(favoriteMealsProvider);
        activePage = MealsScreen(meals: favoriteMeals);
        activePageTitle = "Favorites";
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScreen: _setScreen),
      appBar: AppBar(
        title: Text(activePageTitle), //it will be created on the basis of what is tapped
      ),
      body: activePage,
      bottomNavigationBar:
      BottomNavigationBar(

        onTap: _selectPage,
        currentIndex: _selectedpageIndex,// controls what icon is selected and highlights

        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Categories "),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Categories "),
      ],
      ),
    );
  }
}
