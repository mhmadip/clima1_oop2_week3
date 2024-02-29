import 'package:clima1_oop2/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima1_oop2/services/location.dart';
import 'package:clima1_oop2/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey='8137ace68448d41da44e9bf9fd681a85';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
late String url;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLocation();
  }
  void getLocation()async{
    determinePosition() ;
    GeolocatorPlatform location = GeolocatorPlatform.instance;
    final position= await location.getCurrentPosition();
    double long= position.longitude;
    double lat=position.latitude;
    url='https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&metrics=imperial';
    NetworkHelper networkHelper= NetworkHelper(url);
    var weatherData = await networkHelper.getData();
    Navigator.push(context,MaterialPageRoute(builder: (context)=>LocationScreen(locationWeather: weatherData,)));

  }


  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitCircle(
         color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}

