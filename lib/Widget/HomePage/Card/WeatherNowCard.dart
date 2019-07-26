import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/Now.dart';
import 'package:flutter_weather/Utils/StringUtils.dart';


class WeatherNowCard extends StatelessWidget{

  final Now now;

  WeatherNowCard(this.now);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0
      ),
      child: Column(
        children: <Widget>[
          Text("实况天气",
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
    if(now != null){
      if(StringUtils.isNotEmpty(now.cloud)){
        resultList.add(_getTableRow("云量", now.cloud));
      }
      if(StringUtils.isNotEmpty(now.condCode)){
        resultList.add(_getTableRow("天气代码", now.condCode));
      }
      if(StringUtils.isNotEmpty(now.condTxt)){
        resultList.add(_getTableRow("天气", now.condTxt));
      }
      if(StringUtils.isNotEmpty(now.fellingTemperature)){
        resultList.add(_getTableRow("体感温度", now.fellingTemperature));
      }
      if(StringUtils.isNotEmpty(now.humidity)){
        resultList.add(_getTableRow("湿度", now.humidity));
      }
      if(StringUtils.isNotEmpty(now.percipitationAmount)){
        resultList.add(_getTableRow("降水量", now.percipitationAmount));
      }
      if(StringUtils.isNotEmpty(now.pressure)){
        resultList.add(_getTableRow("大气压强", now.pressure));
      }
      if(StringUtils.isNotEmpty(now.tmp)){
        resultList.add(_getTableRow("温度", now.tmp));
      }
      if(StringUtils.isNotEmpty(now.visibility)){
        resultList.add(_getTableRow("能见度", now.visibility));
      }
      if(StringUtils.isNotEmpty(now.windDegree) && StringUtils.isNotEmpty(now.windDirection)){
        if(StringUtils.isNotEmpty(now.windDirection)){
          resultList.add(_getTableRow("风向", "${now.windDirection} ${now.windDegree}"));
        }
      }else{
        if(StringUtils.isNotEmpty(now.windDegree)){
          resultList.add(_getTableRow("风向角度", now.windDegree));
        }
        if(StringUtils.isNotEmpty(now.windDirection)){
          resultList.add(_getTableRow("风向", now.windDirection));
        }
      }
      if(StringUtils.isNotEmpty(now.windPower)){
        resultList.add(_getTableRow("风力", now.windPower));
      }
      if(StringUtils.isNotEmpty(now.windSpeed)){
        resultList.add(_getTableRow("风速", now.windSpeed));
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
          child: Text("暂无实况天气信息",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ]
    );
  }

}

