import 'package:blog_app/core/ui/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ui/widgets/app_spacing.dart';
import '../../../shared/model/post.dart';
import '../../../shared/model/user.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    this.showBookmarkedStatus = false,
    required this.post,
    required this.users,
    this.onBookmarkPressed,
  });

  final bool showBookmarkedStatus;
  final Post post;
  final Users users;
  final VoidCallback? onBookmarkPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: context.width,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // pic view
              Container(
                height: 100,
                width: 120,
                decoration: BoxDecoration(
                  border: Border.all(),
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),

              const HorizontalSpace(
                size: 10,
              ),

              // column with title, author
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: context.width * 0.40,
                    height: 30,
                    child: Text(
                      post.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const VerticalSpace(
                    size: 5,
                  ),
                  Text(users.users[post.userId - 1].name,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),

              const Spacer(),

              showBookmarkedStatus
                  ? IconButton(
                      onPressed: onBookmarkPressed ?? () {},
                      icon: const Icon(
                        Icons.bookmark,
                        color: Colors.teal,
                      ))
                  : const SizedBox(),
            ],
          ),

          const VerticalSpace(
            size: 10,
          ),

          // short blog details text
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              post.body,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.justify,
            ),
          ),
        ],
      ),
    );
  }
}
