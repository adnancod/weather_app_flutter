import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/view/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(
        Duration(seconds: 3),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            child: Image.asset('assets/Weather.jpg',fit: BoxFit.cover,width: double.infinity,),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.sunny_snowing, size: 100,color: Colors.yellow,),
                // SvgPicture.asset('assets/sun.svg',
                //   height: 50,
                //   width: 50,),
                const SizedBox(height: 20,),
                Text('Weather',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.limeAccent,
                          fontSize: 33,
                          fontWeight: FontWeight.bold
                      )),
                ),
                Text('Your quick Weather Report',
                  style: GoogleFonts.lato(
                      textStyle: TextStyle(
                          color: Colors.lime,
                          fontSize: 17,
                          fontWeight: FontWeight.bold
                      )),)
              ],
            ),
          ),
        ],
      )
    );
  }
}
