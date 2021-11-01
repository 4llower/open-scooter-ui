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
  String? formInput;
  final int idLength = 6;
  bool inputValidated = false;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  ScannerCubit() : super((ScannerInitial()));

  void toggleFlashLight() async {
    await this.controller?.toggleFlash();
  }

  void showInputForm() async {
    emit(ScannerInput());
  }

  String? inputChanged(String? value) {
    inputValidated = false;
    formInput = value;
  }

  String? scooterIdValidation(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter scooter ID";
    }
    if (int.tryParse(value) == null) {
      return "Wrong scooter ID format";
    }
    if (value.length > idLength) {
      return "Scooter number is too long";
    }
    if (value.length < idLength) {
      return "Scooter number is too short";
    }
    inputValidated = true;
    return null;
  }

  void submitInput() {
    emit(ScannerScanned(scannedCode: inputValidated ? formInput : null));
    // emit(ScannerNoPermission());
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
    formInput = "";
    emit(ScannerInitial());
  }
}
