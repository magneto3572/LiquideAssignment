
import '../../domain/model/user_model.dart';

abstract class LoginLocalDataSource {
  /// Gets the cached user information
  /// Throws CacheException if no cached data is present
  Future<UserModel?> getLastLoggedInUser();

  /// Caches the user information
  Future<void> cacheUser(UserModel userModel);

  /// Clears the cached user information
  Future<void> clearUser();
}

class LocalDataSourceImpl implements LoginLocalDataSource {
  UserModel? _cachedUser;

  @override
  Future<UserModel?> getLastLoggedInUser() async {
    return _cachedUser;
  }

  @override
  Future<void> cacheUser(UserModel userModel) async {
    _cachedUser = userModel;
  }

  @override
  Future<void> clearUser() async {
    _cachedUser = null;
  }
}