import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_weather/Manager/ConfigManager.dart';
import 'package:flutter_weather/Page/HomePage.dart';
import 'package:flutter_weather/Page/SetupPage.dart';
import 'package:flutter_weather/Manager/CacheManager.dart';
import 'package:flutter_weather/Global/GlobalData.dart';

class BootPage extends StatefulWidget{
  ConfigManager configManager = ConfigManager.getInstance();
  CacheManager cacheManager = CacheManager.getInstance();
  GlobalData globalData = GlobalData.getInstance();

  @override
  State<StatefulWidget> createState() {
    return BootPageState();
  }
}

class BootPageState extends State<BootPage>{
  @override
  void initState() {
    _checkEnvironment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.flag,
              size: 52.0,
              color: Colors.blueAccent,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8.0
              ),
              child: Text("天气",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16.0
                ),
              ),
            )
          ]
        ),
      ),
    );
  }

  void _checkEnvironment() async{
    await widget.configManager.init();
    await widget.cacheManager.init();
    await widget.globalData.init();
    // 跳转
    StatefulWidget pageTarget;
    String key = widget.configManager.getKey();
    if(key == null || key == ''){ // 跳转到输入key
      pageTarget = SetupPage();
    }else{ // 跳转到主界面
      pageTarget = HomePage();
    }
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => pageTarget),
            (Route route) => route == null
    );
  }

}
