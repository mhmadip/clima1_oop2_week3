import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima1_oop2/services/location.dart';
import 'package:clima1_oop2/services/networking.dart';

const apiKey='8137ace68448d41da44e9bf9fd681a85';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
late String url;

  void getLocation()async{
    determinePosition() ;
    GeolocatorPlatform location = GeolocatorPlatform.instance;
    final position= await location.getCurrentPosition();
    double long= position.longitude;
    double lat=position.latitude;
    url='https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey';
    NetworkHelper networkHelper= NetworkHelper(url);
    networkHelper.getData();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            //Get the current location
            getLocation();

          },
          child: const Text('Get Location'),
        ),
      ),
    );
  }
}

