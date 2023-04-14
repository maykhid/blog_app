import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../../../core/utils/typedefs.dart';

class BookmarkedPostsState extends Equatable {
  const BookmarkedPostsState._({
    this.message,
    this.bookmarkedPostsUsers,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final PostsWithUsers? bookmarkedPostsUsers;

  const BookmarkedPostsState.unknown() : this._();

  const BookmarkedPostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const BookmarkedPostsState.done(
      {required PostsWithUsers bookmarkedPostsUsers})
      : this._(
            status: DataResponseStatus.success,
            bookmarkedPostsUsers: bookmarkedPostsUsers);

  const BookmarkedPostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, bookmarkedPostsUsers];
}
