import 'package:flutter/material.dart';
import 'package:flutter_weather/Widget/HomePage/BasePager.dart';

class PagerIndicator extends StatelessWidget {

  int page;
  List<BasePager> pagerList;

  PagerIndicator(this.page, this.pagerList);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 16.0
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: _getIndicateList()
      ),
    );
  }

  List<Widget> _getIndicateList(){
    List<Widget> resultList = [];
    for(int i=0 ; i<pagerList.length ; i++){
      BasePager basePager = pagerList[i];
      resultList.add(_getIcon(basePager.getIcon(), _getColor(i)));
    }
    return resultList;
  }

  Widget _getIcon(IconData icon, Color color){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 2.0,
      ),
      child: Icon( icon,
        size: 16,
        color: color,
      ),
    );
  }

  Color _getColor(int i){
    return page == i ? Colors.white : Colors.white54;
  }

}
