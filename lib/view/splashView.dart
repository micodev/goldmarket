import 'package:flutter/material.dart';
import 'package:goldmarket/constants/constants.dart';
import 'package:goldmarket/model/service/local_storage.dart';
import 'package:goldmarket/model/service/locator.dart';
import 'package:goldmarket/model/service/nav_services/navigationService.dart';
import 'package:goldmarket/provider/userProvider.dart';
import 'package:provider/provider.dart';

class SplashScreenView extends StatelessWidget {
  SplashScreenView({Key key}) : super(key: key) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      lazyUserStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Icon(Icons.access_alarm),
        ),
      ),
    );
  }

  void lazyUserStatus() async {
    NavigationService navigationService = locator<NavigationService>();
    locator.isReady<LocalStorageService>().then((value) {
      UserProvider userProvider = Provider.of<UserProvider>(
          navigationService.navigatorKey.currentContext,
          listen: false);
      changeRouteFromPermission(userProvider.userStatus, navigationService);
    });
  }
}
