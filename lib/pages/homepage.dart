import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/widgets/custom_searchbar.dart';

import '../provider/weather_provider.dart';
import '../widgets/current_weather_detail.dart';
import '../widgets/current_weather_info.dart';
import '../widgets/seven_day_forecast.dart';
import '../widgets/weather_info_header.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key, required this.title});

  final String title;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  FloatingSearchBarController searchBarController = FloatingSearchBarController();

  @override
  void initState() {
    super.initState();
    requestWeather();
  }

  Future<void> requestWeather() async {
    await Provider.of<WeatherProvider>(context, listen: false)
        .getWeatherData(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Consumer<WeatherProvider>(
          builder: (context, provider, _) {
            if (!provider.isLoading && !provider.isLocationserviceEnabled)
              return Container(); //location service error page

            if (!provider.isLoading &&
                provider.locationPermission != LocationPermission.always &&
                provider.locationPermission != LocationPermission.whileInUse) {
              return Container(); //location permission error page
            }

            if (provider.isRequestError) return Container(); //request error page

            if (provider.isSearchError) return Container(); //search error page

            return Stack(
              children: [
                ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(12.0).copyWith(
                    top: kToolbarHeight + MediaQuery.viewPaddingOf(context).top + 16.0,
                  ),
                  children: [
                    WeatherInfoHeader(),
                    const SizedBox(height: 16.0),
                    CurrentWeatherInfo(),
                    const SizedBox(height: 16.0),
                    CurrentWeatherDetail(),
                    const SizedBox(height: 24.0),
                    SevenDayForecast(),
                  ],
                ),
                CustomSearchBar(searchBarController: searchBarController)
              ],
            );
          }
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
