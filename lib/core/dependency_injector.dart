import 'package:blog_app/app/features/bookmarked/data/data_source/local/bookmark_dao.dart';
import 'package:blog_app/app/features/bookmarked/data/data_source/local/hive_bookmark_dao.dart';
import 'package:blog_app/app/features/bookmarked/data/repository/bookmark_repository.dart';
import 'package:blog_app/app/features/home/data/data_source/local/users/hive_user_dao.dart';
import 'package:blog_app/app/features/home/data/data_source/remote/posts_api_client.dart';
import 'package:blog_app/app/features/home/data/repository/post_repository.dart';
import 'package:blog_app/app/features/search/data/repository/search_repository.dart';
import 'package:blog_app/app/features/search/view/cubits/search_cubit.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:blog_app/app/features/shared/model/user.dart';
import 'package:blog_app/core/services/api_service.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../app/features/home/data/data_source/local/posts/hive_post_dao.dart';
import '../app/features/home/data/data_source/local/posts/post_dao.dart';
import '../app/features/home/data/data_source/local/users/user_dao.dart';
import 'router/navigation_service.dart';

GetIt di = GetIt.instance;

Future<void> setupLocator() async {
  // global blocs
  di.registerFactory<SearchCubit>(() => SearchCubit(searchRepository: di()));

  // clients
  di.registerLazySingleton<PostApiClient>(
      () => PostApiClient(apiService: di()));

  // repos
  di.registerLazySingleton<PostRepository>(() =>
      PostRepository(dashboardApiClient: di(), postDao: di(), userDao: di()));
  di.registerLazySingleton<BookmarkRepository>(
      () => BookmarkRepository(bookmarkDao: di(), userDao: di()));
  di.registerLazySingleton<SearchRepository>(
      () => SearchRepository(postDao: di(), postApiClient: di(), userDao: di()));

  // data
  // --- local
  di.registerLazySingleton<BookmarkDao>(() => HiveBookmarkDao(postBox: di()));
  di.registerLazySingleton<PostDao>(() => HivePostDao(postsBox: di()));
  di.registerLazySingleton<UserDao>(() => HiveUserDao(usersBox: di()));

  // services
  di.registerLazySingleton<APIService>(() => APIService());

  // external

  // --- open and register bookmarkedPosts box
  final bookmarkBox = await Hive.openBox<Post>('bookmarkBox');
  di.registerLazySingleton(() => bookmarkBox);

  // --- open and register posts box
  final postsBox = await Hive.openBox<Posts>('postsBox');
  di.registerLazySingleton(() => postsBox);

  // --- open and register users box
  final usersBox = await Hive.openBox<Users>('usersBox');
  di.registerLazySingleton(() => usersBox);

  // core
  di.registerLazySingleton(() => NavigationService());
}
