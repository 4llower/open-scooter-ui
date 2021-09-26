import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});
}
