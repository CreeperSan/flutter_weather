import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/Air.dart';
import 'package:flutter_weather/Utils/StringUtils.dart';


class WeatherAirCard extends StatelessWidget{

  final Air air;

  WeatherAirCard(this.air);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0
      ),
      child: Column(
        children: <Widget>[
          Text("空气质量",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: 4.0
            ),
            child: Table(
              columnWidths: const{
                0 : FixedColumnWidth(120),
              },
              children: _getTableRowList(),
            ),
          )
        ]
      ),
    );
  }

  List<TableRow> _getTableRowList(){
    List<TableRow> resultList = [];
    if(air != null){
      if(StringUtils.isNotEmpty(air.updateTime)){
        resultList.add(_getTableRow("发布时间", air.updateTime));
      }
      if(StringUtils.isNotEmpty(air.aqi)){
        resultList.add(_getTableRow("空气质量指数", air.aqi));
      }
      if(StringUtils.isNotEmpty(air.mainPolution)){
        resultList.add(_getTableRow("主要污染物", air.mainPolution));
      }
      if(StringUtils.isNotEmpty(air.airQuality)){
        resultList.add(_getTableRow("空气质量", air.airQuality));
      }
      if(StringUtils.isNotEmpty(air.pm10)){
        resultList.add(_getTableRow("PM10", air.pm10));
      }
      if(StringUtils.isNotEmpty(air.pm25)){
        resultList.add(_getTableRow("PM25", air.pm25));
      }
      if(StringUtils.isNotEmpty(air.no2)){
        resultList.add(_getTableRow("二氧化氮", air.no2));
      }
      if(StringUtils.isNotEmpty(air.so2)){
        resultList.add(_getTableRow("二氧化硫", air.so2));
      }
      if(StringUtils.isNotEmpty(air.co)){
        resultList.add(_getTableRow("一氧化碳", air.co));
      }
      if(StringUtils.isNotEmpty(air.o3)){
        resultList.add(_getTableRow("臭氧", air.o3));
      }
    }else{
      resultList.add(_getEmptyTableRow());
    }
    return resultList;
  }

  TableRow _getTableRow(String title, String value){
    return TableRow(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(title,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(value,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ]
    );
  }

  TableRow _getEmptyTableRow(){
    return TableRow(
      children: [
        Align(
          alignment: Alignment.center,
          child: Text("暂无空气质量信息",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ]
    );
  }

}

