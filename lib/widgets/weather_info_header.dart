import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/themes/colors.dart';

import '../themes/text_styles.dart';
import 'custom_shimmer.dart';

class WeatherInfoHeader extends StatelessWidget {
  static const double boxWidth = 52.0;
  static const double boxHeight = 40.0;
  bool isCelcius = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isLoading ? Expanded(
            child: CustomShimmer(
            height: 48.0,
            borderRadius: BorderRadius.circular(8.0),
          ),
        )
        : Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      text: 'Jakarta' ', ',
                      style: semiboldText,
                      children: [
                        TextSpan(
                          text: "Indonesia",
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
                            begin: isCelcius ? Offset(1.0, 0.0) : Offset(-1.0, 0.0),
                            end: Offset(0.0, 0.0),
                          ).animate(animation),
                        child: child,
                      );
                  },
                  child: isCelcius
                      ? GestureDetector(
                    key: ValueKey<int>(0),
                    child: Row(
                      children: [
                        Container(
                          height: boxHeight,
                          width: boxWidth,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: isLoading ? Colors.grey : primaryPurple
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
                    onTap: () => isLoading ? null : null,
                  )
                  : GestureDetector(
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
                            color: isLoading ? Colors.grey : primaryPurple,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => {},
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
                          '°C',
                          style: semiboldText.copyWith(
                            fontSize: 16,
                            color: isCelcius ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                      ),
                      Container(
                        height: boxHeight,
                        width: boxWidth,
                        alignment: Alignment.center,
                        child: Text(
                          '°F',
                          style: semiboldText.copyWith(
                            fontSize: 16,
                            color: isCelcius ? Colors.grey.shade600 : Colors.white,
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
  }
}
