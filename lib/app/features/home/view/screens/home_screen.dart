import 'package:blog_app/app/features/home/view/cubits/posts/posts_cubit.dart';
import 'package:blog_app/app/features/home/view/cubits/posts/posts_state.dart';
import 'package:blog_app/app/features/home/view/screens/postview_screen.dart';
import 'package:blog_app/core/router/navigation_service.dart';
import 'package:blog_app/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injector.dart';
import '../widgets/postcard_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocProvider<PostsCubit>(
          create: (ctx) => PostsCubit(postRepository: di())..getPosts(),
          child:
              BlocConsumer<PostsCubit, PostsState>(listener: (context, state) {
            // listen and call when needed
          }, builder: (context, state) {
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
                  'Could not load posts!',
                ));

              // on success
              case DataResponseStatus.success:
                final postResponse = state.postsResponse!.posts;
                return ListView.separated(
                  itemCount: postResponse.length,
                  separatorBuilder: (context, count) => const SizedBox.square(
                    dimension: 8,
                  ),
                  itemBuilder: (context, count) => InkWell(
                    onTap: () =>
                        navigationService.navigateToRoute(const PostView()),
                    child: PostCard(
                      post: postResponse[count],
                    ),
                  ),
                );

              default:
                return Container();
            }
          }),
        ),
      ),
    );
  }
}
