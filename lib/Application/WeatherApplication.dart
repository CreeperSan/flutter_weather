import 'package:flutter/material.dart';
import 'package:flutter_weather/Page/BootPage.dart';

class WeatherApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BootPage(),
    );
  }
}

