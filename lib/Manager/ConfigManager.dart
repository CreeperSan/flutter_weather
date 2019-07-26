const USER_NAME = "HE1608291321281243";
const KEY = "55d7287a36f040da9b742927f3aacebb";

class ConfigManager{

  // 单例模式

  ConfigManager._(){
    _init();
  }

  static ConfigManager _instance;

  static ConfigManager getInstance() {
    if (_instance == null) {
      _instance = ConfigManager._();
    }
    return _instance;
  }

  // 方法

  String _username;
  String _key;

  void _init() async {
    _username = USER_NAME;
    _key = KEY;
  }

  String getUserName(){
    return _username;
  }

  String getKey(){
    return _key;
  }

}
