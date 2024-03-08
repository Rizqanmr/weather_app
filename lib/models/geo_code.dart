import 'package:latlong2/latlong.dart';

class GeoCodeModel {
  String name;
  LatLng latLng;
  GeoCodeModel({
    required this.name,
    required this.latLng,
  });

  factory GeoCodeModel.fromJson(Map<String, dynamic> json) {
    return GeoCodeModel(
      name: json['name'],
      latLng: LatLng(json['lat'], json['lon']),
    );
  }
}