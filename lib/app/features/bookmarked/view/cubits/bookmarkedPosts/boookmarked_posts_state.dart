import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/enums.dart';
import '../../../../shared/model/post.dart';

class BookmarkedPostsState extends Equatable {
  const BookmarkedPostsState._({
    this.message,
    this.bookmarkedPosts,
    this.status = DataResponseStatus.initial,
  });

  final DataResponseStatus status;
  final String? message;
  final Posts? bookmarkedPosts;

  const BookmarkedPostsState.unknown() : this._();

  const BookmarkedPostsState.processing()
      : this._(status: DataResponseStatus.processing);

  const BookmarkedPostsState.done({required Posts bookmarkedPosts})
      : this._(status: DataResponseStatus.success, bookmarkedPosts: bookmarkedPosts);

  const BookmarkedPostsState.failed({String? message})
      : this._(message: message, status: DataResponseStatus.error);

  @override
  List<Object?> get props => [status, message, bookmarkedPosts];
}