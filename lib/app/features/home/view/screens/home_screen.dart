import 'package:flutter/material.dart';

import '../widgets/postcard_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
          itemBuilder: (context, count) => const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: PostCard(),
          ),
        ),
      ),
    );
  }
}

