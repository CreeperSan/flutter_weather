import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/DailyForecast.dart';

class WeatherDailyForecastCard extends StatelessWidget{

  static const double CARD_HEIGHT = 180;
  static const double CARD_ITEM_WIDTH = 96.0;

  DailyForecast dailyForecast;

  WeatherDailyForecastCard(this.dailyForecast);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0
      ),
      child: Column(
        children: <Widget>[
          Text("天气预报",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0
            ),
          ),
          _getContentWidget()
        ],
      ),
    );
  }

  Widget _getContentWidget(){
    if(dailyForecast == null || dailyForecast.itemList == null && dailyForecast.itemList.length <= 0){
      return Padding(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0
        ),
        child: _getEmptyHint(),
      );
    }else{
      return Container(
        height: CARD_HEIGHT,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _getDailyForecastWidgetList(),
        ),
      );
    }
  }

  List<Widget> _getDailyForecastWidgetList(){
    List<Widget> resultList = [];
    if(dailyForecast == null || dailyForecast.itemList == null && dailyForecast.itemList.length <= 0){
      resultList.add(_getEmptyHint());
    }else{
      for(DailyForecastItem item in dailyForecast.itemList){
        if(item == null){
          resultList.add(_getDailyForecastEmptyHint());
        }else{
          resultList.add(_getDailyForecastWidget(item));
        }
      }
    }
    return resultList;
  }

  Widget _getEmptyHint(){
    return Text("暂无天气预报信息",
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget _getDailyForecastEmptyHint(){
    return Text("暂无此日的天气信息",
      style: TextStyle(
        color: Colors.white,
        fontSize: 10.0
      ),
    );
  }

  Widget _getDailyForecastWidget(DailyForecastItem item){
    return Container(
      width: CARD_ITEM_WIDTH,
      height: CARD_HEIGHT,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.network("https://ss1.baidu.com/6ONXsjip0QIZ8tyhnq/it/u=1471329049,2573563062&fm=58",
              width: 36,
              height: 36,
            ),
            Text(_getDualValueText(item.temperatureMin, item.temperatureMax),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                bottom: 4.0
              ),
              child: Text(_getDualValueText(item.condTextDay, item.condTextNight),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10.0
                ),
              ),
            ),
            Text( item.date,
              style: TextStyle(
                  color :Colors.white,
                  fontSize: 10.0
              ),
            )
          ],
        ),
      ),
    );
  }

  String _getDualValueText(String day, String night){
    return day == night ? day : "$day - $night";
  }

}
