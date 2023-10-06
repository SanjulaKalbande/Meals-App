import 'package:meals_app/models/structure_meal.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screens/meal_details.dart';
import 'package:meals_app/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

//to display/output meal items properly
class MealItem extends StatelessWidget {
  const MealItem({
    super.key,
    required this.meal,
    required this.onSelect,
  });

  final Meal meal;

  String get complexityTest{
    return meal.complexity.name[0].toUpperCase() + meal.complexity.name.substring(1);
  }
  String get affordibilityTest{
    return meal.affordability.name[0].toUpperCase() + meal.affordability.name.substring(1);
  }

  final void Function(Meal meal) onSelect;
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      //meals should be tappable
      child: InkWell(
        onTap: () {
          onSelect(meal);
        },
        child: Stack(
          //stack multiple widgets above each other
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                //displays image which fades in
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
                //on top of previous widget(Image)
                bottom: 0,
                left: 0,
                right: 0, //no distance between the left and right border
                child: Container(
                  color: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(children: [
                    Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                      //In Flutter,
                      // you can break text to the next line by setting the
                      // softWrap property of the Text widget to true.
                      // By default, this property is set to false,
                      // which means that long text will overflow the widget’s
                      // bounds. When softWrap is true, the text will break to
                      // the next line instead of overflowing.


                        overflow: TextOverflow.ellipsis, //very long text...
                        style:  TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MealItemTrait(icon: Icons.schedule, label: '${meal.duration} min',),
                        const SizedBox(width: 16),
                        MealItemTrait(icon: Icons.work_outline, label: complexityTest),
                        const SizedBox(width: 12),
                        MealItemTrait(icon: Icons.attach_money, label: affordibilityTest),
                      ],
                    ),
                  ]),
                ))
          ],
        ),
      ),
    );
  }
}
