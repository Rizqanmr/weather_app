import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/themes/colors.dart';
import 'package:weather_app/utils/ext.dart';

import '../themes/text_styles.dart';
import '../utils/util.dart';
import 'custom_shimmer.dart';

class SevenDayForecast extends StatelessWidget {
  SevenDayForecast({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              PhosphorIcon(PhosphorIconsRegular.calendar),
              SizedBox(width: 4.0),
              Text('7-Day Forecast', style: semiboldText,),
              Spacer(),
            ],
          ),
        ),
        const SizedBox(height: 8.0),
        Container(
          child: Consumer<WeatherProvider>(
              builder: (context, provider, _) {
                if (provider.isLoading) {
                  return ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 7,
                    itemBuilder: (context, index) => CustomShimmer(
                      height: 82.0,
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    final currentDate = DateTime.now().add(Duration(days: index));
                    final dayName = DateFormat('EEEE').format(currentDate);

                    return Material(
                      borderRadius: BorderRadius.circular(12.0),
                      color: index.isEven ? primaryPurple : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 4,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  index == 0
                                      ? 'Today'
                                      : dayName,
                                  style: semiboldText,
                                  maxLines: 1,
                                ),
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 36.0,
                                  width: 36.0,
                                  child: Image.asset(
                                    getWeatherImage(provider.weatherModel.weatherCategory),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(height: 4.0),
                                Text(
                                  provider.weatherModel.weatherCategory,
                                  style: lightText,
                                ),
                              ],
                            ),
                            SizedBox(
                              width: MediaQuery.sizeOf(context).width / 5,
                              child: FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  provider.isCelsius
                                      ? '${provider.weatherModel.tempMax.toStringAsFixed(0)}°/${provider.weatherModel.tempMin.toStringAsFixed(0)}°'
                                      : '${provider.weatherModel.tempMax.toFahrenheit().toStringAsFixed(0)}°/${provider.weatherModel.tempMin.toFahrenheit().toStringAsFixed(0)}°',
                                  style: semiboldText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
          ),
        ),
      ],
    );
  }
}
