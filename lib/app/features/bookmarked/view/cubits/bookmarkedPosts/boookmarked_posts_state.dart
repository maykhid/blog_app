import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../shared/model/post.dart';
import '../../../../shared/model/user.dart';

class BookmarkedPostsState extends Equatable {
  const BookmarkedPostsState._({
    this.message,
    this.bookmarkedPostsUsers,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final Tuple2<Posts, Users>? bookmarkedPostsUsers;

  const BookmarkedPostsState.unknown() : this._();

  const BookmarkedPostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const BookmarkedPostsState.done(
      {required Tuple2<Posts, Users> bookmarkedPostsUsers})
      : this._(
            status: DataResponseStatus.success,
            bookmarkedPostsUsers: bookmarkedPostsUsers);

  const BookmarkedPostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, bookmarkedPostsUsers];
}
