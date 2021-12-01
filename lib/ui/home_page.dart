import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundamental_2/api/api_service.dart';
import 'package:fundamental_2/common/notification_helper.dart';
import 'package:fundamental_2/provider/restaurant_provider.dart';
import 'package:fundamental_2/ui/detail_page.dart';
import 'package:fundamental_2/ui/restaurant_list_page.dart';
import 'package:provider/provider.dart';
import 'package:fundamental_2/ui/account_page.dart';
import 'package:fundamental_2/ui/favorite_page.dart';
import 'package:fundamental_2/widgets/platform_widget.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int bottomNavIndex = 0;
  static const String title = 'Home';
  final NotificationHelper _notificationHelper = NotificationHelper();

  final List<BottomNavigationBarItem> _bottomNavBarItems = const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_rounded, size: 25),
      label: title,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_rounded, size: 24),
      label: FavoritePage.title,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person_rounded, size: 26),
      label: AccountPage.title,
    ),
  ];

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(apiService: ApiService()),
      child: const RestaurantListPage(),
    ),
    const FavoritePage(),
    const AccountPage(),
  ];

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _androidBuilder);
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      body: _listWidget[bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottomNavIndex,
          type: BottomNavigationBarType.fixed,
          items: _bottomNavBarItems,
          selectedFontSize: 14,
          onTap: (selected) {
            setState(() {
              bottomNavIndex = selected;
            });
          }),
    );
  }
}
