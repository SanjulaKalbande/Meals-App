import 'package:flutter/material.dart';
import 'package:meals_app/models/structure_meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/provider/favorites_provider.dart';

class MealDetails extends ConsumerWidget {
  const MealDetails({super.key, required this.meal});

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasAdded =
                  // we should not use watch but read to read a value once
                  ref
                      .read(favoriteMealsProvider
                          .notifier) //gives access to notifier class
                      .toggleMealFavoriteStatus(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(wasAdded
                      ? 'Meal added as fav'
                      : 'Meal removed'
                          'from fav'),
                ),
              );
            },
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return RotationTransition(
                    turns: Tween(begin: 0.5, end: 1.0).animate(animation),
                    child: child);
              },
              child: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border_outlined,
                  key: ValueKey(isFavorite)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: meal.id,
              child: Image.network(
                meal.imageUrl,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 12),
            Text('Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (final ingredient in meal.ingredients)
              Text(ingredient,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )),
            const SizedBox(height: 12),
            Text('Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            for (final step in meal.steps)
              Padding(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
                child: Text(step,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: Theme.of(context).colorScheme.primary,
                        )),
              )
          ],
        ),
      ),
    );
  }
}
