class AirStation{
  List<AirStationItem> itemList = [];

  clear(){
    itemList.clear();
  }

  add(AirStationItem item){
    itemList.add(item);
  }

  AirStationItem get(int index){
    return itemList[index];
  }

  int size(){
    return itemList.length;
  }

  AirStation.fromResponse(dynamic response){
    itemList.clear();
    for(dynamic item in response){
      itemList.add(AirStationItem.fromResponse(item));
    }
  }

}

class AirStationItem{
  final String stationName;    // 站点名称
  final String stationID;      // 站点ID
  final String stationLat;     // 站点经度
  final String stationLon;     // 站点纬度
  final String updateTime;     // 发布时间
  final String aqi;            // 空气质量指数
  final String mainPolution;   // 主要污染物
  final String airQuality;     // 空气质量
  final String pm10;           // PM10
  final String pm25;           // PM25
  final String no2;            // 二氧化氮
  final String so2;            // 二氧化硫
  final String co;             // 一氧化碳
  final String o3;             // 臭氧

  AirStationItem({
    this.stationName,
    this.stationID,
    this.stationLat,
    this.stationLon,
    this.updateTime,
    this.aqi,
    this.mainPolution,
    this.airQuality,
    this.pm10,
    this.pm25,
    this.no2,
    this.so2,
    this.co,
    this.o3
  });

  AirStationItem.fromResponse(dynamic response) :
    this.stationName = response['air_sta'],
    this.stationID = response['asid'],
    this.stationLat = response['lat'],
    this.stationLon = response['lon'],
    this.updateTime = response['pub_time'],
    this.aqi = response['aqi'],
    this.mainPolution = response['main'],
    this.airQuality = response['qlty'],
    this.pm10 = response['pm10'],
    this.pm25 = response['pm25'],
    this.no2 = response['no2'],
    this.so2 = response['so2'],
    this.co = response['co'],
    this.o3 = response['o3']
  ;

}