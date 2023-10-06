import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/screens/show_meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';
import 'package:meals_app/models/structure_category.dart';

import '../models/structure_meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      // upperBound: 0,
      // lowerBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
          padding: const EdgeInsets.all(10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 1.8,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15),
          children: [
            // we go through all the categories in the available categories
            for (final category in availableCategories)
              CategoryGridItem(
                  category: category,
                  onSelectCategory: () {
                    _selectCategory(context, category);
                  })
          ],
        ),
        builder: (context, child) => SlideTransition(
                position: Tween(
              begin: const Offset(0, 0.3),
              end: const Offset(0, 0),
            ).animate(
                    CurvedAnimation(
                    parent: _animationController, curve: Curves.easeInOut),),
        child: child));
  }
}
