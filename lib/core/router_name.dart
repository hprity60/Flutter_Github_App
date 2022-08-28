import 'package:flutter/material.dart';

import '../modules/view/Home_screen.dart';

class RouteNames {
  static const String repoListScreen = '/';
  static const String detailsScreen = '/detailsScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.repoListScreen:
        return MaterialPageRoute(
            settings: settings, builder: (_) => HomeScreen());
      
      
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
