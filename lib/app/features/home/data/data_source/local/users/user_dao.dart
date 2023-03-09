import '../../../../../shared/model/user.dart';

abstract class UserDao {
  void cacheUsers({required Users users});
  Users? getCachedUsers();
  bool get isUsersCacheAvailable;
}
