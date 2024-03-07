import 'package:flutter/material.dart';
import 'package:weather_app/themes/colors.dart';
import 'package:weather_app/themes/text_styles.dart';
import 'package:weather_app/utils/util.dart';

class CurrentWeatherDetail extends StatelessWidget {
  const CurrentWeatherDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: primaryPurple,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Current details',
            style: mediumText,
          ),
          const SizedBox(height: 16.0,),
          keyValue('Precipitation', '100%'),
          keyValue('UV Index', 'Low'),
          keyValue('Wind', '10 m/s'),
          keyValue('Humidity', '53%'),
          keyValue('Cloudiness', '100%')
        ],
      ),
    );
  }
}
