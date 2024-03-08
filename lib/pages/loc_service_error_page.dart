import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/themes/colors.dart';

import '../provider/weather_provider.dart';
import '../themes/text_styles.dart';

class LocationServiceErrorPage extends StatefulWidget {
  const LocationServiceErrorPage({Key? key}) : super(key: key);

  @override
  State<LocationServiceErrorPage> createState() =>
      _LocationServiceErrorPageState();
}

class _LocationServiceErrorPageState
    extends State<LocationServiceErrorPage> {
  late StreamSubscription<ServiceStatus> serviceStatusStream;

  @override
  void initState() {
    super.initState();
    serviceStatusStream = Geolocator.getServiceStatusStream().listen((_) {});
    serviceStatusStream.onData((ServiceStatus status) {
      if (status == ServiceStatus.enabled) {
        print('enabled');
        Provider.of<WeatherProvider>(context, listen: false)
            .getWeatherData(context);
      }
    });
  }

  @override
  void dispose() {
    serviceStatusStream.cancel();
    super.dispose();
  }

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
            child: SvgPicture.asset('assets/images/loc_permission.svg'),
          ),
          Center(
            child: Text(
              'Location Service Disabled',
              style: boldText.copyWith(color: primaryPurple),
            ),
          ),
          const SizedBox(height: 4.0),
          Center(
            child: Text(
              'Your device location service is disabled, please turn it on before continuing',
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
                child: Text('Turn On Service'),
                onPressed: () async {
                  await Geolocator.openLocationSettings();
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}