import 'package:clima/screens/location_screen.dart';
import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Future<void> getWeatherForecast() async {
    //create a Location object + get position using the method. The method uses geolocator.
    Location myLocation = Location();
    await myLocation.getCurrentLocation();

    final latitude = myLocation.latitude;
    final longitude = myLocation.longitude;
    final cityName = myLocation.cityName;


    NetworkBrain brain = NetworkBrain(
        "https://api.open-meteo.com/v1/forecast?latitude=$latitude&longitude=$longitude&current_weather=true");
    var weatherData = await brain.getWeatherData();

Navigator.push(context, MaterialPageRoute(builder: (context){
  return LocationScreen();
}));

    var temperature = weatherData['current_weather']['temperature'];
    var weatherCode = weatherData['current_weather']['weathercode'];
    var weatherDescription = getWeatherDescription(weatherCode);
    // cityName
    print("Temperature: $temperature");
    print("Weather Description: $weatherDescription");
  }

  String getWeatherDescription(int weatherCode) {
    switch (weatherCode) {
      case 0:
        return "Clear sky";
      case 1:
        return "Mainly clear, partly cloudy, and overcast";
      case 2:
        return "Mainly clear, partly cloudy, and overcast";
      case 3:
        return "Mainly clear, partly cloudy, and overcast";
      case 45:
        return "Fog and depositing rime fog";
      case 48:
        return "Fog and depositing rime fog";
      case 51:
        return "Drizzle: Light, moderate, and dense intensity";
      case 53:
        return "Drizzle: Light, moderate, and dense intensity";
      case 55:
        return "Drizzle: Light, moderate, and dense intensity";
      case 56:
        return "Freezing Drizzle: Light and dense intensity";
      case 57:
        return "Freezing Drizzle: Light and dense intensity";
      case 61:
        return "Rain: Slight, moderate and heavy intensity";
      case 63:
        return "Rain: Slight, moderate and heavy intensity";
      case 65:
        return "Rain: Slight, moderate and heavy intensity";
      case 66:
        return "Freezing Rain: Light and heavy intensity";
      case 67:
        return "Freezing Rain: Light and heavy intensity";
      case 71:
        return "Snowfall: Slight, moderate, and heavy intensity";
      case 73:
        return "Snowfall: Slight, moderate, and heavy intensity";
      case 75:
        return "Snowfall: Slight, moderate, and heavy intensity";
      case 77:
        return "Snow grains";
      case 80:
        return "Rain showers: Slight, moderate, and violent";
      case 81:
        return "Rain showers: Slight, moderate, and violent";
      case 82:
        return "Rain showers: Slight, moderate, and violent";
      case 85:
        return "Snow showers: Slight and heavy";
      case 86:
        return "Snow showers: Slight and heavy";
      case 95:
        return "Thunderstorm: Slight or moderate";
      case 96:
        return "Thunderstorm with slight and heavy hail";
      case 99:
        return "Thunderstorm with slight and heavy hail";
      default:
        return "Unknown";
    }
  }

  @override
  void initState() {
    getWeatherForecast();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SpinKitWave(
          color: Colors.white,
          size: 100,
        ),
      ),
    );
  }
}
