import 'package:flutter/material.dart';
import 'package:weather_app/utils/ext.dart';

import '../themes/text_styles.dart';
import '../utils/util.dart';
import 'custom_shimmer.dart';

class CurrentWeatherInfo extends StatelessWidget {
  bool isLoading = false;
  bool isCelsius = false;
  String desc = "heavy intensity rain";
  double temp = 29.03;
  double feelLike = 32.98;

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: CustomShimmer(
                  height: 148.0,
                  width: 148.0,
                ),
              ),
              const SizedBox(width: 16.0),
              CustomShimmer(
                height: 148.0,
                width: 148.0,
              ),
            ],
          )
        : Padding(
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
                                isCelsius
                                    ? temp.toStringAsFixed(1)
                                    : temp.toFahrenheit().toStringAsFixed(1),
                                style: boldText.copyWith(fontSize: 60),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                isCelsius ? '°C' : '°F',
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
                                  text: isCelsius ? '${feelLike.toStringAsFixed(1)}°' : '${feelLike.toFahrenheit().toStringAsFixed(1)}°',
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
                        getWeatherImage('thunderstorm'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text(
                      desc.toTitleCase(),
                      style: regularText.copyWith(fontSize: 16),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
