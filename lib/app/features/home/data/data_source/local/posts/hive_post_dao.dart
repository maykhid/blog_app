import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:hive_flutter/adapters.dart';

import 'post_dao.dart';

class HivePostDao implements PostDao {
  final Box<Posts> _postsBox;

  HivePostDao({required Box<Posts> postsBox}) : _postsBox = postsBox;

  static const String _postKey = '__post__key__';

  @override
  void cachePosts({required Posts posts}) => _postsBox.put(_postKey, posts);

  @override
  Posts? getCachedPosts() => _postsBox.get(_postKey);

  @override
  bool get isPostsCacheAvailable => _postsBox.isNotEmpty;
}
