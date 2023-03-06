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
        child:
            ListView.builder(itemCount: 4, itemBuilder: (context, _) => const Text('Test')),
      ),
    );
  }
}
