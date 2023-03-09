import 'package:blog_app/app/features/home/data/data_source/local/users/user_dao.dart';
import 'package:blog_app/app/features/shared/model/user.dart';
import 'package:hive_flutter/adapters.dart';

class HiveUserDao implements UserDao {
  final Box<Users> _usersBox;

  HiveUserDao({required Box<Users> usersBox}) : _usersBox = usersBox;

  static const String _usersKey = '___users___key___';

  @override
  void cacheUsers({required Users users}) => _usersBox.put(_usersKey, users);

  @override
  Users? getCachedUsers() => _usersBox.get(_usersKey);

  @override
  bool get isUsersCacheAvailable => _usersBox.isNotEmpty;
}
