import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_scooter_ui/feature/presentation/widgets/scan_widget.dart';

class ScanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ScanWidget(),
      ),
    );
  }
}
