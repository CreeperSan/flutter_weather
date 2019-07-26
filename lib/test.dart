import 'package:dio/dio.dart';
import 'package:flutter_weather/Manager/NetworkManager.dart';
import 'package:flutter_weather/Manager/ConfigManager.dart';
import 'package:flutter_weather/Network/Response/WeatherResponse.dart';
import 'package:flutter_weather/Network/Response/AirResponse.dart';
import 'package:flutter_weather/Network/Response/SearchCityResponse.dart';

void main() async {
  print("---------start---------");

  ConfigManager configManager = ConfigManager.getInstance();
  String key = configManager.getKey();

  Response responseAir = await NetworkManager.getInstance().getAirQuality(key, "shenzhen", language: NetworkManager.LANG_KOREAN);
  AirResponse airResponse = AirResponse.fromResponse(responseAir);
  print(airResponse);

  Response responseWeather = await NetworkManager.getInstance().getWeather(key, "shenzhen", language : NetworkManager.LANG_JAPANESE);
  WeatherResponse weatherResponse = WeatherResponse.fromResponse(responseWeather);
  print(weatherResponse);

  Response responseCity = await NetworkManager.getInstance().getCity(key, "shenzhen", language : NetworkManager.LANG_JAPANESE);
  SearchCityResponse cityResponse = SearchCityResponse.fromResponse(responseCity);
  print(cityResponse);

  print("---------end---------");

}