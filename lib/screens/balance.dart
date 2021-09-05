import 'package:flutter/cupertino.dart';

class Balance extends StatefulWidget {
  Balance({Key? key}) : super(key: key);

  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return Container(child: Text('Balance'));
  }
}
