import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:recipes_app/app.dart';
import 'package:recipes_app/state_widget.dart';

// - StateWidget incl. state data
//    - RecipesApp
//        - All other widgets which are able to access the data
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  StateWidget stateWidget = new StateWidget(child:new RecipesApp());
  runApp(stateWidget);
}
