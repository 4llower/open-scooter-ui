import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_scooter_ui/feature/presentation/widgets/balance_widget.dart';

class BalancePage extends StatelessWidget {
  const BalancePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(), child: BalanceWidget())),
      appBar: AppBar(),
    );
  }
}
