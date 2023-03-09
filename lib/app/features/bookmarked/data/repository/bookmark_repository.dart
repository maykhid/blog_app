import 'package:blog_app/app/features/bookmarked/data/data_source/local/bookmark_dao.dart';
import 'package:blog_app/app/features/home/data/data_source/local/users/user_dao.dart';
import 'package:dartz/dartz.dart';

import '../../../../../core/model/error/failure.dart';
import '../../../shared/model/post.dart';
import '../../../shared/model/user.dart';

class BookmarkRepository {
  final BookmarkDao _bookmarkDao;
  final UserDao _userDao;

  BookmarkRepository(
      {required BookmarkDao bookmarkDao, required UserDao userDao})
      : _bookmarkDao = bookmarkDao,
        _userDao = userDao;

  Future<Either<Failure, Tuple2<Posts, Users>>> getAllBookmarkedPosts() async {
    try {
      final getbookmarkedPosts = _bookmarkDao.getAllBookmarkedPosts();
      final getUsers = _userDao.getCachedUsers();

      // This exists as a fail safe just incase user cache 
      // is unavailable it can throw an exception
      if (_userDao.isUsersCacheAvailable) {
        return Right(Tuple2(getbookmarkedPosts!, getUsers!));
      }
      throw Exception('Could not get your bookmarks');
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
