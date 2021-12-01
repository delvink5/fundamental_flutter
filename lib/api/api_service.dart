import 'dart:convert';
import 'package:fundamental_2/model/restaurant.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev/';
  static const search = _baseUrl + 'search?q=';
  static const list = _baseUrl + 'list';
  static const details = _baseUrl + 'detail/';

  Future<RestaurantResult> restaurantList(http.Client client) async {
    final response = await client.get(Uri.parse(list));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<RestaurantDetailResult> detail(String id) async {
    final response = await http.get(Uri.parse(details + id));

    if (response.statusCode == 200) {
      return RestaurantDetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }
}
