// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:fundamental_2/model/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:fundamental_2/api/api_service.dart';

enum ResultState { loading, noData, hasData, error, noConnection }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  ResultState get state => _state;
  http.Client client = http.Client();

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final restaurant = await apiService.restaurantList(client);
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check your internet connection';
    }
  }
}

class RestaurantDetailProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantDetailProvider({required this.apiService, required this.id}) {
    _fetchRestaurantDetails();
  }

  late RestaurantDetailResult _restaurantDetail;
  late ResultState _state;
  String _message = '';
  final String id;

  String get message => _message;
  RestaurantDetailResult get resultDetail => _restaurantDetail;
  ResultState get state => _state;
  String get ids => id;

  Future<dynamic> _fetchRestaurantDetails() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurantDetail = await apiService.detail(ids);
      if (restaurantDetail.restaurant == null) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No restaurant data.';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantDetail = restaurantDetail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Check your internet connection.';
    }
  }
}

class RestaurantSearchProvider extends ChangeNotifier {
  final BuildContext context;
  final apiService = ApiService();

  RestaurantSearchProvider(this.context) {
    _fetchRestaurant();
  }

  late RestaurantResult _restaurantResult;
  late ResultState _state;
  String _query = '';
  String _message = '';

  void setQuery(String query) {
    _query = query;
    _fetchRestaurant();
    notifyListeners();
  }

  String get message => _message;
  RestaurantResult get result => _restaurantResult;
  String get query => _query;
  ResultState get state => _state;

  Future<dynamic> _fetchRestaurant() async {
    try {
      _state = ResultState.loading;
      notifyListeners();

      final restaurant = await getRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'No Data';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _restaurantResult = restaurant;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      _message = 'Check your internet connection';
      return Center(
        child: Text(_message),
      );
    }
  }

  Future<RestaurantResult> getRestaurant() async {
    String api;
    if (query.isEmpty) {
      api = ApiService.list;
    } else {
      api = ApiService.search + query;
    }

    final response = await http.get(Uri.parse(api));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('No Result');
    }
  }
}
