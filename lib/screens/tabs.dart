import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/show_meals.dart';
import 'package:meals_app/models/structure_meal.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectpageIndex = 0;
  final  List<Meal> _favoriteMeals = [];

  void _showInfoMsg(String message){
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)
    ));
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
      });
      _showInfoMsg("Marked as a favorite!");
    }
  }

  @override
  void _selectPage(int index){
    setState(() {
      _selectpageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(onToggleFavorite: _toggleMealFavoritesScreen,);
    var activePageTitle = "Categories";

    if(_selectpageIndex == 1){
        activePage = MealsScreen(meals: _favoriteMeals, onToggleFavorite: _toggleMealFavoritesScreen,);
        activePageTitle = "Favorites";
    }

    return Scaffold(
      drawer: const MainDrawer(),
      appBar: AppBar(
        title: Text(activePageTitle), //it will be created on the basis of what is tapped
      ),
      body: activePage,
      bottomNavigationBar:
      BottomNavigationBar(
        currentIndex: _selectpageIndex,// controls what icon is selected and highlights
        onTap: _selectPage,
        items: const [
        BottomNavigationBarItem(icon: Icon(Icons.fastfood), label: "Categories "),
        BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Categories "),
      ],
      ),
    );
  }
}
