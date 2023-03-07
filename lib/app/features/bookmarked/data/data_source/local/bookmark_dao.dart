import 'package:blog_app/app/features/shared/model/post.dart';

abstract class BookmarkDao {
  void bookmarkPost({required Post post});

  void clearBookmarkedPost({required int index});

  Posts? getAllBookmarkedPosts();
}
