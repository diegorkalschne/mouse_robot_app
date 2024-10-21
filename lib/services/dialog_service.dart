import 'package:flutter/material.dart';

import '../config/assets/assets_path.dart';
import 'locator.dart';

final _navigatorKey = locator<GlobalKey<NavigatorState>>();

bool _showingSnack = false;
bool _canReplace = true;

void clearSnackbars() {
  ScaffoldMessenger.of(_navigatorKey.currentContext!).clearSnackBars();
}

/// Function to display a snackbar
void showSnackbar(
  String description, {
  int seconds = 5,
  SnackBarAction? action,
  SnackBarBehavior? behavior,
  bool canReplace = true,
}) {
  _showingSnack = true;

  if (_showingSnack && !_canReplace) {
    _canReplace = true;
    return;
  }

  _canReplace = canReplace;

  ScaffoldMessenger.of(_navigatorKey.currentContext!).removeCurrentSnackBar();

  ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(SnackBar(
    content: Row(
      children: [
        Image.asset(
          AssetsPath.LOGO2,
          width: 50,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Theme.of(_navigatorKey.currentContext!).colorScheme.primaryContainer,
            ),
          ),
        ),
      ],
    ),
    duration: Duration(seconds: seconds),
    behavior: behavior ?? SnackBarBehavior.floating,
    action: action,
  ));
}

/// Function to display a snackbar at the top of the application
void showTopSnackbar(
  String description, {
  int seconds = 5,
  SnackBarAction? action,
  bool canReplace = true,
}) {
  _showingSnack = true;

  if (_showingSnack && !_canReplace) {
    _canReplace = true;
    return;
  }

  _canReplace = canReplace;

  final bottom = MediaQuery.of(_navigatorKey.currentContext!).size.height * 0.8;

  ScaffoldMessenger.of(_navigatorKey.currentContext!).removeCurrentSnackBar();

  ScaffoldMessenger.of(_navigatorKey.currentContext!).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Image.asset(
            AssetsPath.LOGO2,
            width: 50,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              description,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
      action: action,
      duration: Duration(seconds: seconds),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 15).copyWith(bottom: bottom),
    ),
  );
}
