import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:weather_app/themes/colors.dart';
import 'package:weather_app/utils/ext.dart';

import '../themes/text_styles.dart';
import '../utils/util.dart';
import 'custom_shimmer.dart';

class SevenDayForecast extends StatelessWidget {
  SevenDayForecast({super.key});
  bool isCelsius = false;
  double tempMin = 29.03;
  double tempMax = 32.98;

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
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 7,
          itemBuilder: (context, index) {
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
                              : DateFormat('EEEE').format(DateTime.now()),
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
                            getWeatherImage('clear'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          'Clear',
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
                          isCelsius
                              ? '${tempMax.toStringAsFixed(0)}°/${tempMin.toStringAsFixed(0)}°'
                              : '${tempMax.toFahrenheit().toStringAsFixed(0)}°/${tempMin.toFahrenheit().toStringAsFixed(0)}°',
                          style: semiboldText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
