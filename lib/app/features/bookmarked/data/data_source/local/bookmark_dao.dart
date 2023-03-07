import 'package:blog_app/app/features/shared/model/post.dart';

abstract class BookmarkDao {
  void bookmarkPost({required String key, required Post post});

  void clearBookmark({required int index});

  Posts? getAllBookmarkedPosts({required String key});
}
