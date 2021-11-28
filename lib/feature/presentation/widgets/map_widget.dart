import 'package:custom_info_window/custom_info_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_state.dart';

class MapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // TODO: Add dotenv camera location and default zoom if not access
  static LatLng _initialCameraPosition = LatLng(50.893009, 25.567444);
  static double _defaultZoom = 20;

  CustomInfoWindowController _customInfoWindowController =
      CustomInfoWindowController();

  @override
  void dispose() {
    _customInfoWindowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScooterCubit, ScooterState>(builder: (context, state) {
      if (state is ScooterEmpty) {
        return Text('Something went wrong:(');
      }

      if (state is ScooterLoading) {
        return Center(child: CircularProgressIndicator());
        ;
      }

      if (state is ScooterLoaded) {
        // return Text(state.scooterList[0].chargeLevel.toString());
        return Stack(children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
                target: _initialCameraPosition, zoom: _defaultZoom),
            onMapCreated: (ctrl) => _onMapCreated(context, ctrl),
            markers: state.markers,
            onTap: (position) {
              _customInfoWindowController.hideInfoWindow!();
            },
            onCameraMove: (position) {
              _customInfoWindowController.onCameraMove!();
            },
          ),
          CustomInfoWindow(
            controller: _customInfoWindowController,
            height: 96,
            width: 170,
            offset: 50,
          ),
        ]);
      }

      return Text('Unexpected error');
    });
  }

  _onMapCreated(BuildContext context, GoogleMapController ctrl) {
    _customInfoWindowController.googleMapController = ctrl;
    BlocProvider.of<ScooterCubit>(context)..onMapCreated(ctrl, _customInfoWindowController);
  }
}
