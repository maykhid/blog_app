import '../../../../../shared/model/post.dart';

abstract class PostDao {
  void cachePosts({required Posts posts});
  bool get isPostsCacheAvailable;
  Posts? getCachedPosts();
}
