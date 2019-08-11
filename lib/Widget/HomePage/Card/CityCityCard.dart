import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Bean/CityWeather.dart';

class CityCityCard extends StatelessWidget{
   static const TYPE_ADD = 0;
   static const TYPE_CITY = 1;

  String title;
  String subtitle;
  Function onTap;
  Function onLongPress;
  final int type;

  CityCityCard(City city, String defaultName,{ this.onTap, this.onLongPress }) : this.type = TYPE_CITY {
    if(city != null){
      this.title = city.location;
      this.subtitle = "${city.country} - ${city.adminArea} - ${city.parentCity}";
    }else{
      this.title = defaultName;
      this.subtitle = "Loading Info...";
    }
  }

  CityCityCard.addCityCard({this.onTap}) : this.type = TYPE_ADD {
    this.title = "添加城市";
    this.subtitle = "";
  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Card(
          elevation: 8.0,
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6.0)),
          child: SizedBox(
            height: 96,
            child: Stack(
                children: <Widget>[
                  ConstrainedBox(
                    constraints: BoxConstraints.expand(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.network(
                        "http://bing.creepersan.com/bing-image/2019/07/21/400x240.jpg",
                        fit: BoxFit.cover,
                      )
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(title,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26.0
                                    ),
                                  ),
                                  Text(subtitle,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: type == TYPE_CITY ? 16.0 : 0
                                      )
                                  )
                                ]
                            ),
                          ),
                          Icon(
                            type == TYPE_CITY ? Icons.location_city : Icons.add,
                            color: Colors.white,
                            size: 48.0,
                          )
                        ],
                      )
                  )
                ]
            ),
          ),
        ),
      )
    );
  }
}
