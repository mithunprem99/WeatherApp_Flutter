class WeatherModel {
  final String cityName;
  final double temperature;
  final String mainCondition;

  WeatherModel(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }
}



// apiKey:= 6441bbd6f2b8a9e003c4fd4bd4e2f5c2