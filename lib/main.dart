import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fundamental_2/api/api_service.dart';
import 'package:fundamental_2/common/navigation.dart';
import 'package:fundamental_2/common/notification_helper.dart';
import 'package:fundamental_2/common/preferences_helper.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/db/database_helper.dart';
import 'package:fundamental_2/provider/database_provider.dart';
import 'package:fundamental_2/provider/preferences_provider.dart';
import 'package:fundamental_2/provider/restaurant_provider.dart';
import 'package:fundamental_2/provider/scheduling_provider.dart';
import 'package:fundamental_2/ui/detail_page.dart';
import 'package:fundamental_2/ui/favorite_page.dart';
import 'package:fundamental_2/ui/home_page.dart';
import 'package:fundamental_2/ui/restaurant_list_page.dart';
import 'package:fundamental_2/utils/background_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  await AndroidAlarmManager.initialize();
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => RestaurantProvider(apiService: ApiService())),
        ChangeNotifierProvider(
            create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper())),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'News App',
            initialRoute: HomePage.routeName,
            theme: ThemeData(
                visualDensity: VisualDensity.adaptivePlatformDensity,
                scaffoldBackgroundColor: Colors.white,
                colorScheme:
                    ColorScheme.fromSwatch(primarySwatch: Colors.deepOrange)
                        .copyWith(
                  primary: Colors.white,
                  onPrimary: Colors.black,
                  onSecondary: Colors.white,
                ),
                appBarTheme: const AppBarTheme(
                  elevation: 0,
                ),
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        primary: primaryColor,
                        onPrimary: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(0)),
                        ))),
                bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                  selectedItemColor: primaryColor,
                  unselectedItemColor: Colors.grey,
                )),
            navigatorKey: navigatorKey,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              RestaurantListPage.routeName: (context) =>
                  const RestaurantListPage(),
              FavoritePage.routeName: (context) => const FavoritePage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                    restaurantId:
                        ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }
}
