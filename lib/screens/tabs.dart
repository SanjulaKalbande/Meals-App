import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/show_meals.dart';
import 'package:meals_app/models/structure_meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kInititalFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedpageIndex = 0;
  final  List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _selectedFilters = kInititalFilters;

  void _showInfoMsg(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(message),
    )
    );
  }
  void _toggleMealFavoritesScreen(Meal meal) {
    final ifExisting = _favoriteMeals.contains(meal);

    if(ifExisting){
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMsg("Meal is no longer a favorite.");
    }
    else{
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMsg("Marked as a favorite!");
      });
    }
  }

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
          MaterialPageRoute(builder:(ctx) => FiltersScreen(currentFilters: _selectedFilters,)
          ),
      );
      setState((){
        _selectedFilters = result ?? kInititalFilters;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final availableMeals = dummyMeals.where((meal){
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree){
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian){
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoritesScreen,
      availableMeals: availableMeals,
    );
    var activePageTitle = "Categories";

    if(_selectedpageIndex == 1){
        activePage = MealsScreen(meals: _favoriteMeals, onToggleFavorite: _toggleMealFavoritesScreen,);
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
