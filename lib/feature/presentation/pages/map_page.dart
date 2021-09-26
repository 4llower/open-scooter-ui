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
      floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            FloatingActionButton(
                heroTag: "wallet",
                child: const Icon(Icons.wallet_giftcard_outlined),
                onPressed: () => {}),
            FloatingActionButton(
                heroTag: "qr",
                child: const Icon(Icons.qr_code_2_outlined),
                onPressed: () => {_navigateAndScanQR(context)})
          ]),
    );
  }

  void _navigateAndScanQR(BuildContext context) async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ScanPage()));
    if (result == null) {
      return;
    }
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$result')));
  }
}
