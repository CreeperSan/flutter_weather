import 'package:flutter/material.dart';
import 'package:flutter_weather/Bean/City.dart';

class SearchPageItem extends StatelessWidget{

  static const double HEIGHT = 72.0;

  City city;
  GestureTapCallback onTap;

  SearchPageItem(this.city, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: 16.0
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 8.0
              ),
              child: Icon(Icons.location_city,
                size: 48.0,
              ),
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(city.location,
                    style: TextStyle(
                        fontSize: 16.0
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 6.0
                    ),
                    child: Text("${city.country} - ${city.adminArea} - ${city.parentCity}",
                      style: TextStyle(
                          fontSize: 12.0
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}

