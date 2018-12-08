import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> updateFavorites(String uid, String recipeId) {
  DocumentReference favoritesReference =
      Firestore.instance.collection('users').document(uid);

  return Firestore.instance.runTransaction((Transaction tx) async {
    DocumentSnapshot postSnapshot = await tx.get(favoritesReference);
    if (postSnapshot.exists) {
      // Extend 'favorites' if the list does not contain the recipe ID:
      if (!postSnapshot.data['favorites'].contains(recipeId)) {
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
