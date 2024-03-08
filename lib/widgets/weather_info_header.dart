import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/themes/colors.dart';
import 'package:weather_app/utils/constant.dart';

import '../themes/text_styles.dart';
import 'custom_shimmer.dart';

class WeatherInfoHeader extends StatelessWidget {
  static const double boxWidth = 52.0;
  static const double boxHeight = 40.0;

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(
      builder: (context, provider, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            provider.isLoading ?
            Expanded(
              child: CustomShimmer(
                height: 48.0,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ) : Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: '${provider.weatherModel.city}, ',
                          style: semiboldText,
                          children: [
                            TextSpan(
                              text: Country.tryParse(provider.weatherModel.countryCode)?.name,
                              style: regularText.copyWith(fontSize: 18.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 4.0),
                    FittedBox(
                      child: Text(
                        DateFormat('EEEE MMM dd, y  hh:mm a')
                            .format(DateTime.now()),
                        style: regularText.copyWith(
                            color: Colors.grey.shade700),
                      ),
                    )
                  ],
                )
            ),
            const SizedBox(width: 8.0,),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                padding: const EdgeInsets.all(4.0),
                color: Colors.grey.shade300,
                child: Stack(
                  children: [
                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 150),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: provider.isCelsius ? Offset(1.0, 0.0) : Offset(-1.0, 0.0),
                            end: Offset(0.0, 0.0),
                          ).animate(animation),
                          child: child,
                        );
                      },
                      child: provider.isCelsius ? GestureDetector(
                        key: ValueKey<int>(0),
                        child: Row(
                          children: [
                            Container(
                              height: boxHeight,
                              width: boxWidth,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: provider.isLoading ? Colors.grey : primaryPurple
                              ),
                            ),
                            Container(
                              height: boxHeight,
                              width: boxWidth,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                        onTap: () => provider.isLoading ? null : provider.switchTempUnit(),
                      ) : GestureDetector(
                        key: ValueKey<int>(1),
                        child: Row(
                          children: [
                            Container(
                              height: boxHeight,
                              width: boxWidth,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  color: Colors.grey.shade300
                              ),
                            ),
                            Container(
                              height: boxHeight,
                              width: boxWidth,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: provider.isLoading ? Colors.grey : primaryPurple,
                              ),
                            ),
                          ],
                        ),
                        onTap: () => provider.switchTempUnit(),
                      ),
                    ),
                    IgnorePointer(
                      child: Row(
                        children: [
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            child: Text(
                              celsiusDegree,
                              style: semiboldText.copyWith(
                                fontSize: 16,
                                color: provider.isCelsius ? Colors.white : Colors.grey.shade600,
                              ),
                            ),
                          ),
                          Container(
                            height: boxHeight,
                            width: boxWidth,
                            alignment: Alignment.center,
                            child: Text(
                              fahrenheitDegree,
                              style: semiboldText.copyWith(
                                fontSize: 16,
                                color: provider.isCelsius ? Colors.grey.shade600 : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
