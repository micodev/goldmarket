import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:goldmarket/view/dashboardView.dart';
import 'package:goldmarket/view/loginView.dart';
import 'package:goldmarket/view/mainView.dart';
import 'package:goldmarket/view/splashView.dart';
import 'constants/constants.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.FirstRoute:
      return _animationNavigation(SplashScreenView());

    case routes.LoginRoute:
      return _animationNavigation(LoginView());
    case routes.DashBoard:
      return _animationNavigation(DashBoardView());
    case routes.MainRoute:
      return _animationNavigation(MainView());
    default:
      return _animationNavigation(
        Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}

_animationNavigation(pageRoute) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => pageRoute,
    transitionsBuilder: (_, anim, __, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = anim.drive(tween);
      return SlideTransition(position: offsetAnimation, child: child);
    },
  );
}
