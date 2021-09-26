import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scanner_cubit/scanner_state.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerCubit extends Cubit<ScannerState> {
  Barcode? result;
  Function? toggleFlash;
  Function? internalFlipCamera;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  ScannerCubit() : super((ScannerInitial()));

  void toggleFlashLight() async {
    await this.controller?.toggleFlash();
  }

  void flipCamera() async {
    await this.controller?.flipCamera();
  }

  void onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      result = scanData;
      emit(ScannerScanned(scannedCode: result?.code));
    });
    emit(ScannerInitial());
  }

  void onPermissionSet(
      BuildContext context, QRViewController ctrl, bool p) async {
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('no Permission')),
      );
      emit(ScannerNoPermission());
    }
  }

  void reset() {
    emit(ScannerInitial());
  }
}
