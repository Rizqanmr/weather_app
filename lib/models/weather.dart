import 'package:flutter/material.dart';

class WeatherModel with ChangeNotifier {
  final double temp;
  final double tempMax;
  final double tempMin;
  final double lat;
  final double long;
  final double feelsLike;
  final int pressure;
  final String description;
  final String weatherCategory;
  final int humidity;
  final double windSpeed;
  String city;
  final String countryCode;
  final int clouds;
  final int visibility;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherModel({
    required this.temp,
    required this.tempMax,
    required this.tempMin,
    required this.lat,
    required this.long,
    required this.feelsLike,
    required this.pressure,
    required this.description,
    required this.weatherCategory,
    required this.humidity,
    required this.windSpeed,
    required this.city,
    required this.countryCode,
    required this.clouds,
    required this.visibility,
    required this.sunrise,
    required this.sunset
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temp: (json['main']['temp']).toDouble(),
      tempMax: (json['main']['temp_max']).toDouble(),
      tempMin: (json['main']['temp_min']).toDouble(),
      lat: json['coord']['lat'],
      long: json['coord']['lon'],
      feelsLike: (json['main']['feels_like']).toDouble(),
      pressure: json['main']['pressure'],
      weatherCategory: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      humidity: json['main']['humidity'],
      windSpeed: (json['wind']['speed']).toDouble(),
      city: json['name'],
      countryCode: json['sys']['country'],
      clouds: json['clouds']['all'],
      visibility: json['visibility'],
      sunrise: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunrise'] * 1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(json['sys']['sunset'] * 1000)
    );
  }
}