import 'package:blog_app/app/features/home/data/data_source/remote/posts_api_client.dart';
import 'package:blog_app/app/features/home/data/repository/post_repository.dart';
import 'package:blog_app/core/services/api_service.dart';
import 'package:get_it/get_it.dart';

import 'router/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // clients
  di.registerLazySingleton<PostApiClient>(
      () => PostApiClient(apiService: di()));

  // repos
  di.registerLazySingleton<PostRepository>(
      () => PostRepository(dashboardApiClient: di()));

  // services
  di.registerLazySingleton<APIService>(() => APIService());

  // core
  di.registerLazySingleton(() => NavigationService());
}
