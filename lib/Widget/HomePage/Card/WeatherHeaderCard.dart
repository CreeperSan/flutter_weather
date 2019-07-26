import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/Now.dart';
import 'package:flutter_weather/Utils/StringUtils.dart';


class WeatherHeaderCard extends StatelessWidget{

  final City city;
  final Now now;

  WeatherHeaderCard(this.city, this.now);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 256.0,
        horizontal: 16.0
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                bottom: 4.0
            ),
            child: Text( _getTemperatureString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 56
              ),
            ),
          ),
          Text( _getWeatherString(),
            style: TextStyle(
                color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  String _getTemperatureString(){
    if(now == null || now.fellingTemperature == null || now.fellingTemperature == ""){
      return "--";
    }else{
      return now.fellingTemperature;
    }
  }

  String _getWeatherString(){
    if(now == null || now.condTxt == null || now.condTxt == ""){
      return "--";
    }else{
      return now.condTxt;
    }
  }

}

