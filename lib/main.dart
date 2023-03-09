import 'package:blog_app/app/features/shared/model/user.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'app/app.dart';
import 'app/features/shared/model/post.dart';
import 'core/dependency_injector.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final dbPath = join(dir.path, '.db.post');
  await Hive.initFlutter(dbPath);

  // register custom types
  Hive
    ..registerAdapter(PostsAdapter())
    ..registerAdapter(PostAdapter())
    ..registerAdapter(UserAdapter())
    ..registerAdapter(UsersAdapter());

  await setupLocator();

  runApp(const BlogApp());
}
