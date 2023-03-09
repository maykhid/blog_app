import 'package:blog_app/app/features/home/data/data_source/local/users/user_dao.dart';
import 'package:blog_app/app/features/home/data/data_source/remote/posts_api_client.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:blog_app/app/features/shared/model/user.dart';
import 'package:blog_app/core/utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';
import '../data_source/local/posts/post_dao.dart';

class PostRepository {
  final PostApiClient _postApiClient;
  final PostDao _postDao;
  final UserDao _userDao;

  PostRepository(
      {required PostApiClient dashboardApiClient,
      required PostDao postDao,
      required UserDao userDao})
      : _postApiClient = dashboardApiClient,
        _postDao = postDao,
        _userDao = userDao;

  Future<Either<Failure, Tuple2<Posts, Users>>> getPosts() async {
    try {
      final getPostsResponse = await _postApiClient.getPosts()
        ..log();

      final getUsersResponse = await _postApiClient.getUsers()..log;

      // store posts locally
      _postDao.cachePosts(posts: getPostsResponse);

      // store users locallly
      _userDao.cacheUsers(users: getUsersResponse);

      final postsUsersTuple = Tuple2(getPostsResponse, getUsersResponse);

      return Right(postsUsersTuple);
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

  Future<Either<Failure, Tuple2<Posts, Users>>> getCachedPostsUsers() async {
    try {
      final getCachedPosts = _postDao.getCachedPosts()!..log();
      final getCachedUsers = _userDao.getCachedUsers()!..log();
      final postsUsersTuple = Tuple2(getCachedPosts, getCachedUsers);
      return Right(postsUsersTuple);
    } on Exception catch (_) {
      return Left(LocalStorageFailure(message: _.toString()));
    }
  }

  Future<Either<Failure, Tuple2<Posts, Users>>> getLiveOrCachedPosts() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    bool isPostsAndUsersAvailable =
        _postDao.isPostsCacheAvailable && _userDao.isUsersCacheAvailable;

    if (!hasConnection && isPostsAndUsersAvailable) {
      return getCachedPostsUsers();
    }
    return getPosts();
  }
}
