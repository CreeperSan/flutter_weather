class LifeStyle{
  List<LifeStyleItem> itemList = [];

  clear(){
    itemList.clear();
  }

  add(LifeStyleItem lifeStyleItem){
    itemList.add(lifeStyleItem);
  }

  LifeStyleItem get(int index){
    return itemList[index];
  }

  int size(){
    return itemList.length;
  }

  LifeStyle.fromResponse(dynamic response){
    itemList.clear();
    if(response != null){
      for(dynamic item in response){
        itemList.add(LifeStyleItem.fromResponse(item));
      }
    }
  }
}

class LifeStyleItem{
  final String type;        // 类型
  final String result;      // 概况
  final String suggestion;  // 描述
  String name;              // 名称

  LifeStyleItem.fromResponse(dynamic response) : this(
    type : response['type'],
    result : response['brf'],
    suggestion : response['txt']
  );

  LifeStyleItem({
    this.type,
    this.result,
    this.suggestion,
  }) {
    switch(this.type){
      case "comf" : {
        name = "舒适度指数";
        break;
      }
      case "cw" : {
        name = "洗车指数";
        break;
      }
      case "drsg" : {
        name = "穿衣指数";
        break;
      }
      case "flu" : {
        name = "感冒指数";
        break;
      }
      case "sport" : {
        name = "运动指数";
        break;
      }
      case "trav" : {
        name = "旅游指数";
        break;
      }
      case "uv" : {
        name = "紫外线指数";
        break;
      }
      case "air" : {
        name = "空气污染扩散条件指数";
        break;
      }
      case "ac" : {
        name = "空调开启指数";
        break;
      }
      case "ag" : {
        name = "过敏指数";
        break;
      }
      case "gl" : {
        name = "太阳镜指数";
        break;
      }
      case "mu" : {
        name = "化妆指数";
        break;
      }
      case "airc" : {
        name = "晾晒指数";
        break;
      }
      case "ptfc" : {
        name = "交通指数";
        break;
      }
      case "fsh" : {
        name = "钓鱼指数";
        break;
      }
      case "spi" : {
        name = "防晒指数";
        break;
      }
      default:{
        name = "";
        break;
      }
    }
  }

}