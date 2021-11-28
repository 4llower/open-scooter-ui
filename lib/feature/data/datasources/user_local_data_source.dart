import 'dart:convert';

import 'package:open_scooter_ui/core/error/exception.dart';
import 'package:open_scooter_ui/feature/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class UserLocalDataSource {
  Future<UserModel> getUserFromCache();
  Future<void> userToCache(UserModel user);
  Future<String> getTokenFromCache();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final Future<SharedPreferences> futurePrefs;

  static const CACHED_USER = 'CACHED_USER_INFO';
  static const CACHED_TOKEN = 'CACHED_TOKEN';

  UserLocalDataSourceImpl({required this.futurePrefs});

  @override
  Future<UserModel> getUserFromCache() async {
    final jsonUser = (await futurePrefs).getString(CACHED_USER);
    String user = jsonUser != null ? jsonUser : '';
    if (user.isNotEmpty) {
      return Future.value(UserModel.fromJson(json.decode(user)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> userToCache(UserModel user) async {
    final String jsonUser = json.encode(user.toJson());

    (await futurePrefs).setString(CACHED_USER, jsonUser);
    (await futurePrefs).setString(CACHED_TOKEN, user.token);
    return Future.value();
  }

  @override
  Future<String> getTokenFromCache() async {
    final jsonToken = (await futurePrefs).getString(CACHED_TOKEN);
    var token = jsonToken != null ? jsonToken : '';
    if (token.isNotEmpty) {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }
}
