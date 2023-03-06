import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int userId;
  final int id;
  final String body;

  const Post({required this.userId, required this.id, required this.body});

  factory Post.fromJson(Map<String, dynamic> json) =>
      Post(userId: json["userId"], id: json["id"], body: json["body"]);

  @override
  List<Object?> get props => [userId, id, body];
}

class Posts {
  List<Post> posts;

  Posts({required this.posts});

  factory Posts.fromJson(List<dynamic> data) =>
      Posts(posts: List<Post>.from(data.map((e) => Post.fromJson(e))));
}
