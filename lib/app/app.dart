import 'package:blog_app/core/ui/widgets/nav_bar.dart';
import 'package:flutter/material.dart';

import '../core/dependency_injector.dart';
import '../core/router/navigation_service.dart';

class BlogApp extends StatelessWidget {
  const BlogApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.teal,
      ),
      navigatorKey: di<NavigationService>().navigationKey,
      home: const BottomNavigation(),
    );
  }
}
