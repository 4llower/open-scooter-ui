import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scanner_cubit/scanner_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scanner_cubit/scanner_state.dart';
import 'package:open_scooter_ui/locator_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanWidget extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    sl<ScannerCubit>()..reset();
    return Center(child: BlocBuilder<ScannerCubit, ScannerState>(
      builder: (context, state) {
        if (state is ScannerInitial) {
          return Column(
            children: <Widget>[
              Expanded(flex: 4, child: _buildQrView(context)),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    CustomButton(
                        heroTag: "flash",
                        onTap: () async =>
                            sl<ScannerCubit>()..toggleFlashLight(),
                        buttonIcon: Icons.flash_on_outlined),
                    CustomButton(
                        heroTag: "flip",
                        onTap: () async => sl<ScannerCubit>()..flipCamera(),
                        buttonIcon: Icons.flip_camera_android_outlined),
                  ],
                ),
              )
            ],
          );
        }
        if (state is ScannerScanned) {
          _returnCode(context, state.scannedCode);
          // return CircularProgressIndicator();
        }

        if (state is ScannerNoPermission) {
          return Text("No persmissions");
        }
        return Text("Scanner error");
      },
    ));
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;

    return QRView(
      key: qrKey,
      onQRViewCreated: (ctrl) => sl<ScannerCubit>()..onQRViewCreated(ctrl),
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) =>
          sl<ScannerCubit>()..onPermissionSet(context, ctrl, p),
    );
  }

  void _returnCode(BuildContext context, String? code) async {
    // Navigator.pop(context, code);
    Navigator.of(context)..pop(code);
  }
}

class CustomButton extends StatefulWidget {
  const CustomButton(
      {Key? key,
      this.buttonIcon = Icons.ac_unit,
      required this.onTap,
      this.heroTag})
      : super(key: key);

  final Function onTap;
  final IconData buttonIcon;
  final String? heroTag;

  IconData getIcon() {
    return buttonIcon;
  }

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isEnabled = false;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        heroTag: widget.heroTag == null ? "228" : widget.heroTag,
        backgroundColor: Colors.black,
        child: _getButtonIcon(),
        onPressed: () async => await _onTap());
  }

  Future<void> _onTap() async {
    await widget.onTap();
    setState(() {
      _isEnabled = _isEnabled ? false : true;
    });
  }

  Icon _getButtonIcon() {
    return Icon(
      widget.getIcon(),
      color: _isEnabled ? Colors.yellow : Colors.white,
    );
  }
}
