import 'package:blog_app/app/features/bookmarked/data/data_source/local/bookmark_dao.dart';
import 'package:blog_app/app/features/bookmarked/data/data_source/local/hive_bookmark_dao.dart';
import 'package:blog_app/app/features/bookmarked/data/repository/bookmark_repository.dart';
import 'package:blog_app/app/features/home/data/data_source/remote/posts_api_client.dart';
import 'package:blog_app/app/features/home/data/repository/post_repository.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:blog_app/core/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'router/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // clients
  di.registerLazySingleton<PostApiClient>(
      () => PostApiClient(apiService: di()));

  // repos
  di.registerLazySingleton<PostRepository>(
      () => PostRepository(dashboardApiClient: di()));
  di.registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepository(bookmarkDao: di()));

  // data
  // --- local
  di.registerLazySingleton<BookmarkDao>(() => HiveBookmarkDao(postBox: di()));

  // services
  di.registerLazySingleton<APIService>(() => APIService());

  // external
  final bookmarkBox = await Hive.openBox<Post>('bookmarkBox');
  di.registerLazySingleton(() => bookmarkBox);

  // core
  di.registerLazySingleton(() => NavigationService());
}
