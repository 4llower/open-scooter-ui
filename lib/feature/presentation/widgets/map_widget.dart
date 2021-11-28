import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_state.dart';


class MapWidget extends StatelessWidget {
  // TODO: Add dotenv camera location and default zoom if not access
  static LatLng _initialCameraPosition = LatLng(50.893009, 25.567444);
  static double _defaultZoom = 20;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScooterCubit, ScooterState>(builder: (context, state) {
      if (state is ScooterEmpty) {
        return Text('Something went wrong:(');
      }

      if (state is ScooterLoading) {
        return Center(child: CircularProgressIndicator());;
      }

      if (state is ScooterLoaded) {
        // return Text(state.scooterList[0].chargeLevel.toString());
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(target: _initialCameraPosition, zoom: _defaultZoom),
          onMapCreated: (ctrl) => _onMapCreated(context, ctrl),
          markers: state.markers,
        );
      }

      return Text('Unexpected error');
    });
  }

  _onMapCreated(BuildContext context, GoogleMapController ctrl) {
    BlocProvider.of<ScooterCubit>(context)..onMapCreated(ctrl);
  }
}
