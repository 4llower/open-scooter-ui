import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scanner_cubit/scanner_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scanner_cubit/scanner_state.dart';
import 'package:open_scooter_ui/locator_service.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanWidget extends StatelessWidget {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ScannerCubit>(context).reset();
    return OrientationBuilder(
      builder: (context, orientation) {
        return Center(child: BlocBuilder<ScannerCubit, ScannerState>(
          builder: (context, state) {
            if (state is ScannerInitial || state is ScannerNoPermission) {
              bool permission = state is ScannerInitial ? true : false;
              return orientation == Orientation.portrait
                  ? Column(
                      children: [
                        Expanded(
                            flex: 4,
                            child: permission
                                ? _buildQrView(context)
                                : Text("No permission")),
                        _buildPanel(context, orientation)
                      ],
                    )
                  : Row(
                      children: [
                        Expanded(
                            flex: 4,
                            child: permission
                                ? _buildQrView(context)
                                : Text("No permission")),
                        _buildPanel(context, orientation),
                      ],
                    );
            }
            if (state is ScannerInput) {
              return _buildInputForm(context);
            }
            if (state is ScannerScanned) {
              _setCallBack(() {
                _returnCode(context, state.scannedCode);
                BlocProvider.of<ScannerCubit>(context).reset();
              });
              return CircularProgressIndicator();
              // return CircularProgressIndicator();
            }
            return Text("Scanner error");
          },
        ));
      },
    );
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

  Widget _buildPanel(BuildContext context, Orientation orientation) {
    var buttons = <Widget>[
      CustomButton(
          heroTag: "flash",
          onTap: () async => sl<ScannerCubit>()..toggleFlashLight(),
          buttonIcon: Icons.flash_on_outlined),
      FloatingActionButton(
          heroTag: "228",
          backgroundColor: Colors.black,
          child: const Icon(Icons.input_outlined, color: Colors.white),
          onPressed: () async => _showInputForm(context)),
    ];
    return Expanded(
      flex: 1,
      child: orientation == Orientation.portrait
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons)
          : Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: buttons),
    );
  }

  void _returnCode(BuildContext context, String? code) {
    Navigator.of(context)..pop(code);
  }

  void _showInputForm(BuildContext context) {
    BlocProvider.of<ScannerCubit>(context)..showInputForm();
  }

  Widget _buildInputForm(BuildContext context) {
    return Container(
        child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: TextFormField(
                            autofocus: true,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            validator: (value) =>
                                _handleValidation(value, context),
                            onChanged: (value) =>
                                _handleFormChange(value, context),
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Enter scooter ID",
                                labelText: "Scooter ID"))),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () => _handleFormSubmit(context),
                              child: Text("Submit")),
                          SizedBox(
                            width: 50,
                          ),
                          ElevatedButton(
                              onPressed: () => _handleFormCancel(context),
                              child: Text("Cancel"))
                        ],
                      ),
                    )
                  ],
                ))));
  }

  String? _handleFormChange(String? value, BuildContext context) {
    return BlocProvider.of<ScannerCubit>(context).inputChanged(value);
  }

  String? _handleValidation(String? value, BuildContext context) {
    return BlocProvider.of<ScannerCubit>(context).scooterIdValidation(value);
  }

  void _handleFormCancel(BuildContext context) {
    BlocProvider.of<ScannerCubit>(context).reset();
  }

  void _handleFormSubmit(BuildContext context) {
    BlocProvider.of<ScannerCubit>(context).submitInput();
  }

  void _setCallBack(Function callBack) {
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      callBack();
    });
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
