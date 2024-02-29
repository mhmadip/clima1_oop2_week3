import 'dart:convert';
import 'package:clima1_oop2/screens/city_screen.dart';
import 'package:clima1_oop2/screens/loading_screen.dart';
import 'package:clima1_oop2/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:clima1_oop2/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  final locationWeather;
  const LocationScreen({Key? key, this.locationWeather}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temp;
  late int condition;
  late String cityName;
  late String conditionIcon;
  late String weatherMsg;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    updateUI();
  }
  void updateUI(){
    var decodedData=jsonDecode(widget.locationWeather);
    var temp1=decodedData['main']['temp']-273.15;
    temp=temp1.toInt();
    cityName=decodedData['name'];
    condition=decodedData['weather'][0]['id'];
    conditionIcon=WeatherModel().getWeatherIcon(condition);
    weatherMsg=WeatherModel().getMessage(temp);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const LoadingScreen()));

                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>const CityScreen()));

                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children:  <Widget>[
                    Text(
                      '$temp°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      conditionIcon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMsg in $cityName!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
