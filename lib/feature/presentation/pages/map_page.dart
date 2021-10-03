import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_scooter_ui/feature/presentation/pages/scan_page.dart';
import 'package:open_scooter_ui/feature/presentation/widgets/map_widget.dart';

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: MapWidget(),
        ),
        appBar: AppBar(title: Center(child: Text("Open Scooter"))),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                bottom: 10,
                left: 20,
                child: FloatingActionButton(
                    heroTag: "balance",
                    child: const Icon(Icons.account_balance_wallet_outlined),
                    onPressed: () async =>
                        {Navigator.pushNamed(context, '/balance')})),
            Positioned(
                bottom: 10,
                right: 20,
                child: FloatingActionButton(
                    heroTag: "scan",
                    child: const Icon(Icons.qr_code_2_outlined),
                    onPressed: () => {_navigateAndScanQR(context)}))
          ],
        ));
  }

  void _navigateAndScanQR(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/scan');
    if (result == null) {
      return;
    }
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
