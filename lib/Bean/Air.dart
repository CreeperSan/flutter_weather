class Air{
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

  Air({
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

  Air.fromResponse(dynamic response) :
    this.aqi = response['aqi'],
    this.airQuality = response['qlty'],
    this.mainPolution = response['main'],
    this.pm25 = response['pm25'],
    this.pm10 = response['pm10'],
    this.no2 = response['no2'],
    this.so2 = response['so2'],
    this.co = response['co'],
    this.o3 = response['o3'],
    this.updateTime = response['pub_time']
  ;

}