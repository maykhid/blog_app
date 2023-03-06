import 'package:blog_app/app/features/home/view/screens/postview_screen.dart';
import 'package:blog_app/core/router/navigation_service.dart';
import 'package:flutter/material.dart';

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
        child: ListView.separated(
          itemCount: 4,
          separatorBuilder: (context, count) => const SizedBox.square(
            dimension: 8,
          ),
          itemBuilder: (context, count) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: InkWell(
              onTap: () => navigationService.navigateToRoute(const PostView()),
              child: const PostCard(),
            ),
          ),
        ),
      ),
    );
  }
}
