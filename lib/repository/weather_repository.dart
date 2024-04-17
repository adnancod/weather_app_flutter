import 'package:flutter/material.dart';
import 'package:weather_app/data/app_exceptions.dart';
import 'package:weather_app/model/WeatherModel.dart';
import 'package:weather_app/utils/utils.dart';

import '../data/network/BaseApiServices.dart';
import '../data/network/NetworkApiServices.dart';

class WeatherRepository{

  BaseApiServices _apiServices = NetworkApiServices();

  Future<WeatherModel> weatherApi(String city)async{

    try{
      dynamic response= await _apiServices.getGetApiResponse(city);
      return response=WeatherModel.fromJson(response);
    }catch(e){
      Utils.toastMessage(e.toString());
      throw InvalidInputException();
    }
  }

}