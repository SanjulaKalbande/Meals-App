import 'package:flutter/material.dart';
import 'package:meals_app/models/structure_meal.dart';

class MealDetails extends StatelessWidget {
  const MealDetails(
      {super.key,
        required this.meal,
        required this.onToggleFavorite});

  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(meal.title),
          actions: [
            IconButton(
                onPressed: (){ onToggleFavorite(meal);},
                icon: Icon(Icons.favorite))
          ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
            ),
            const SizedBox(height: 12),
            Text('Ingredients',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)
            ),

            const SizedBox(height: 12),
            for (final ingredient in meal.ingredients)
              Text(ingredient,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      )
              ),
            const SizedBox(height: 12),
            Text('Steps',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                    fontWeight: FontWeight.bold)
            ),
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
