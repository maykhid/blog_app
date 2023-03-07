import 'package:blog_app/app/features/home/view/widgets/postcard_widget.dart';
import 'package:blog_app/app/features/shared/model/post.dart';
import 'package:flutter/material.dart';

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
        child: ListView.separated(
            separatorBuilder: (context, count) => const SizedBox.square(
                  dimension: 8,
                ),
            itemCount: 4,
            itemBuilder: (context, _) => const PostCard(showBookmarkedStatus: true, post: Post(userId: 1, id: 2, body: ''),)),
      ),
    );
  }
}
