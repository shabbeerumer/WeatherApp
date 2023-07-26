import 'dart:convert';
import 'package:http/http.dart' as http;
import '../modals/weathermodal.dart';

class WeatherAPI {
  static const String API_KEY = 'bfaf1ce68ee04bbca1ae7a27afcda490';

  Future<WeatherDataModal> GetApiData(String? Location) async {
    String url =
        'https://api.openweathermap.org/data/2.5/weather?q=$Location&appid=$API_KEY';
    final response = await http.get(Uri.parse(url));
    var decode = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      return WeatherDataModal.fromJson(decode);
    } else {
      return WeatherDataModal();
    }
  }
}
