import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:open_scooter_ui/feature/domain/entities/scooter_entity.dart';
import 'package:open_scooter_ui/feature/domain/usecases/get_all_scooters.dart';
import 'package:open_scooter_ui/feature/presentation/bloc/scooter_cubit/scooter_state.dart';

class ScooterCubit extends Cubit<ScooterState> {
  final GetAllScooters getAllScooters;
  GoogleMapController? controller;

  Location _location = Location();

  Set<Marker> markers = Set();

  ScooterCubit({required this.getAllScooters}) : super(ScooterEmpty());

  void loadScooters() async {
    if (state is ScooterLoading) return;

    emit(ScooterLoading());

    final failureOrScooter = await getAllScooters(GetAllScooterParams());
    BitmapDescriptor scooterIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(128.0, 128.0)), 'assets/icons/scooter.png');

    failureOrScooter.fold(
        (_) =>
            throw UnimplementedError('[Failure] ScooterCubit getAllScooters'),
        (resp) => {
          resp.forEach((element) {
            this._add(element, scooterIcon);
          }),
          emit(ScooterLoaded(scooterList: resp, markers: this.markers))
        });
  }

  void onMapCreated(GoogleMapController controller) {
    this.controller = controller;
    var subscription = this._location.onLocationChanged.listen((l) {});

    subscription = this._location.onLocationChanged.listen((l) {
      subscription.cancel();
      this.controller?.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                  // target: LatLng(l.latitude as double, l.longitude as double),
                  target: LatLng(53.893009, 27.567444),
                  zoom: 20),
            ),
          );
    });
  }

  void _add(ScooterEntity scooter, BitmapDescriptor icon) {

    final MarkerId markerId = MarkerId('marker_id_' + scooter.id.toString());

    final Marker marker = Marker(
      markerId: markerId,
      icon: icon,
      position: LatLng(scooter.location.lat, scooter.location.lng),
      infoWindow: InfoWindow(title: scooter.id.toString(), snippet: '*'),
    );

    this.markers.add(marker);
  }
}
