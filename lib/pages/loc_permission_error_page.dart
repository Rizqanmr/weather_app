import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/themes/colors.dart';

import '../provider/weather_provider.dart';
import '../themes/text_styles.dart';

class LocationPermissionErrorPage extends StatelessWidget {
  const LocationPermissionErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<WeatherProvider>(builder: (context, provider, _) {
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
              child: SvgPicture.asset('assets/images/loc_permission.svg'),
            ),
            Center(
              child: Text(
                'Location Permission Error',
                style: boldText.copyWith(color: primaryPurple),
              ),
            ),
            const SizedBox(height: 4.0),
            Center(
              child: Text(
                provider.locationPermission == LocationPermission.deniedForever
                    ? 'Location permissions are permanently denied, Please enable manually from app settings and restart the app'
                    : 'Location permission not granted, please check your location permission',
                style: mediumText.copyWith(color: Colors.grey.shade700),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              width: MediaQuery.sizeOf(context).width / 2,
              child: Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryPurple,
                      textStyle: mediumText,
                      padding: const EdgeInsets.all(12.0),
                      shape: StadiumBorder(),
                    ),
                    onPressed: provider.isLoading
                        ? null
                        : () async {
                            if (provider.locationPermission ==
                                LocationPermission.deniedForever) {
                              await Geolocator.openAppSettings();
                            } else {
                              provider.getWeatherData(context, notify: true);
                            }
                          },
                    child: provider.isLoading
                        ? const SizedBox(
                            width: 16.0,
                            height: 16.0,
                            child: CircularProgressIndicator(
                              strokeWidth: 3.0,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            provider.locationPermission ==
                                    LocationPermission.deniedForever
                                ? 'Open App Settings'
                                : 'Request Permission',
                          ),
                  ),
                  const SizedBox(height: 4.0),
                  if (provider.locationPermission ==
                      LocationPermission.deniedForever)
                    TextButton(
                      style: TextButton.styleFrom(foregroundColor: primaryPurple),
                      child: Text('Restart'),
                      onPressed: provider.isLoading
                          ? null
                          : () =>
                              provider.getWeatherData(context, notify: true),
                    )
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
