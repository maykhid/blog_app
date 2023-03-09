import 'package:blog_app/app/features/home/view/cubits/posts/posts_cubit.dart';
import 'package:blog_app/app/features/home/view/cubits/posts/posts_state.dart';
import 'package:blog_app/app/features/home/view/screens/postview_screen.dart';
import 'package:blog_app/app/features/shared/widgets/app_snackbar.dart';
import 'package:blog_app/core/router/navigation_service.dart';
import 'package:blog_app/core/utils/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/dependency_injector.dart';
import '../../../search/view/screen/custom_search_delegate.dart';
import '../widgets/postcard_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NavigationService navigationService = di<NavigationService>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 8),
        child: BlocProvider<PostsCubit>(
          create: (ctx) => PostsCubit(postRepository: di())..getPostsUsers(),
          child:
              BlocConsumer<PostsCubit, PostsState>(listener: (context, state) {
            if (state.status == DataResponseStatus.error) {
              AppSnackBar.showErrorSnackBar(context, state.message!);
            }
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
                final postResponse = state.postsUsersResponse!.value1.posts;
                final userResponse = state.postsUsersResponse!.value2;
                return ListView.separated(
                  itemCount: postResponse.length,
                  separatorBuilder: (context, count) => const SizedBox.square(
                    dimension: 8,
                  ),
                  itemBuilder: (context, count) => InkWell(
                    onTap: () => navigationService.navigateToRoute(PostView(
                      post: postResponse[count],
                      users: userResponse,
                    )),
                    child: PostCard(
                      users: userResponse,
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
