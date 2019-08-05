import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_weather/Page/HomePage.dart';
import 'package:flutter_weather/Manager/ConfigManager.dart';
import 'package:flutter_weather/Manager/NetworkManager.dart';
import 'package:flutter_weather/Network/Response/SearchCityResponse.dart';

class SetupPage extends StatefulWidget{
  static const int USABLE_IDLE = 0;
  static const int USABLE_FAIL = 1;
  static const int USABLE_CHECKING = 2;
  static const int USABLE_SUCCESS = 3;

  int usableState = USABLE_IDLE;
  String apiKey = '';

  @override
  State<StatefulWidget> createState() {
    return SetupPageState();
  }
}

class SetupPageState extends State<SetupPage>{
  NetworkManager networkManager = NetworkManager.getInstance();
  ConfigManager configManager = ConfigManager.getInstance();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        body: Center(
          child: Center(
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("在您使用之前",
                    style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 24.0
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0,
                        left: 26.0,
                        right: 26.0
                    ),
                    child: Text('应用仅仅是对 和风天气 所提供的天气服务API（免费版）的数据解析，本身并不提供天气服务，因此需要一个可用的和风天气API Key。有关如何获取和风天气的API Key，你可以在 和风天气 官网注册并获取',
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Colors.grey
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.0,
                        bottom: 16.0
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 26.0
                      ),
                      child: Container(
                        height: 32.0,
                        child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  controller: controller,
                                  decoration: InputDecoration(
                                      hintText: '请输入Key'
                                  ),
                                ),
                              ),
                              FlatButton(
                                child: Text("检测可用性",
                                  style: TextStyle(
                                      color: Colors.blueAccent
                                  ),
                                ),
                                onPressed: _onCheckValidPress,
                              )
                            ]
                        ),
                      ),
                    ),
                  ),
                  _getUsableResultWidget()
                ]
            ),
          ),
        ),
      ),
    );
  }

  Widget _getUsableResultWidget(){
    switch(widget.usableState){
      case SetupPage.USABLE_IDLE :{
        return Text('等待输入');
      }
      case SetupPage.USABLE_CHECKING : {
        return Text("检测中...");
      }
      case SetupPage.USABLE_FAIL : {
        return Text("Key不可用，请检查输入和网络连接是否正常",
          style: TextStyle(
            color: Colors.redAccent
          ),
        );
      }
      case SetupPage.USABLE_SUCCESS : {
        return Padding(
          padding: EdgeInsets.only(
            top: 32.0
          ),
          child: RaisedButton(
            child: Text('GO'),
            onPressed: _onFinishPress,
          ),
        );
      }
    }
  }

  void _onCheckValidPress() async {
    if(widget.usableState == SetupPage.USABLE_CHECKING){
      return;
    }else{
      setState(() {
        widget.usableState = SetupPage.USABLE_CHECKING;
      });
    }
    // 检测
    String tmpKey = controller.text;
    widget.apiKey = controller.text;
    try{
      Response response = await networkManager.getCity(tmpKey, 'beijing');
      SearchCityResponse responseCity = SearchCityResponse.fromResponse(response);
      if(responseCity.citySearch.isEmpty()){
        setState(() {
          widget.usableState = SetupPage.USABLE_FAIL;
        });
      }else{
        setState(() {
          widget.usableState = SetupPage.USABLE_SUCCESS;
        });
      }
    }catch(e){
      setState(() {
        widget.usableState = SetupPage.USABLE_FAIL;
      });
    }
  }

  void _onFinishPress(){
    configManager.setKey(widget.apiKey);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
        builder: (BuildContext context) => HomePage()),
            (Route route) => route == null
    );
  }

}