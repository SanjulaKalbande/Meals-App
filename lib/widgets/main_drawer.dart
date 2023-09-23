import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
          children: [
            DrawerHeader(
            padding:const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Theme.of(context).colorScheme.primaryContainer,
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.8),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight
              )
            ),
            child:
              Row(
                children: [
                  Icon(Icons.restaurant, size: 40, color: Colors.white),
                  const SizedBox(width: 18),
                  Text(
                    "Cooking up!", style:Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white),
                    //
                  )
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.ramen_dining_rounded),
              title: Text("Meals", style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Theme.of(context).colorScheme.onBackground, fontSize: 24),
            ),
              onTap: (){},
            ),
            ListTile(
              leading: Icon(Icons.filter_list),
              title: Text("Filters", style: Theme.of(context).textTheme.titleSmall!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground, fontSize: 24),
              ),
              onTap: (){},
            ),
          ],
        ),
      );
  }
}
