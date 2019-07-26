class Now{
  final String cloud; // 云量
  final String condCode; // 天气代码
  final String condTxt; // 天气文本
  final String fellingTemperature; // 体感温度
  final String humidity; // 湿度
  final String percipitationAmount; // 降水量
  final String pressure; // 大气压强
  final String tmp; // 温度
  final String visibility; // 能见度
  final String windDegree; // 风向角度
  final String windDirection; // 风向文本
  final String windPower; // 风力
  final String windSpeed; // 风速

  Now({
    this.cloud,
    this.condCode,
    this.condTxt,
    this.fellingTemperature,
    this.humidity,
    this.percipitationAmount,
    this.pressure,
    this.tmp,
    this.visibility,
    this.windDegree,
    this.windDirection,
    this.windPower,
    this.windSpeed
  });

  Now.fromResponse(dynamic response):
      this.cloud = response['cloud'],
      this.condCode = response['cond_code'],
      this.condTxt = response['cond_txt'],
      this.fellingTemperature = response['fl'],
      this.humidity = response['hum'],
      this.percipitationAmount = response['pcpn'],
      this.pressure = response['pres'],
      this.tmp = response['tmp'],
      this.visibility = response['vis'],
      this.windDegree = response['wind_deg'],
      this.windDirection = response['wind_dir'],
      this.windPower = response['wind_sc'],
      this.windSpeed = response['wind_spd'];

}