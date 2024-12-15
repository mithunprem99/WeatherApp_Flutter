import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:integration_api/pages/weather_page.dart';

void main() async {
  try {
    await dotenv.load();
    print(dotenv.env); // Print all loaded variables
    runApp(const MyApp());
  } catch (e) {
    print("Error loading .env file: $e");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WeatherPage(),
    );
  }
}
