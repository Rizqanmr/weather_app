import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/themes/colors.dart';
import 'package:weather_app/themes/text_styles.dart';
import 'package:weather_app/utils/ext.dart';
import 'package:weather_app/utils/util.dart';
import 'package:weather_app/widgets/custom_shimmer.dart';

class CurrentWeatherDetail extends StatelessWidget {
  const CurrentWeatherDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return CustomShimmer(
          height: 200.0,
          borderRadius: BorderRadius.circular(16.0),
        );
      }
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: primaryPurple, borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current details',
              style: semiboldText,
            ),
            const SizedBox(
              height: 16.0,
            ),
            keyValue('Cloudiness', '${provider.weatherModel.clouds}%'),
            keyValue('Humidity', '${provider.weatherModel.humidity}%'),
            keyValue('Pressure', '${provider.weatherModel.pressure} mBar'),
            keyValue('Sunrise', DateFormat('hh:mm a').format(provider.weatherModel.sunrise)),
            keyValue('Sunset', DateFormat('hh:mm a').format(provider.weatherModel.sunset)),
            keyValue(
                'Temperature min',
                provider.isCelsius
                    ? '${provider.weatherModel.tempMin.toStringAsFixed(1)}°'
                    : '${provider.weatherModel.tempMin.toFahrenheit().toStringAsFixed(1)}°'
            ),
            keyValue(
                'Temperature max',
                provider.isCelsius
                    ? '${provider.weatherModel.tempMax.toStringAsFixed(1)}°'
                    : '${provider.weatherModel.tempMax.toFahrenheit().toStringAsFixed(1)}°'
            ),
            keyValue('Visibility', '${provider.weatherModel.visibility/1000} km'),
            keyValue('Wind', '${provider.weatherModel.windSpeed} m/s'),
          ],
        ),
      );
    });
  }
}
