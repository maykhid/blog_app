import 'package:blog_app/app/features/home/data/repository/post_repository.dart';
import 'package:blog_app/app/features/home/view/cubits/posts/posts_state.dart';
import 'package:bloc/bloc.dart';

class PostsCubit extends Cubit<PostsState> {
  PostsCubit({required PostRepository postRepository})
      : _postRepository = postRepository,
        super(const PostsState.unknown());

  final PostRepository _postRepository;

  Future<void> getPosts() async {
    emit(const PostsState.processing());
    final response = await _postRepository.getLiveOrCachedPosts();
    emit(response.fold((error) => PostsState.failed(message: error.message),
        (res) => PostsState.done(response: res)));
  }
}
