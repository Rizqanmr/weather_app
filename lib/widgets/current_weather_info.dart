import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/utils/constant.dart';
import 'package:weather_app/utils/ext.dart';

import '../themes/text_styles.dart';
import '../utils/util.dart';
import 'custom_shimmer.dart';

class CurrentWeatherInfo extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, provider, _) {
      if (provider.isLoading) {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: CustomShimmer(
                height: 148.0,
                width: 148.0,
              ),
            ),
            SizedBox(width: 16.0),
            CustomShimmer(
              height: 148.0,
              width: 148.0,
            ),
          ],
        );
      }
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80.0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            provider.isCelsius
                                ? provider.weatherModel.temp.toStringAsFixed(1)
                                : provider.weatherModel.temp.toFahrenheit().toStringAsFixed(1),
                            style: boldText.copyWith(fontSize: 60),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            provider.isCelsius ? celsiusDegree : fahrenheitDegree,
                            style: mediumText.copyWith(fontSize: 26),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                        text: 'Feels Like ',
                        style: lightText.copyWith(fontSize: 16),
                        children: [
                          TextSpan(
                              text: provider.isCelsius
                                  ? '${provider.weatherModel.feelsLike.toStringAsFixed(1)}°'
                                  : '${provider.weatherModel.feelsLike.toFahrenheit().toStringAsFixed(1)}°',
                              style: lightText.copyWith(fontSize: 16)
                          )
                        ]
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 80.0,
                  width: 80.0,
                  child: Image.asset(
                    getWeatherImage(provider.weatherModel.weatherCategory),
                    fit: BoxFit.cover,
                  ),
                ),
                Text(
                  provider.weatherModel.description.toTitleCase(),
                  style: regularText.copyWith(fontSize: 16),
                )
              ],
            ),
          ],
        ),
      );
    },
    );
  }
}
