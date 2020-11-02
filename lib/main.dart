import 'package:flutter/material.dart';
import 'package:goldmarket/provider/bezierProvider.dart';
import 'package:goldmarket/provider/productProvider.dart';
import 'package:goldmarket/provider/userProvider.dart';
import 'package:provider/provider.dart';
import 'model/service/locator.dart';
import 'model/service/nav_services/navigationService.dart';

import 'router.dart' as router;
import 'constants/constants.dart' as routes;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<BezierProvider>(
      create: (_) => BezierProvider(),
    ),
    ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
    ChangeNotifierProvider<ProductProvider>(
      create: (_) => ProductProvider(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          backgroundColor: Colors.grey[800],
          primaryColor: routes.primaryColor,
          floatingActionButtonTheme: Theme.of(context)
              .floatingActionButtonTheme
              .copyWith(backgroundColor: routes.primaryColor),
          fontFamily: "Arabic"),
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.FirstRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
