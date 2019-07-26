import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/AirStation.dart';
import 'package:flutter_weather/Utils/StringUtils.dart';


class WeatherAirStationCard extends StatelessWidget{

  final AirStation airStation;

  WeatherAirStationCard(this.airStation);

  static const double AIR_STATION_CARD_WIDTH = 96;
  static const double AIR_STATION_CARD_HEIGHT = 120;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0
      ),
      child: Column(
        children: <Widget>[
          Text("空气监测站信息",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0
            ),
          ),
          _getContentWidget()
        ]
      ),
    );
  }

  Widget _getContentWidget(){
    if(airStation == null || airStation.itemList.length <= 0){
      return _getEmptyHintWidget();
    }else{
      return Container(
        height: AIR_STATION_CARD_HEIGHT,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: _getWidgetItemList(),
        ),
      );
    }
  }

  List<Widget> _getWidgetItemList(){
    List<Widget> resultList = [];
    for(AirStationItem item in airStation.itemList){
      resultList.add(_getWidgetItem(item));
    }
    return resultList;
  }

  Widget _getWidgetItem(AirStationItem item){
    return Container(
      width: AIR_STATION_CARD_WIDTH,
      height: AIR_STATION_CARD_HEIGHT,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(item.airQuality,
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 36
              ),
            ),
            Text(item.aqi,
              style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12
              ),
            ),
            Text(item.stationName,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12
              ),
            ),
          ],
        ),
      )
    );
  }










  List<Widget> _getAirStationWidgetList(){
    List<Widget> resultList = [];
    if(airStation == null || airStation.itemList.length <= 0){
      resultList.add(_getEmptyHintWidget());
    }else{
      if(airStation.itemList == null || airStation.itemList.length <= 0){
        resultList.add(_getAirStationEmptyHintWidget());
      }else{
        for(AirStationItem item in airStation.itemList){
          resultList.add(_getAirStationWidget(item));
        }
      }
    }
    return resultList;
  }

  Widget _getAirStationWidget(AirStationItem item){
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: 2
          ),
          child: Text(item.stationName,
            style: TextStyle(
                color: Colors.white,
                fontSize: 12.0
            ),
          ),
        ),
        Table(
          columnWidths: const {
            0 : FixedColumnWidth(120.0)
          },
          children: _getAirItem(item),
        )
      ]
    );
  }

  List<TableRow> _getAirItem(AirStationItem item){
    List<TableRow> resultList = [];
    if(StringUtils.isNotEmpty(item.updateTime)){
      resultList.add(_getAirItemTableRow("发布时间", item.updateTime));
    }
    if(StringUtils.isNotEmpty(item.stationID)){
      resultList.add(_getAirItemTableRow("站点ID", item.stationID));
    }
    if(StringUtils.isNotEmpty(item.stationLat) && StringUtils.isNotEmpty(item.stationLon)){
      resultList.add(_getAirItemTableRow("站点位置", "( ${item.stationLat} , ${item.stationLon} )"));
    }else{
      if(StringUtils.isNotEmpty(item.stationLat)){
        resultList.add(_getAirItemTableRow("站点经度", item.stationLat));
      }
      if(StringUtils.isNotEmpty(item.stationLon)){
        resultList.add(_getAirItemTableRow("站点纬度", item.stationLon));
      }
    }
    if(StringUtils.isNotEmpty(item.aqi)){
      resultList.add(_getAirItemTableRow("空气质量指数", item.aqi));
    }
    if(StringUtils.isNotEmpty(item.mainPolution)){
      resultList.add(_getAirItemTableRow("主要污染物", item.mainPolution));
    }
    if(StringUtils.isNotEmpty(item.airQuality)){
      resultList.add(_getAirItemTableRow("空气质量", item.airQuality));
    }
    if(StringUtils.isNotEmpty(item.pm10)){
      resultList.add(_getAirItemTableRow("PM10", item.pm10));
    }
    if(StringUtils.isNotEmpty(item.pm25)){
      resultList.add(_getAirItemTableRow("PM25", item.pm25));
    }
    if(StringUtils.isNotEmpty(item.no2)){
      resultList.add(_getAirItemTableRow("二氧化氮", item.no2));
    }
    if(StringUtils.isNotEmpty(item.so2)){
      resultList.add(_getAirItemTableRow("二氧化硫", item.so2));
    }
    if(StringUtils.isNotEmpty(item.co)){
      resultList.add(_getAirItemTableRow("一氧化碳", item.co));
    }
    if(StringUtils.isNotEmpty(item.o3)){
      resultList.add(_getAirItemTableRow("臭氧", item.o3));
    }
    return resultList;
  }

  TableRow _getAirItemTableRow(String title, String value){
    return TableRow(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(title,
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(value,
              style: TextStyle(
                color: Colors.white70,
              ),
            ),
          ),
        ]
    );
  }

  Widget _getEmptyHintWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Text("暂无空气监测站信息",
        style: TextStyle(
            color: Colors.white
        ),
      ),
    );
  }

  Widget _getAirStationEmptyHintWidget(){
    return Text("此空气监测站暂无检测信息",
      style: TextStyle(
        color: Colors.white
      ),
    );
  }

}

