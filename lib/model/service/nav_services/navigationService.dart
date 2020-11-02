import 'package:flutter/material.dart';

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();
  Future<dynamic> navigateTo(String routeName) {
    return navigatorKey.currentState.pushNamed(routeName);
  }

  Future<dynamic> navigateAndFirst(String routeName) {
    navigatorKey.currentState.popUntil((route) => route.isFirst);
    return navigatorKey.currentState.pushReplacementNamed(routeName);
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
