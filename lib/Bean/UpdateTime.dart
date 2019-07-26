class UpdateTime{
  final String localTime;
  final String universalTime;

  UpdateTime({
    this.localTime,
    this.universalTime
  });

  UpdateTime.fromResponse(dynamic response):
    this.localTime = response['loc'],
    this.universalTime = response['utc']
  ;

}