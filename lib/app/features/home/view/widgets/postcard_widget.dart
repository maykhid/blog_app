import 'package:blog_app/core/ui/extensions/sized_context.dart';
import 'package:flutter/material.dart';

import '../../../../../core/ui/widgets/app_spacing.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
    this.showBookmarkedStatus = false,
  });

  final bool showBookmarkedStatus;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210,
      width: context.width,
      padding: const EdgeInsets.all(15),
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
                width: 130,
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Title name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                  ),
                  Text('Author name',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                ],
              ),

              const Spacer(),

              showBookmarkedStatus
                  ? IconButton(
                      onPressed: () {}, icon: const Icon(Icons.bookmark))
                  : const SizedBox(),
            ],
          ),

          const VerticalSpace(
            size: 10,
          ),

          // short blog details text
          const Text(
            '''Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudiandae consequuntur voluptatum laborum numquam blanditiis harum quisquam eius sed odit fugiat iusto fuga praesentium optio, eaque rerum! Provident similique accusantium nemo autem. ''',
            overflow: TextOverflow.ellipsis,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
