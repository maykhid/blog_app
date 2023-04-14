import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/typedefs.dart';

class PostsState extends Equatable {
  const PostsState._({
    this.message,
    this.postsUsersResponse,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final PostsWithUsers? postsUsersResponse;

  const PostsState.unknown() : this._();

  const PostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const PostsState.done({required PostsWithUsers response})
      : this._(status: DataResponseStatus.success, postsUsersResponse: response);

  const PostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, postsUsersResponse];
}
