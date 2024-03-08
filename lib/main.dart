import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/pages/homepage.dart';
import 'package:weather_app/provider/weather_provider.dart';
import 'package:weather_app/utils/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: appName,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Homepage(title: appName),
        onGenerateRoute: (setting) {
          return MaterialPageRoute(builder: (_) => const Homepage(title: appName));
        },
      ),
    );
  }
}

