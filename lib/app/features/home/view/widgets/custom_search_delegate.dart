import 'package:blog_app/app/features/home/view/cubits/posts/posts_cubit.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:flutter/material.dart';

import 'postcard_widget.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required PostsCubit postsCubit})
      : _postsCubit = postsCubit;


  final PostsCubit _postsCubit;
  
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // Implement your search results here.
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.separated(
        itemCount: 3,
        separatorBuilder: (context, count) => const SizedBox.square(
          dimension: 8,
        ),
        itemBuilder: (context, count) => InkWell(
          onTap: () {},
          child: const PostCard(
            post: Post(userId: 1, id: 1, title: 'title', body: 'body'),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Implement your search suggestions here.
    return Text('Search suggestions: $query');
  }

  @override
  String get searchFieldLabel => 'Search';
}
