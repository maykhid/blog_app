import 'package:blog_app/app/features/bookmarked/data/data_source/local/bookmark_dao.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/model/error/failure.dart';
import '../../../shared/model/post.dart';

class BookmarkRepository {
  final BookmarkDao _bookmarkDao;

  BookmarkRepository({required BookmarkDao bookmarkDao})
      : _bookmarkDao = bookmarkDao;

  Future<Either<Failure, Posts>> getAllBookmarkedPosts() async {
    try {
      final getbookmarkedPosts = _bookmarkDao.getAllBookmarkedPosts();
      return Right(getbookmarkedPosts!);
    } on Exception catch (_) {
      return Left(LocalStorageFailure(message: _.toString()));
    }
  }

  void bookmarkPost(Post post) async {
    try {
      _bookmarkDao.bookmarkPost(post: post);
    } on Exception catch (_) {
      throw LocalStorageFailure(message: _.toString());
    }
  }

  void clearBookmarkedPost(int index) async {
    try {
      _bookmarkDao.clearBookmarkedPost(index: index);
    } on Exception catch (_) {
      throw LocalStorageFailure(message: _.toString());
    }
  }
}
