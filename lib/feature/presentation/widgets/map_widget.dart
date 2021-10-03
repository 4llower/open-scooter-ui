import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_cubit.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_state.dart';

class MapWidget extends StatelessWidget {
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScooterCubit, ScooterState>(builder: (context, state) {
      if (state is ScooterEmpty) {
        return Text('Empty');
      }

      if (state is ScooterLoading) {
        return CircularProgressIndicator();
      }

      if (state is ScooterLoaded) {
        // return Text(state.scooterList[0].chargeLevel.toString());
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (ctrl) => _onMapCreated(context, ctrl),
        );
      }

      return Text('Unexpected error');
    });
  }

  _onMapCreated(BuildContext context, GoogleMapController ctrl) {
    BlocProvider.of<ScooterCubit>(context)..onMapCreated(ctrl);
  }
}
