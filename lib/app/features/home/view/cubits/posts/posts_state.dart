import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/enums.dart';

class PostsState extends Equatable {
  const PostsState._({
    this.message,
    this.postsResponse,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final Posts? postsResponse;

  const PostsState.unknown() : this._();

  const PostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const PostsState.done({required Posts response})
      : this._(status: DataResponseStatus.success, postsResponse: response);

  const PostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, postsResponse];
}
