import 'package:blog_app/app/features/home/data/data_source/local/post_dao.dart';
import 'package:blog_app/app/features/home/data/data_source/remote/posts_api_client.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:blog_app/core/utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';

class PostRepository {
  final PostApiClient _postApiClient;
  final PostDao _postDao;

  PostRepository(
      {required PostApiClient dashboardApiClient, required PostDao postDao})
      : _postApiClient = dashboardApiClient,
        _postDao = postDao;

  Future<Either<Failure, Posts>> getPosts() async {
    try {
      final getPostsResponse = await _postApiClient.getPosts()
        ..log();

      // store posts locally
      _postDao.cachePosts(posts: getPostsResponse);

      return Right(getPostsResponse);
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

  Future<Either<Failure, Posts>> getCachedPosts() async {
    try {
      final getCachedPosts = _postDao.getCachedPosts()!..log();
      return Right(getCachedPosts);
    } on Exception catch (_) {
      return Left(LocalStorageFailure(message: _.toString()));
    }
  }

  Future<Either<Failure, Posts>> getLiveOrCachedPosts() async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (hasConnection && _postDao.isCacheAvailable) {
      return getCachedPosts();
    } else if (!hasConnection && _postDao.isCacheAvailable) {
      return getCachedPosts();
    }
    return getPosts();
  }
}
