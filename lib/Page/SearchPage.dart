import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather/Utils/StringUtils.dart';
import 'package:flutter_weather/Manager/NetworkManager.dart';
import 'package:flutter_weather/Manager/ConfigManager.dart';
import 'package:dio/dio.dart';
import 'package:flutter_weather/Network/Response/SearchCityResponse.dart';
import 'package:flutter_weather/Bean/City.dart';
import 'package:flutter_weather/Static/RecommendCity.dart';
import 'package:flutter_weather/Widget/SearchPage/SearchPageItem.dart';
import 'package:flutter_weather/Manager/CacheManager.dart';

class SearchPage extends StatefulWidget{

  bool isSearching = false;

  SearchPageState state = SearchPageState();

  @override
  State<StatefulWidget> createState() {
    return state;
  }

}

class SearchPageState extends State<SearchPage>{
  TextEditingController _searchTextEditController = TextEditingController();
  CacheManager cacheManager = CacheManager.getInstance();
  CitySearch citySearch;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        // 触摸收起键盘
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: _onBackPressed,
          ),
          title: Text("添加城市"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0
              ),
              child: TextField(
                decoration: InputDecoration(
                    labelText: '请输入城市'
                ),
                onChanged: onSearchTextChange,
                controller: _searchTextEditController,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0
              ),
              child: Text(_getListViewLabelText(),
                style: TextStyle(
                    color: Colors.blueAccent
                ),
              ),
            ),
            _getContentView()
          ],
        ),
      ),
    );
  }

  void _onBackPressed(){
    Navigator.pop(context);
  }

  Widget _getContentView(){
    if(StringUtils.isEmpty(_getSearchString())){ // 还没有触发搜索
      return _generateRecommendCityWidget();
    }else if(widget.isSearching){ // 正在搜索
      return _generateSearchingWidget();
    }else if(_getCitySearch() == null || _getCitySearch().isEmpty()){ // 没有搜索到结果
      return _generateNoResultWidget();
    }else{ // 搜索到结果了
      return _generateSearchResultWidget();
    }
  }

  String _getListViewLabelText(){
    if(StringUtils.isEmpty(_getSearchString())){ // 还没有触发搜索
      return "热门城市";
    }else if(widget.isSearching){ // 正在搜索
      return "搜索中";
    }else if(_getCitySearch() == null || _getCitySearch().isEmpty()){ // 没有搜索到结果
      return "無結果";
    }else{ // 搜索到结果了
      return "搜索结果";
    }
  }

  Widget _generateRecommendCityWidget(){
    List<Widget> recommendCityList = [];
    for(int i=0; i<RecommendCity.RECOMMEND_CITY.length; i++){
      Map<String, String> itemMap = RecommendCity.RECOMMEND_CITY[i];
      String name = itemMap[RecommendCity.KEY_NAME];
      String code = itemMap[RecommendCity.KEY_CODE];
      recommendCityList.add(_generateCityChip(name, code));
    }
    return Align(
      alignment: Alignment.center,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: recommendCityList,
      ),
    );
  }

  Widget _generateCityChip(String cityName, String cityCode){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 2.0
      ),
      child: GestureDetector(
        onTap: ()=>_onCityChipClick(cityName, cityCode),
        child: Chip(
          avatar: Icon(Icons.location_city),
          label: Text(cityName),
        ),
      ),
    );
  }

  Widget _generateNoResultWidget(){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Icon( Icons.location_city,
            color: Colors.grey,
            size: 48.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 16.0
            ),
            child: Text( "没有搜索到结果",
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _generateSearchResultWidget(){
    return Expanded(
      child: ListView.builder(
          itemCount: _getCitySearch().size(),
          itemExtent: SearchPageItem.HEIGHT,
          itemBuilder: (context, index){
            final City city = _getCitySearch().get(index);
            return SearchPageItem(city, ()=>{
              _onCityTap(city)
            });
          }
      ),
    );
  }

  Widget _generateSearchingWidget(){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.symmetric(
                vertical: 16.0
            ),
            child: Text( "搜索中",
              style: TextStyle(
                  color: Colors.grey
              ),
            ),
          )
        ],
      ),
    );
  }
  //////////////////////////////   獲取信息   //////////////////////////////////
  String _getSearchString(){
    return _searchTextEditController.value.text;
  }

  void _setSearchString(String search){
    _searchTextEditController.value = TextEditingValue(text: search);
  }

  CitySearch _getCitySearch(){
    return citySearch;
  }

  void _setCitySearch(CitySearch citySearch){
    this.citySearch = citySearch;
  }

  //////////////////////////////   事件函數   //////////////////////////////////
  void _onCityChipClick(String name, String code){
    setState(() {
      _setSearchString(code);
      widget.isSearching = true;
    });
    _searchResult();
  }

  void _searchResult() async {
    // 防止搜索空字符串
    String cityCode = _getSearchString();
    if(cityCode.isEmpty){
      setState(() {
        widget.isSearching = false;
      });
      return;
    }
    // 進入搜索
    NetworkManager networkManager = NetworkManager.getInstance();
    ConfigManager configManager = ConfigManager.getInstance();
    SearchCityResponse searchCityResponse;
    try{
      Response response = await networkManager.getCity(configManager.getKey(), _getSearchString());
      searchCityResponse = SearchCityResponse.fromResponse(response);
    }catch(e){
      setState(() {
        _setCitySearch(null);
        widget.isSearching = false;
      });
      return;
    }
    // 設置狀態
    setState(() {
      _setCitySearch(searchCityResponse.citySearch);
      widget.isSearching = false;
    });
  }

  void onSearchTextChange(String search) async {
    setState(() {
      widget.isSearching = true;
    });
    _searchResult();
  }

  void _onCityTap(City city){
    showDialog(
      context: context,
      builder:(dialogContext){
        return AlertDialog(
          title: Text('添加城市'),
          content: Text('要添加城市 ${city.location} 吗？'),
          actions: <Widget>[
            FlatButton(
              child: Text('添加'),
              onPressed: (){
                Navigator.of(dialogContext).pop();
                _addCity(city);
              },
            ),
            FlatButton(
              child: Text('取消'),
              onPressed: (){
                Navigator.of(dialogContext).pop();
              },
            )
          ],
        );
      }
    );
    print('点击了 ${city.location}');
  }

  void _addCity(City city) async {
    // 提示
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext){
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text('添加城市'),
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 16.0
                  ),
                  child: Text('正在添加城市 ${city.location}'),
                )
              ],
            ),
          ),
        );
      }
    );
    // 添加
    try{
      await cacheManager.addCity(city);
      Navigator.of(context).pop();
      simpleAlert("添加成功", '城市 ${city.location} 添加成功');
    }catch(e){
      Navigator.of(context).pop();
      simpleAlert("添加失败", '城市 ${city.location} 添加失败');
    }
  }

  void simpleAlert(String title, String content){
    showDialog(
      context: context,
      builder: (dialogContext){
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            FlatButton(
              child: Text("确定"),
              onPressed: (){
                Navigator.of(dialogContext).pop();
              },
            )
          ],
        );
      }
    );
  }

}
