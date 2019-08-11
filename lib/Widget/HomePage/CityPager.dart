import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/CityWeather.dart';
import 'package:flutter_weather/Widget/HomePage/Card/CityCityCard.dart';
import 'package:flutter_weather/Widget/HomePage/BasePager.dart';
import 'package:flutter_weather/Widget/HomePage/WeatherPager.dart';
import 'package:flutter_weather/Page/SearchPage.dart';
import 'package:flutter_weather/Utils/UISizeUtils.dart';
import 'package:flutter_weather/Global/GlobalData.dart';

class CityPager extends BasePager{

  void Function(CityWeather, int) onCityClick;

  CityPager(this.onCityClick);

  @override
  String getName() {
    return "城市列表";
  }

  @override
  IconData getIcon() {
    return Icons.home;
  }

  @override
  State<StatefulWidget> createState() {
    return CityPagerState(onCityClick);
  }

}

class CityPagerState extends State<CityPager>  with AutomaticKeepAliveClientMixin{
  void Function(CityWeather, int) onCityClick;

  CityPagerState(this.onCityClick);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView(
      children: _getCityCardList(),
    );
  }

  List<Widget> _getCityCardList(){
    List<Widget> resultList = [];
    // 城市 卡片
    GlobalData globalData = GlobalData.getInstance();
    List<CityWeather> cityWeatherList = globalData.getCityWeatherList();
    for(int i=0; i<cityWeatherList.length; i++){
      CityWeather cityWeather = cityWeatherList[i];
      resultList.add(CityCityCard(
          globalData.getWeatherByCityID(cityWeather.getCid()).city,
        cityWeather.getCid(),
          onTap: () => {
            _onCityClick(globalData.getWeatherByCityID(cityWeather.getCid()), i)
          },
          onLongPress: ()=>{
            _onCityLongClick(i, cityWeather.getCid())
          },
      ));
    }
    // 添加城市 卡片
    resultList.add(CityCityCard.addCityCard(
        onTap: () => _onAddCityClick()
    ));
    return resultList;
  }

  void _onCityClick(CityWeather pager, int index){
    onCityClick(pager, index);
  }

  void _onCityLongClick(int index, String cid){
    showDialog(
      context: context,
      builder: (BuildContext context){
        GlobalData globalData = GlobalData.getInstance();
        CityWeather cityWeather = globalData.getWeatherByCityID(cid);
        String cityName = cid;
        if(cityWeather.city != null){
          cityName = cityWeather.city.location;
        }
        return AlertDialog(
          title: Text("删除城市"),
          content: Text("确定删除城市 $cityName 吗？"),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: (){
                globalData.removeCityWeatherByCityID(cid);
                Navigator.of(context).pop();
                setState(() {});
              },
            ),
            FlatButton(
              child: Text("取消"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      }
    );
  }

  void _onAddCityClick(){
    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchPage()));
  }

  @override
  bool get wantKeepAlive => true;

}
