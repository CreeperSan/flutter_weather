import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/LifeStyle.dart';

class WeatherLifeStyleCard extends StatelessWidget{

  LifeStyle lifeStyle;

  WeatherLifeStyleCard(this.lifeStyle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0
      ),
      child: Column(
        children: <Widget>[
          Text("生活指数",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0
            ),
          ),
          Column(
            children: _getLifeStyleWidgetList(),
          )
        ]
      ),
    );
  }

  List<Widget> _getLifeStyleWidgetList(){
    List<Widget> resultList = [];
    if(lifeStyle == null || lifeStyle.itemList.length <= 0){
      resultList.add(_getEmptyHintWidget());
    }else{
      for(LifeStyleItem item in lifeStyle.itemList){
        resultList.add(_getLifeStyleItemWidget(item));
      }
    }
    return resultList;
  }

  Widget _getLifeStyleItemWidget(LifeStyleItem lifeStyleItem){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              right: 4
            ),
            child: Image.network("https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3201029847,3663478470&fm=26&gp=0.jpg",
              width: 36.0,
              height: 36.0,
            ),
          ),
          Expanded(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("${lifeStyleItem.name} : ${lifeStyleItem.result}",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 1.0
                    ),
                    child: Text(lifeStyleItem.suggestion,
                      style: TextStyle(
                          color: Colors.white54,
                          fontSize: 11.0
                      ),
                    ),
                  )
                ]
            ),
          )
        ],
      ),
    );
  }

  Widget _getEmptyHintWidget(){
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4.0
      ),
      child: Text("暂无生活指数信息",
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }



}
