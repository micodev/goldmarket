import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:goldmarket/model/service/nav_services/navigationService.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

//Routes
const String LoginRoute = 'Login';
const String MainRoute = 'Main';
const String DashBoard = 'DashBoard';
const String FirstRoute = "/";
//colors
const Color primaryColor =
    Color(0xffdab854); // Color.fromARGB(255, 232, 196, 91);
const Color backgroundColor = Color.fromARGB(255, 240, 240, 244);
// userServices
enum UserStatus { Initialize, Guest, Customer, Merchant, Error }
// naviagate constant
void changeRouteFromPermission(
    UserStatus userStatus, NavigationService navigationService) {
  switch (userStatus) {
    case UserStatus.Initialize:
      navigationService.navigateAndFirst(LoginRoute);
      break;
    case UserStatus.Customer:
      navigationService.navigateAndFirst(MainRoute);
      break;
    case UserStatus.Merchant:
      navigationService.navigateAndFirst(DashBoard);
      break;
    case UserStatus.Error:
      break;
    case UserStatus.Guest:
      navigationService.navigateAndFirst(MainRoute);
      break;
  }
}

Future<Image> assetThumbToImage(Asset asset) async {
  final ByteData byteData = await asset.getByteData();

  final Image image = Image.memory(byteData.buffer.asUint8List());

  return image;
}
