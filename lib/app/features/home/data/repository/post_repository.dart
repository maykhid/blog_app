import 'package:blog_app/app/features/home/data/data_source/remote/posts_api_client.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/model/error/exception.dart';
import '../../../../../core/model/error/failure.dart';

class PostRepository {
  final PostApiClient _postApiClient;

  PostRepository({required PostApiClient dashboardApiClient})
      : _postApiClient = dashboardApiClient;

  Future<Either<Failure, Posts>> getPosts() async {
    try {
      final getPostsResponse = await _postApiClient.getPosts();
      return Right(getPostsResponse);
    } on ServerException catch (_) {
      return Left(ServerFailure(message: _.message));
    }
  }
}
