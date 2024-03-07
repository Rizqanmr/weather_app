import 'package:flutter/material.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:weather_app/widgets/custom_searchbar.dart';

import '../widgets/current_weather_info.dart';
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(12.0).copyWith(
              top: kToolbarHeight + MediaQuery.viewPaddingOf(context).top,
            ),
            children: [
              WeatherInfoHeader(),
              const SizedBox(height: 16.0),
              CurrentWeatherInfo(),
              const SizedBox(height: 16.0),
              // MainWeatherDetail(),
              // const SizedBox(height: 24.0),
              // TwentyFourHourForecast(),
              // const SizedBox(height: 18.0),
              // SevenDayForecast(),
            ],
          ),
          CustomSearchBar(searchBarController: searchBarController)
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
