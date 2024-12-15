import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:integration_api/models/weather_model.dart';
import 'package:integration_api/service/weather_service.dart';
import 'package:lottie/lottie.dart';

class WeatherPage extends StatefulWidget {
  WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
//apiKey
  late final WeatherService _weatherService;
  void initState() {
    super.initState();
    final apiKey = dotenv.env['API_KEY'] ?? ''; // Get API key from .env file
    _weatherService = WeatherService(apiKey);
    fetchWeather();
  }

  WeatherModel? _weather;

  fetchWeather() async {
    String cityName = await _weatherService.getCurrentLocation();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

//weather animation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityName ?? "Loading city....",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 50),
            ),
            Lottie.asset(getWeatherCondition(_weather?.mainCondition)),
            Text('${_weather?.temperature.round()} Degree Celcius',style: TextStyle(fontSize: 20),),
            Text(_weather?.mainCondition ?? "")
          ],
        ),
      ),
    );
  }

  String getWeatherCondition(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'cloud':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rainySunny.json';
      case 'thunder storm':
        return 'assets/thunderRainy.json';
      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }
}
