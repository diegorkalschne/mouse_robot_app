import 'package:flutter/material.dart';

import 'config/routes/local_routes.dart';
import 'config/theme/theme_app.dart';
import 'router_app.dart';
import 'services/locator.dart';

void main() {
  setupLocator();

  runApp(const MouseRobotApp());
}

class MouseRobotApp extends StatelessWidget {
  const MouseRobotApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mouse Robot',
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.lightTheme,
      navigatorKey: locator<GlobalKey<NavigatorState>>(),
      initialRoute: LocalRoutes.SPLASH,
      onGenerateRoute: RouterApp.onGenerateRoute,
    );
  }
}
