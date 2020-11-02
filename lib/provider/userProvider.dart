import 'package:flutter/cupertino.dart';
import 'package:goldmarket/constants/constants.dart';
import 'package:goldmarket/model/core/user.dart';
import 'package:goldmarket/model/helper/loginHelper.dart';
import 'package:goldmarket/model/service/local_storage.dart';
import 'package:goldmarket/model/service/locator.dart';
import 'package:goldmarket/model/service/nav_services/navigationService.dart';

class UserProvider extends ChangeNotifier {
  User currentUser;
  bool isloginUserLoading;
  UserStatus userStatus;
  Loginhelper _helper = Loginhelper();
  UserProvider() {
    userStatus = UserStatus.Initialize;
    var localStorage = locator<LocalStorageService>();
    var role = localStorage.getValue<String>("role");
    if (role != null) {
      if (role == "customer")
        userChange(UserStatus.Customer);
      else if (role == "merchant")
        userChange(UserStatus.Merchant);
      else if (role == "guest") userChange(UserStatus.Guest);
    }

    currentUser = null;
    isloginUserLoading = false;
  }
  loginUser(String username, String password) async {
    var localStorage = locator<LocalStorageService>();
    toggleIsloding(true);
    Future.delayed(Duration(seconds: 2), () async {
      currentUser = await _helper.loginUser(username, password);
      this.isloginUserLoading = false;
      if (currentUser == null) {
        userChange(UserStatus.Error);
      } else if (currentUser.role == "customer") {
        userChange(UserStatus.Customer);
        localStorage.saveToDisk<String>("role", "customer");
      } else if (currentUser.role == "merchant") {
        userChange(UserStatus.Merchant);
        localStorage.saveToDisk<String>("role", "merchant");
      }
    });
  }

  userChange(UserStatus userStatus) {
    var localStorage = locator<LocalStorageService>();
    var navKeyService = locator<NavigationService>();
    if (userStatus == UserStatus.Guest) {
      localStorage.saveToDisk<String>("role", "guest");
    }
    this.userStatus = userStatus;
    changeRouteFromPermission(userStatus, navKeyService);
    notifyListeners();
  }

  void toggleIsloding(bool value) {
    isloginUserLoading = value;
    notifyListeners();
  }
}
