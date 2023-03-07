import 'package:blog_app/app/features/bookmarked/data/data_source/local/bookmark_dao.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/model/error/failure.dart';
import '../../../shared/model/post.dart';

class BookmarkRepository {
  final BookmarkDao _bookmarkDao;

  BookmarkRepository({required BookmarkDao bookmarkDao})
      : _bookmarkDao = bookmarkDao;

  Future<Either<Failure, Posts>> getBookmardPosts() async {
    try {
      final getbookmarkedPosts =  _bookmarkDao.getAllBookmarkedPosts();
      return Right(getbookmarkedPosts!);
    } on Exception catch(_) {
      return Left(LocalStorageFailure(message: _.toString()));
    }
  }
}
