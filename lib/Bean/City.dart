
class City{
  static const String CATEGORY_CITY = "city";
  static const String CATEGORY_ADD = "add";

  final String cid;
  final String location;
  final String parentCity;
  final String adminArea;
  final String country;
  final String lat;
  final String lon;
  final String timezone;
  final String type;
  final String categoy;


  City({
    this.cid,
    this.location,
    this.parentCity,
    this.adminArea,
    this.country,
    this.lat,
    this.lon,
    this.timezone,
    this.type,
    this.categoy
  });

  City.emptyCard() :
        this.cid = "",
        this.location = "",
        this.parentCity = "",
        this.adminArea = "",
        this.country = "",
        this.lat = "",
        this.lon = "",
        this.timezone = "",
        this.type = '',
        this.categoy = CATEGORY_ADD;

  City.fromResponse(dynamic obj):
      this.cid = obj['cid'],
      this.location = obj['location'],
      this.parentCity = obj['parent_city'],
      this.adminArea = obj['admin_area'],
      this.country = obj['cnty'],
      this.lat = obj['lat'],
      this.lon = obj['lon'],
      this.timezone = obj['tz'],
      this.type = obj['type'],
      this.categoy = CATEGORY_CITY;

}

class CitySearch{

  List<City> itemList = [];

  clear(){
    itemList.clear();
  }

  add(City item){
    itemList.add(item);
  }

  City get(int index){
    return itemList[index];
  }

  int size(){
    return itemList.length;
  }

  CitySearch.fromResponse(dynamic response){
    itemList.clear();
    for(dynamic responseItem in response){
      try{
        itemList.add(City.fromResponse(responseItem));
      }catch(e){}
    }
  }

}

