import 'package:blog_app/app/features/bookmarked/view/cubits/bookmarkedPosts/boookmarked_posts_state.dart';
import 'package:blog_app/app/features/shared/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injector.dart';
import '../../../../../core/utils/enums.dart';
import '../../../home/view/widgets/postcard_widget.dart';
import '../cubits/bookmarkedPosts/bookmarked_posts_cubit.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocProvider<BookmarkedPostsCubit>(
          create: (ctx) => BookmarkedPostsCubit(bookmarkRepository: di())
            ..getBookmarkedPosts(),
          child: BlocConsumer<BookmarkedPostsCubit, BookmarkedPostsState>(
            listener: (context, state) {
              // listen and call when needed
            },
            builder: (context, state) {
              final bookmarkedPosts = state.bookmarkedPostsUsers != null
                  ? state.bookmarkedPostsUsers!.value1.posts
                  : [];

              final users = state.bookmarkedPostsUsers != null ? state.bookmarkedPostsUsers!.value2 : Users(users: []);

              switch (state.status) {
                // initial
                case DataResponseStatus.initial:

                // processing
                case DataResponseStatus.processing:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );

                // on error
                case DataResponseStatus.error:
                  return const Center(
                    child: Text(
                      'Could not load bookmarked posts!',
                    ),
                  );

                case DataResponseStatus.success:
                  if (bookmarkedPosts.isEmpty) {
                    return const Center(
                      child: Text(
                        'You do not have any bookmarked posts yet!',
                      ),
                    );
                  }
                  return ListView.separated(
                    separatorBuilder: (context, count) => const SizedBox.square(
                      dimension: 8,
                    ),
                    itemCount: bookmarkedPosts.length,
                    itemBuilder: (context, index) => PostCard(
                      showBookmarkedStatus: true,
                      post: bookmarkedPosts[index],
                      users: users,
                      onBookmarkPressed: () => _handleRemoveBookmark(
                          context.read<BookmarkedPostsCubit>(), index),
                    ),
                  );

                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  _handleRemoveBookmark(BookmarkedPostsCubit cubit, int index) => cubit
    ..clearBookmarkedPost(index)
    ..getBookmarkedPosts();
}
