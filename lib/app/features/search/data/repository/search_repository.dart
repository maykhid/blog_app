import 'package:blog_app/core/model/error/failure.dart';
import 'package:blog_app/core/utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../home/data/data_source/local/posts/post_dao.dart';
import '../../../home/data/data_source/local/users/user_dao.dart';
import '../../../home/data/data_source/remote/posts_api_client.dart';
import '../../../shared/model/post.dart';
import '../../../shared/model/user.dart';

class SearchRepository {
  final PostApiClient _postApiClient;
  final PostDao _postDao;
  final UserDao _userDao;

  SearchRepository(
      {required PostApiClient postApiClient,
      required PostDao postDao,
      required UserDao userDao})
      : _postApiClient = postApiClient,
        _postDao = postDao,
        _userDao = userDao;

  Future<Either<Failure, Tuple2<Posts, Users>>> search(String searchTerm) async {
    try {
      List<Post> foundPosts = [];

      final getPostsResponse = await _postApiClient.getPosts()
        ..log();
      final getUsersResponse = await _postApiClient.getUsers();

      // store posts locally
      _postDao.cachePosts(posts: getPostsResponse);

      // store users locally
      _userDao.cacheUsers(users: getUsersResponse);

      foundPosts = getPostsResponse.posts
          .where((post) =>
              post.title.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      return Right(Tuple2(Posts(posts: foundPosts), getUsersResponse));
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

  Future<Either<Failure, Tuple2<Posts, Users>>> searchOffline(String searchTerm) async {
    try {
      List<Post> foundPosts = [];

      final getCachedPosts = _postDao.getCachedPosts()!..log();
      final getCachedUsers = _userDao.getCachedUsers()!..log();

      foundPosts = getCachedPosts.posts
          .where((post) =>
              post.title.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      return Right(Tuple2(Posts(posts: foundPosts), getCachedUsers));
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

  Future<Either<Failure, Tuple2<Posts, Users>>> seacrchLiveOrOfflinePostsAndUsers(
      String searchTerm) async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    bool isPostsAndUsersAvailable =
        _postDao.isPostsCacheAvailable && _userDao.isUsersCacheAvailable;

    if (!hasConnection && isPostsAndUsersAvailable) {
      return searchOffline(searchTerm);
    }
    return search(searchTerm);
  }
}
