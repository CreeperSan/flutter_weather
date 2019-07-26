import 'package:dio/src/response.dart';
import 'package:flutter_weather/Network/Response/BaseResponse.dart';
import 'package:flutter_weather/Bean/City.dart';

class SearchCityResponse extends BaseResponse{
  SearchCityResponse.fromResponse(Response response) : super.fromResponse(response);

  CitySearch citySearch;

  @override
  parse() {
    print(response.data.toString());

    var json = this.response.data;
    var heWeatherJsonArray = json['HeWeather6'];
    var heWeatherJson = heWeatherJsonArray[0];
    // 城市
    var citySearchJsonArray = heWeatherJson['basic'];
    citySearch = CitySearch.fromResponse(citySearchJsonArray);
  }


}