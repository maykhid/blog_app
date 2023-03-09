import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../shared/model/user.dart';

class PostsState extends Equatable {
  const PostsState._({
    this.message,
    this.postsUsersResponse,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final Tuple2<Posts, Users>? postsUsersResponse;

  const PostsState.unknown() : this._();

  const PostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const PostsState.done({required Tuple2<Posts, Users> response})
      : this._(status: DataResponseStatus.success, postsUsersResponse: response);

  const PostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, postsUsersResponse];
}
