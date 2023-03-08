import 'package:blog_app/core/model/error/failure.dart';
import 'package:blog_app/core/utils/extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../home/data/data_source/local/post_dao.dart';
import '../../../home/data/data_source/remote/posts_api_client.dart';
import '../../../shared/model/post.dart';

class SearchRepository {
  final PostApiClient _postApiClient;
  final PostDao _postDao;

  SearchRepository(
      {required PostApiClient postApiClient, required PostDao postDao})
      : _postApiClient = postApiClient,
        _postDao = postDao;

  Future<Either<Failure, Posts>> search(String searchTerm) async {
    try {
      List<Post> foundPosts = [];

      final getPostsResponse = await _postApiClient.getPosts()
        ..log();

      // store posts locally
      _postDao.cachePosts(posts: getPostsResponse);

      foundPosts = getPostsResponse.posts
          .where((post) =>
              post.title.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      return Right(Posts(posts: foundPosts));
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

  Future<Either<Failure, Posts>> searchOffline(String searchTerm) async {
    try {
      List<Post> foundPosts = [];

      final getPostsResponse = _postDao.getCachedPosts()!..log();

      foundPosts = getPostsResponse.posts
          .where((post) =>
              post.title.toLowerCase().contains(searchTerm.toLowerCase()))
          .toList();

      return Right(Posts(posts: foundPosts));
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }

   Future<Either<Failure, Posts>> seacrchLiveOrOfflinePosts(String searchTerm) async {
    bool hasConnection = await InternetConnectionChecker().hasConnection;
    if (!hasConnection && _postDao.isCacheAvailable) {
      return searchOffline(searchTerm);
    }
    return search(searchTerm);
  }
}
