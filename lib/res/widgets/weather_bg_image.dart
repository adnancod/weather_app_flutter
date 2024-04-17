import 'package:flutter/cupertino.dart';

class WeatherBackground extends StatelessWidget {
  final String? _weatherCondition;
  const WeatherBackground(this._weatherCondition,{super.key});

  @override
  Widget build(BuildContext context) {
    String? _backgroundImage;
    _setBackgroundImage() {
      // Map each weather condition to a corresponding background image
      if(_weatherCondition=='Clear'){
        _backgroundImage='assets/sunny.jpg';
      }
      else if(_weatherCondition=='Night'){
        _backgroundImage='assets/night.jpg';
      }
      else if(_weatherCondition=='Rain'){
        _backgroundImage='assets/rainy.jpg';
      }
      else if(_weatherCondition=='Clouds'){
        _backgroundImage='assets/cloudy.jpeg';
      }
      else{
        _backgroundImage='assets/Weather.jpg';
      }
    }
    _setBackgroundImage();
    return Image.asset(
      _backgroundImage??'',
      fit: BoxFit.cover,height: double.infinity,width: double.infinity,
    );
  }
}
