import 'package:blog_app/app/features/bookmarked/data/data_source/local/bookmark_dao.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../shared/model/post.dart';

class HiveBookmarkDao implements BookmarkDao {
  final Box<Post> _postBox;

  static String postKey = '__post__key__';

  HiveBookmarkDao({required Box<Post> postBox}) : _postBox = postBox;

  @override
  void clearBookmark({required int index}) => _postBox.deleteAt(index);

  @override
  void bookmarkPost({required String key, required Post post}) =>
      _postBox.add(post);

  @override
  Posts? getAllBookmarkedPosts({required String key}) =>
      Posts(posts: _postBox.values.toList());
}
