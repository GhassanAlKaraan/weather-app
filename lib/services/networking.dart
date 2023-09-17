import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkBrain {
  NetworkBrain(this.weatherUrl);
  final String weatherUrl;

  Future getWeatherData() async {
    final response = await http.get(Uri.parse(weatherUrl));

    if (response.statusCode == 200) {
      final weatherData = jsonDecode(response.body);
      return weatherData;
    } else {
      print('Weather Request failed with status: ${response.statusCode}');
    }
  }
}
