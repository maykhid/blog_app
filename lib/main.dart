import 'package:flutter/material.dart';

import 'app/app.dart';
import 'core/dependency_injector.dart';

Future<void> main() async {
  await setupLocator();

  runApp(const BlogApp());
}
