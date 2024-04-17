

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/model/WeatherModel.dart';

import '../data/response/api_response.dart';
import '../repository/weather_repository.dart';

class WeatherViewModel with ChangeNotifier{

  final _myRepo= WeatherRepository();

  bool _isSearching = false;

  bool get isSearching=> _isSearching;

  setSearching(bool value){
    _isSearching=value;
    notifyListeners();
  }

  ApiResponse<WeatherModel> weatherList= ApiResponse.loading();

  setWeatherList(ApiResponse<WeatherModel> response){
    weatherList=response;
    notifyListeners();
  }

  Future<void> fetchWeatherApi(String city)async{

    setWeatherList(ApiResponse.loading());
    _myRepo.weatherApi(city).then((value) {
      setWeatherList(ApiResponse.completed(value));
      if(kDebugMode){
        print(value.toString());
      }
    }).onError((error, stackTrace) {
      setWeatherList(ApiResponse.error(error.toString()));
      if(kDebugMode){
        print(error.toString());
      }

    });
    notifyListeners();
  }
}