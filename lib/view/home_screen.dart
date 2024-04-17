import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/res/widgets/weather_bg_image.dart';
import 'package:weather_app/res/widgets/weather_search.dart';
import 'package:weather_app/view_model/weather_view_repository.dart';
import 'package:intl/intl.dart';
import '../data/response/status.dart';

class HomeScreen extends StatefulWidget {
  final String cityName;
  const HomeScreen({this.cityName='Abbottabad',super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  WeatherViewModel weatherViewModel=WeatherViewModel();
  String cityName='Abbottabad';
  int index=0;

  @override
  void initState() {
    // weatherViewModel.fetchWeatherApi(cityName);
    weatherViewModel.fetchWeatherApi(widget.cityName);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    final _style=GoogleFonts.poppins(
      textStyle: const TextStyle(fontSize: 17,fontWeight: FontWeight.w600,
          color: Colors.black),);

    final height=MediaQuery.sizeOf(context).height*1;
    final width=MediaQuery.sizeOf(context).width*1;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading:
        IconButton(
          onPressed: () {
            // WeatherSearch();
            Navigator.push(context, MaterialPageRoute(builder: (context)=>WeatherSearch()));
          },
          icon: Icon(Icons.search,size: 30,color: Colors.white,),),
        backgroundColor: Colors.transparent,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            child: IconButton(onPressed: () {  },
              icon: Icon(Icons.menu_outlined,size: 30,color:Colors.white,),),
          )
        ],
      ),
      body: ChangeNotifierProvider<WeatherViewModel>(
        create: (BuildContext context) => weatherViewModel,
        child: Consumer<WeatherViewModel>(
          builder: (context, value, _) {

            int? temp =  value.weatherList.data?.main?.temp!.toInt();

            int? tempFeel = value.weatherList.data?.main?.feelsLike!.toInt();

            dynamic timezoneOffset;
            if (value.weatherList.data != null) {
              timezoneOffset = int.parse(value.weatherList.data!.timezone.toString());
            } else {
              timezoneOffset = 0; // Set a default value here
            }
            DateTime utcTime = DateTime.now().toUtc();
            DateTime localTime = utcTime.add(Duration(seconds: timezoneOffset));
            String formattedDateTime = DateFormat('hh:mm a MMM d, yyyy').format(localTime);


            switch (value.weatherList.status) {
            case Status.Loading:
                return const Center(child: CircularProgressIndicator());
              case null:
              // TODO: Handle this case.
              case Status.Error:
                return Text(value.weatherList.message.toString());
              case Status.Completed:
                return Container(
                  child: Stack(
                    children: [
                      WeatherBackground(value.weatherList.data!.weather![index].main.toString()),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black38
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: height*0.13,),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(value.weatherList.data!.name.toString(),
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 33,
                                              fontWeight: FontWeight.bold
                                          )),),
                                    Text(formattedDateTime,
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold
                                          )),),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('$temp\u2103',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 85,
                                              fontWeight: FontWeight.w300
                                          )),),
                                    SizedBox(width: width*0.02,),
                                    Text(value.weatherList.data!.weather![index].main.toString(),
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold
                                          )),),
                                    SizedBox(width: width*0.02,),
                                    Text('$tempFeel\u2103',
                                      style: GoogleFonts.lato(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600
                                          )),),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 40),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.white30
                                    )
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text('Wind',
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold
                                              )),),
                                        Text(value.weatherList.data!.wind!.speed.toString(),
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold
                                              )),),
                                        Text('km/h',style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            )),),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Pressure',style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            )),),
                                        Text(value.weatherList.data!.main!.pressure.toString(),
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold
                                              )),),
                                        Text('hPa',style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            )),),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text('Humidity',style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            )),),
                                        Text(value.weatherList.data!.main!.humidity.toString(),
                                          style: GoogleFonts.lato(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold
                                              )),),
                                        Text('%',style: GoogleFonts.lato(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold
                                            )),),

                                      ],
                                    ),

                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                                            ),
                      ),],
                  ),
                );
            }
          }
        ),
      ),
    );
  }
}
