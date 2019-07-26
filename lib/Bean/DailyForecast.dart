class DailyForecast{
  List<DailyForecastItem> itemList = [];

  clear(){
    itemList.clear();
  }

  add(DailyForecastItem item){
    itemList.add(item);
  }

  DailyForecastItem get(int index){
    return itemList[index];
  }

  int size(){
    return itemList.length;
  }

  DailyForecast.fromResponse(dynamic response){
    itemList.clear();
    if(response != null){
      for(dynamic responseItem in response){
        try{
          itemList.add(DailyForecastItem.fromResponse(responseItem));
        }catch(e){}
      }
    }
  }

}

class DailyForecastItem{
  final String date;                  // 日期
  final String sunRise;               // 日出时间
  final String sunSet;                // 日落时间
  final String moonRise;              // 月初时间
  final String moonSet;               // 月落时间
  final String temperatureMax;        // 最大温度
  final String temperatureMin;        // 最小温度
  final String condCodeDay;           // 白天天气代码
  final String condCodeNight;         // 晚上天气代码
  final String condTextDay;           // 白天天气文字
  final String condTextNight;         // 晚上天气文字
  final String windDegree;            // 风向角度
  final String windDirection;         // 风向文字
  final String windPower;             // 风力
  final String windSpeed;             // 风速
  final String humidity;              // 湿度
  final String percipitationAmount;   // 降水量
  final String percipitationPercent;  // 降水概率
  final String presure;               // 大气压强
  final String ux;                    // 紫外线
  final String visibility;            // 能见度

  DailyForecastItem({
    this.date,
    this.sunRise,
    this.sunSet,
    this.moonRise,
    this.moonSet,
    this.temperatureMax,
    this.temperatureMin,
    this.condCodeDay,
    this.condCodeNight,
    this.condTextDay,
    this.condTextNight,
    this.windDegree,
    this.windDirection,
    this.windPower,
    this.windSpeed,
    this.humidity,
    this.percipitationAmount,
    this.percipitationPercent,
    this.presure,
    this.ux,
    this.visibility
  });

  DailyForecastItem.fromResponse(dynamic response):
    this.date = response['date'],
    this.sunRise = response['sr'],
    this.sunSet = response['ss'],
    this.moonRise = response['mr'],
    this.moonSet = response['ms'],
    this.temperatureMax = response['tmp_max'],
    this.temperatureMin = response['tmp_min'],
    this.condCodeDay = response['cond_code_d'],
    this.condCodeNight = response['cond_code_n'],
    this.condTextDay = response['cond_txt_d'],
    this.condTextNight = response['cond_txt_n'],
    this.windDegree = response['wind_deg'],
    this.windDirection = response['wind_dir'],
    this.windPower = response['wind_sc'],
    this.windSpeed = response['wind_spd'],
    this.humidity = response['hum'],
    this.percipitationAmount = response['pcpn'],
    this.percipitationPercent = response['pop'],
    this.presure = response['pres'],
    this.ux = response['uv_index'],
    this.visibility = response['vis']
  ;
}