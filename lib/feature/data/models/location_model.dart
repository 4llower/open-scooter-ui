import 'package:open_scooter_ui/feature/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required lat, required lng}) : super(lat: lat, lng: lng);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(lat: json['lat'], lng: json['lng']);
  }

  Map<String, dynamic> toJson() {
    return {'lat': this.lat, 'lng': this.lng};
  }
}
