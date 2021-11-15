import 'dart:convert';

import 'package:open_scooter_ui/core/error/failure.dart';
import 'package:open_scooter_ui/feature/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUserFromCache();
  Future<void> userToCache(UserModel user);
}

const CACHED_USER_INFO = 'CACHED_USER_INFO';

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Future<SharedPreferences> futurePrefs;

  UserLocalDataSourceImpl({required this.futurePrefs});

  @override
  Future<UserModel> getUserFromCache() async {
    final jsonUser = (await futurePrefs).getString(CACHED_USER_INFO);
    String user = jsonUser != null ? jsonUser : '';
    if (user.isNotEmpty) {
      return Future.value(UserModel.fromJson(json.decode(user)));
    } else {
      throw CacheFailure();
    }
  }

  @override
  Future<void> userToCache(UserModel user) async {
    final String jsonUser = json.encode(user.toJson());

    (await futurePrefs).setString(CACHED_USER_INFO, jsonUser);
    return Future.value();
  }
}
