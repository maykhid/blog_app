import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';

part 'post.g.dart';

@HiveType(typeId: 1)
class Post extends Equatable {
  @HiveField(0)
  final int userId;
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String body;

  const Post({required this.userId, required this.id, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) =>
      Post(userId: json["userId"], id: json["id"], body: json["body"]);

  @override
  List<Object?> get props => [userId, id, body];
}

@HiveType(typeId: 0)
class Posts {
  @HiveField(0)
  List<Post> posts;

  Posts({required this.posts});

  factory Posts.fromJson(List<dynamic> data) =>
      Posts(posts: List<Post>.from(data.map((e) => Post.fromJson(e))));
}
