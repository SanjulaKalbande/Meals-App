import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/structure_meal.dart';

class FavoriteMealsNotifier extends StateNotifier<List<Meal>>{
    FavoriteMealsNotifier() : super([]);

    bool toggleMealFavoriteStatus(Meal meal){
      //we must never edit the value in the super i.e here the list of meals
      final mealIsFavorite = state.contains(meal);

      if(mealIsFavorite){
        //globally available state property holds the data
        //where filters list and gets new list
        state = state.where((m) => m.id != meal.id).toList();
        return false;
      }
      else{
        state = [...state, meal];
        //spread operator to add new meal to the existing list
        return true;
      }
    }
}
final favoriteMealsProvider =
StateNotifierProvider<FavoriteMealsNotifier,List<Meal>>((ref){
  return FavoriteMealsNotifier();
});
//we have dynamic data here and therefore we took stateNotifierProvider