import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpResponse {
  Future<List> getData() async {
    final response = await http.get(
        Uri.parse('https://restcountries.com/v2/all'),
        headers: {"Accept": "application/json"});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      print("error from server : $response");
      throw Exception('Failed to load post');
    }
  }
}
