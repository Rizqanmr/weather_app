import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:weather_app/models/geo_code.dart';
import 'package:weather_app/models/weather.dart';
import 'package:weather_app/utils/constant.dart';

class WeatherProvider with ChangeNotifier {
  late WeatherModel weatherModel;
  LatLng? currentLocation;
  bool isLoading = false;
  bool isRequestError = false;
  bool isSearchError = false;
  bool isLocationserviceEnabled = false;
  LocationPermission? locationPermission;
  bool isCelsius = true;

  String get measurementUnit => isCelsius ? celsiusDegree : fahrenheitDegree;

  void switchTempUnit() {
    isCelsius = !isCelsius;
    notifyListeners();
  }

  Future<Position?> requestLocation(BuildContext context) async {
    isLocationserviceEnabled = await Geolocator.isLocationServiceEnabled();
    notifyListeners();

    if (!isLocationserviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location service disabled')),
      );
      return Future.error('Location services are disabled.');
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      isLoading = false;
      notifyListeners();
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Permission denied'),
        ));
        return Future.error('Location permissions are denied');
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      isLoading = false;
      notifyListeners();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Location permissions are permanently denied, Please enable manually from app settings',
        ),
      ));
      return Future.error('Location permissions are permanently denied');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> getWeatherData(BuildContext context, {
    bool notify = false,
  }) async {
    isLoading = true;
    isRequestError = false;
    isSearchError = false;
    if (notify) notifyListeners();

    Position? locData = await requestLocation(context);

    if (locData == null) {
      isLoading = false;
      notifyListeners();
      return;
    }

    try {
      currentLocation = LatLng(locData.latitude, locData.longitude);
      await getCurrentWeather(currentLocation!);
    } catch (e) {
      print(e);
      isRequestError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> getCurrentWeather(LatLng location) async {
    Uri url = Uri.parse(
      '${baseUrl}data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&units=metric&appid=$apiKey',
    );
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      weatherModel = WeatherModel.fromJson(extractedData);
      print('Fetched Weather for: ${weatherModel.city}/${weatherModel.countryCode}');
    } catch (error) {
      print(error);
      isLoading = false;
      this.isRequestError = true;
    }
  }

  Future<GeoCodeModel?> locationToLatLng(String location) async {
    try {
      Uri url = Uri.parse(
        '${baseUrl}geo/1.0/direct?q=$location&limit=5&appid=$apiKey',
      );
      final http.Response response = await http.get(url);
      if (response.statusCode != 200) return null;
      return GeoCodeModel.fromJson(
        jsonDecode(response.body)[0] as Map<String, dynamic>,
      );
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<void> searchWeather(String location) async {
    isLoading = true;
    notifyListeners();
    isRequestError = false;
    print('search');
    try {
      GeoCodeModel? geoCodeModel;
      geoCodeModel = await locationToLatLng(location);
      if (geoCodeModel == null) throw Exception('Unable to Find Location');
      await getCurrentWeather(geoCodeModel.latLng);
      // replace location name with data from geocode
      // because data from certain lat long might return local area name
      weatherModel.city = geoCodeModel.name;
    } catch (e) {
      print(e);
      isSearchError = true;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}