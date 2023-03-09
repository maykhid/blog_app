import 'package:blog_app/app/features/bookmarked/view/cubits/bookmarkedPosts/bookmarked_posts_cubit.dart';
import 'package:blog_app/app/features/bookmarked/view/cubits/bookmarkedPosts/boookmarked_posts_state.dart';
import 'package:blog_app/core/ui/extensions/sized_context.dart';
import 'package:blog_app/core/ui/widgets/app_spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_share/social_share.dart';

import '../../../../../core/dependency_injector.dart';
import '../../../shared/model/post.dart';
import '../../../shared/model/user.dart';

class PostView extends StatefulWidget {
  const PostView({super.key, required this.post, required this.users});

  final Post post;
  final Users users;

  @override
  State<PostView> createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  late Post post;
  late Users users;

  @override
  void initState() {
    post = widget.post;
    users = widget.users;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: context.width * 0.3,
          child: Text(
            post.title,
          ),
        ),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // post image
            Container(
              height: 210,
              width: context.width,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(8),
              ),
            ),

            const VerticalSpace(
              size: 20,
            ),

            BlocProvider<BookmarkedPostsCubit>(
              create: (ctx) => BookmarkedPostsCubit(bookmarkRepository: di())
                ..getBookmarkedPosts(),
              child: BlocConsumer<BookmarkedPostsCubit, BookmarkedPostsState>(
                  listener: (context, state) {
                // listen and call when needed
              }, builder: (context, state) {
                List<Post> bookmarkedPosts = state.bookmarkedPostsUsers != null
                    ? state.bookmarkedPostsUsers!.value1.posts
                    : [];
                return SizedBox(
                  height: 50,
                  width: context.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.width * 0.60,
                            // height: 60,
                            child: Text(
                              post.title,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Text(
                            users.users[post.userId - 1].name,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      //
                      SizedBox(
                        // width: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () => SocialShare.shareOptions(
                                  'Read this blog post by: \n\n ${post.body} \n\n https://blogpost.inapp.url'),
                              icon: const Icon(
                                Icons.share,
                                color: Colors.teal,
                                size: 30,
                              ),
                            ),
                            const HorizontalSpace(
                              size: 25,
                            ),

                            // bookmark button
                            IconButton(
                              onPressed: () =>
                                  _isPostBookmarked(bookmarkedPosts)
                                      ? _handleRemoveBookmark(
                                          context.read<BookmarkedPostsCubit>(),
                                          bookmarkedPosts)
                                      : _handleBookmark(
                                          context.read<BookmarkedPostsCubit>()),
                              icon: Icon(
                                Icons.bookmark,
                                size: 30,
                                color: _isPostBookmarked(bookmarkedPosts)
                                    ? Colors.teal
                                    : Colors.black.withOpacity(0.4),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),

            const VerticalSpace(
              size: 20,
            ),

            Expanded(
              child: Text(
                '${post.body} ${post.body}',
                style: const TextStyle(fontSize: 20),
                textAlign: TextAlign.start,
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _isPostBookmarked(posts) => posts.contains(post);

  void _handleBookmark(BookmarkedPostsCubit bookmarkCubit) => bookmarkCubit
    ..bookmarkPost(post)
    ..getBookmarkedPosts();

  _handleRemoveBookmark(BookmarkedPostsCubit cubit, List<Post> posts) {
    int index = posts.indexWhere((p) => p == post);
    cubit
      ..clearBookmarkedPost(index)
      ..getBookmarkedPosts();
  }
}
