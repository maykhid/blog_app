import 'package:blog_app/app/features/shared/model/post.dart';

abstract class BookmarkDao {
  void bookmarkPost({required Post post});

  void clearBookmark({required int index});

  Posts? getAllBookmarkedPosts();
}
