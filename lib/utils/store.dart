import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipes_app/model/recipe.dart';

Future<bool> updateFavorites(String uid, String recipeId) {
  DocumentReference<Map<String, dynamic>> favoritesReference = FirebaseFirestore.instance.collection('users').doc(uid);

  return FirebaseFirestore.instance.runTransaction((Transaction tx) async {
    DocumentSnapshot<Map<String, dynamic>> postSnapshot = await tx.get(favoritesReference);
    if (postSnapshot.exists) {
      // Extend 'favorites' if the list does not contain the recipe ID:
      if (!postSnapshot.data()!['favorites'].contains(recipeId)) {
        await tx.update(favoritesReference, <String, dynamic>{
          'favorites': FieldValue.arrayUnion([recipeId])
        });
      // Delete the recipe ID from 'favorites':
      } else {
        await tx.update(favoritesReference, <String, dynamic>{
          'favorites': FieldValue.arrayRemove([recipeId])
        });
      }
    } else {
      // Create a document for the current user in collection 'users'
      // and add a new array 'favorites' to the document:
      await tx.set(favoritesReference, {
        'favorites': [recipeId]
      });
    }
  }).then((result) {
    return true;
  }).catchError((error) {
    print('Error: $error');
    return false;
  });
}

Future seedStore() async {
  CollectionReference<Map<String, dynamic>> recipes = FirebaseFirestore.instance.collection('recipes');

  QuerySnapshot<Map<String, dynamic>> _query = await recipes.get();
  if (_query.docs.isEmpty) {
    recipes.add({
      'type': RecipeType.food.index,
      'name': 'Oatmeal with Fruits',
      'duration': Duration(minutes: 15).inMinutes,
      'ingredients': [
        '100g of oats',
        '100ml of milk',
        'Fruits of your choice',
        'Honey',
        'Cinnamon',
      ],
      'preparation': [
        'Step 1',
        'Step 2',
        'Step 3',
      ],
      'imageURL': 'https://images.unsplash.com/photo-1517673400267-0251440c45dc?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f197f4922b3f26ed3f4e3e66a113b67b&auto=format&fit=crop&w=1050&q=80',
    });

    recipes.add({
      'type': RecipeType.food.index,
      'name': 'Pancakes with Maple Syrup',
      'duration': Duration(minutes: 20).inMinutes,
      'ingredients': [
        '2 eggs',
        '100ml of milk',
        '50g of flour',
        '10g of butter',
        'Baking powder',
        'Maple syrup',
      ],
      'preparation': [
        'Step 1',
        'Step 2',
        'Step 3',
      ],
      'imageURL': 'https://images.unsplash.com/photo-1517741991040-91338b176129?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=f65c4032c1b3131f829d464fb979f5e8&auto=format&fit=crop&w=675&q=80',
    });

    recipes.add({
      'type': RecipeType.drink.index,
      'name': 'Strawberry Juice',
      'duration': Duration(minutes: 10).inMinutes,
      'ingredients': [
        '100g of strawberries',
        '500ml of water',
        '2 teaspoons of sugar',
        'Juice of half a lemon',
      ],
      'preparation': [
        'Step 1',
        'Step 2',
        'Step 3',
      ],
      'imageURL':
      'https://images.unsplash.com/photo-1506802913710-40e2e66339c9?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=c8ffc5bbb3719b5a46ee703acb0a0ac5&auto=format&fit=crop&w=634&q=80',
    });

    recipes.add({
      'type': RecipeType.drink.index,
      'name': 'Blueberry Smoothie',
      'duration': Duration(minutes: 10).inMinutes,
      'ingredients': [
        '100g of fresh blueberries',
        '200g of plain yoghurt',
        '100g of milk',
        '1 banana',
      ],
      'preparation': [
        'Step 1',
        'Step 2',
        'Step 3',
      ],
      'imageURL': 'https://images.unsplash.com/photo-1532301791573-4e6ce86a085f?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=c0d9fe8ce9033db3a46ddf00bba92240&auto=format&fit=crop&w=1050&q=80',
    });
  }
}
