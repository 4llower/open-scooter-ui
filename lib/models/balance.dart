import 'package:flutter/cupertino.dart';

import 'common.dart';

class BalanceModel extends ChangeNotifier {
  int _amount = 0;
  List<CreditCard> _cards = [];
  String _unit = 'BYN';

  int get amount => this._amount;
  set amount(int value) => this._amount = value;

  void topUp(CreditCard card, int value) {
    print('top up');
    amount = value;
    notifyListeners();
  }
}
