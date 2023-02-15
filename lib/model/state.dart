import 'package:firebase_auth/firebase_auth.dart';

class StateModel {
  bool isLoading;
  User? user;
  // Make sure 'favorites' is not null:
  List<String> favorites = [];

  StateModel({
    this.isLoading = false,
    this.user,
  });
}

