import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/themes/colors.dart';

import '../provider/weather_provider.dart';
import '../themes/text_styles.dart';

class RequestErrorPage extends StatelessWidget {
  const RequestErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width,
              minWidth: 100,
              maxHeight: MediaQuery.sizeOf(context).height / 3,
            ),
            child: SvgPicture.asset('assets/images/error.svg'),
          ),
          Center(
            child: Text(
              'Request Error',
              style: boldText.copyWith(color: primaryPurple),
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: Text(
              'Request error, please check your internet connection',
              style: mediumText.copyWith(color: Colors.grey.shade700),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 16.0),
          Consumer<WeatherProvider>(builder: (context, provider, _) {
            return SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryPurple,
                  textStyle: mediumText,
                  padding: const EdgeInsets.all(12.0),
                  shape: StadiumBorder(),
                ),
                child: Text('Return Home'),
                onPressed: provider.isLoading
                    ? null
                    : () async {
                  await provider.getWeatherData(
                    context,
                    notify: true,
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}