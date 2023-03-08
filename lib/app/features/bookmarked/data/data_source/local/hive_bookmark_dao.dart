import 'package:blog_app/app/features/bookmarked/data/data_source/local/bookmark_dao.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../shared/model/post.dart';

class HiveBookmarkDao implements BookmarkDao {
  final Box<Post> _postBox;

  HiveBookmarkDao({required Box<Post> postBox}) : _postBox = postBox;

  @override
  void clearBookmarkedPost({required int index}) => _postBox.deleteAt(index);

  @override
  void bookmarkPost({required Post post}) => _postBox.add(post);

  @override
  Posts? getAllBookmarkedPosts() => Posts(posts: _postBox.values.toList());
}
