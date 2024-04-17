
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view/home_screen.dart';

import '../../view_model/weather_view_repository.dart';

class WeatherSearch extends StatelessWidget {
  const WeatherSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.sizeOf(context).width*1;
    final _searchController=TextEditingController();
    return Scaffold(
      body: Container(
          margin: EdgeInsets.only(top: 40),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _searchController,
                    // autofocus: true,
                    decoration: InputDecoration(
                        hintText: 'Search city',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)
                        ),
                        suffixIcon: IconButton(onPressed: () {
                          dynamic cityName = _searchController.text.trim();
                          if (cityName.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(cityName: cityName),
                              ),
                            );
                          }
                        },
                          icon: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Icon(Icons.search_sharp),
                          ),)
                    ),

                  ),
                ),
                SizedBox(width: 20),
                TextButton(onPressed: (){
                  Navigator.pop(context);
                },
                  child: Text('Cancel',style: GoogleFonts.lato(
                    textStyle: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                    ),
                  )),
                )
              ],
            ),
          )
      ),
    );
  }
}
