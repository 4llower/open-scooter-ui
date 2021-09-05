import 'package:flutter/cupertino.dart';

import 'common.dart';

class UserModel extends ChangeNotifier {
  final String _phone = '';
  Location _location = null as Location;
  List<Scooter> _booked = [];
}
