import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Utils/StringUtils.dart';


class WeatherCityCard extends StatelessWidget{

  final City city;

  WeatherCityCard(this.city);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0
      ),
      child: Column(
        children: <Widget>[
          Text("城市信息",
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
    if(city != null){
      if(StringUtils.isNotEmpty(city.location)){
        resultList.add(_getTableRow("地区", city.location));
      }
      if(StringUtils.isNotEmpty(city.parentCity)){
        resultList.add(_getTableRow("城市", city.parentCity));
      }
      if(StringUtils.isNotEmpty(city.adminArea)){
        resultList.add(_getTableRow("省份", city.adminArea));
      }
      if(StringUtils.isNotEmpty(city.country)){
        resultList.add(_getTableRow("国家", city.country));
      }
      if(StringUtils.isNotEmpty(city.lat) && StringUtils.isNotEmpty(city.lon)){
        resultList.add(_getTableRow("位置", "( ${city.lat} , ${city.lon} )"));
      }
      if(StringUtils.isNotEmpty(city.timezone)){
        resultList.add(_getTableRow("时区", city.timezone));
      }
      if(StringUtils.isNotEmpty(city.cid)){
        resultList.add(_getTableRow("城市ID", city.cid));
      }
      if(StringUtils.isNotEmpty(city.type)){
        resultList.add(_getTableRow("类型", city.type));
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
          child: Text("暂无城市信息",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ]
    );
  }

}

