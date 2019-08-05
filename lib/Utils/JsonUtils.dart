import 'dart:convert';

class JsonUtils{
  static const _encoder = JsonEncoder();
  static const _decoder = JsonDecoder();

  static String encode(Object object){
    return _encoder.convert(object);
  }

  static dynamic decode(String jsonStr){
    return _decoder.convert(jsonStr);
  }

}
