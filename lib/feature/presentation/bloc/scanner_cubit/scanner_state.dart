import 'package:equatable/equatable.dart';

abstract class ScannerState extends Equatable {
  const ScannerState();

  @override
  List<Object> get props => [];
}

class ScannerInitial extends ScannerState {
  @override
  List<Object> get props => [];
}

class ScannerScanned extends ScannerState {
  final String? scannedCode;
  ScannerScanned({required this.scannedCode});

  @override
  List<Object> get props => [];
}

class ScannerNoPermission extends ScannerState {
  @override
  List<Object> get props => [];
}
