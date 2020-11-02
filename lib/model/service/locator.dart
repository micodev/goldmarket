import 'package:get_it/get_it.dart';
import 'local_storage.dart';
import 'nav_services/navigationService.dart';

GetIt locator = GetIt.instance;

setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingletonAsync(() => LocalStorageService.getInstance());
}
