import 'package:get_it/get_it.dart';

import 'router/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // core
  di.registerLazySingleton(() => NavigationService());
}
