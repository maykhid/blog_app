import 'package:blog_app/app/features/bookmarked/data/repository/bookmark_repository.dart';
import 'package:blog_app/app/features/bookmarked/view/cubits/bookmarkedPosts/boookmarked_posts_state.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkedPostsCubit extends Cubit<BookmarkedPostsState> {
  BookmarkedPostsCubit({required BookmarkRepository bookmarkRepository})
      : _bookmarkRepository = bookmarkRepository,
        super(const BookmarkedPostsState.unknown());

  final BookmarkRepository _bookmarkRepository;

  Future<void> getBookmarkedPosts() async {
    emit(const BookmarkedPostsState.processing());
    final response = await _bookmarkRepository.getAllBookmarkedPosts();
    emit(response.fold(
        (error) => BookmarkedPostsState.failed(message: error.message),
        (res) => BookmarkedPostsState.done(bookmarkedPosts: res)));
  }

  void bookmarkPost(Post post) => _bookmarkRepository.bookmarkPost(post);

  void clearBookmarkedPost(int index) =>
      _bookmarkRepository.clearBookmarkedPost(index);
}
