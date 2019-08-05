import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/UpdateTime.dart';


class WeatherUpdateTimeCard extends StatelessWidget{

  final UpdateTime updateTime;

  WeatherUpdateTimeCard(this.updateTime);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 2.0,
        horizontal: 2.0
      ),
      child: Text( _getUpdateText(),
        style: TextStyle(
            color: Colors.white,
            fontSize: 10.0
        ),
      ),
    );
  }

  String _getUpdateText(){
    if(updateTime == null || updateTime.localTime == null){
      return "下拉刷新获取最新天气数据";
    }else{
      return "更新于当地时间 ${updateTime.localTime}";
    }
  }

}

