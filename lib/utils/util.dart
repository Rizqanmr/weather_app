import 'package:flutter/material.dart';
import 'package:weather_app/themes/text_styles.dart';

String getWeatherImage(String input) {
  String weather = input.toLowerCase();
  String assetPath = 'assets/images/';
  switch (weather) {
    case 'thunderstorm':
      return '${assetPath}Storm.png';

    case 'drizzle':
    case 'rain':
      return '${assetPath}Rainy.png';

    case 'snow':
      return '${assetPath}Snow.png';

    case 'clear':
      return '${assetPath}Sunny.png';

    case 'clouds':
      return '${assetPath}Cloudy.png';

    case 'mist':
    case 'fog':
    case 'smoke':
    case 'haze':
    case 'dust':
    case 'sand':
    case 'ash':
      return '${assetPath}Fog.png';

    case 'squall':
    case 'tornado':
      return '${assetPath}StormWindy.png';

    default:
      return '${assetPath}Cloud.png';
  }
}

String uviValueToString(double uvi) {
  if (uvi <= 2) {
    return 'Low';
  } else if (uvi <= 5) {
    return 'Medium';
  } else if (uvi <= 7) {
    return 'High';
  } else if (uvi <= 10) {
    return 'Very High';
  } else if (uvi >= 11) {
    return 'Extreme';
  }
  return 'Unknown';
}

Widget keyValue(dynamic key, dynamic value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(key, style: regularText),
      Text(value, style: regularText)
    ],
  );
}