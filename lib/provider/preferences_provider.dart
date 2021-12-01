import 'package:flutter/material.dart';
import 'package:fundamental_2/common/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  bool _isDailyRestaurantsActive = false;
  bool get isDailyRestaurantsActive => _isDailyRestaurantsActive;

  PreferencesProvider({required this.preferencesHelper}) {
    _getDailyRestaurantsPreferences();
  }

  void _getDailyRestaurantsPreferences() async {
    _isDailyRestaurantsActive = await preferencesHelper.isDailyRestaurantActive;
    notifyListeners();
  }

  void enableDailyRestaurant(bool value) {
    preferencesHelper.setDailyRestaurant(value);
    _getDailyRestaurantsPreferences();
  }
}
