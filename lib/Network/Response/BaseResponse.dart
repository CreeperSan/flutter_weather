import 'package:dio/dio.dart';

abstract class BaseResponse{
  Response response;

  bool isResponseSuccess(){
    if(response == null){
      return false;
    }else{
      return response.statusCode == 200;
    };
  }

  BaseResponse.fromResponse(Response response){
    this.response = response;
    if(response != null){
      parse();
    }
  }

  parse();

}