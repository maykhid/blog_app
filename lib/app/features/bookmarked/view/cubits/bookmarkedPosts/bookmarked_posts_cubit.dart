import 'package:blog_app/app/features/bookmarked/data/repository/bookmark_repository.dart';
import 'package:blog_app/app/features/bookmarked/view/cubits/bookmarkedPosts/boookmarked_posts_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkedPostsCubit extends Cubit<BookmarkedPostsState> {
  BookmarkedPostsCubit({required BookmarkRepository bookmarkRepository})
      : _bookmarkRepository = bookmarkRepository,
        super(const BookmarkedPostsState.unknown());

  final BookmarkRepository _bookmarkRepository;

  Future<void> getBoormarkedPosts() async {
    emit(const BookmarkedPostsState.processing());
    final response = await _bookmarkRepository.getBookmardPosts();
    emit(response.fold(
        (error) => BookmarkedPostsState.failed(message: error.message),
        (res) => BookmarkedPostsState.done(bookmarkedPosts: res)));
  }
}
