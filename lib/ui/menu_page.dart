import 'package:flutter/material.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/provider/preferences_provider.dart';
import 'package:fundamental_2/provider/scheduling_provider.dart';
import 'package:fundamental_2/widgets/action_bar.dart';
import 'package:provider/provider.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  static const String title = 'Menu';
  static const routeName = '/menu_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const DetailActionBar(),
        backgroundColor: Colors.orange.shade900,
        foregroundColor: Colors.white,
      ),
      body: Consumer<PreferencesProvider>(builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Restaurant Notification', style: textStyle),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    return Switch.adaptive(
                      activeColor: primaryColor,
                      value: provider.isDailyRestaurantsActive,
                      onChanged: (value) async {
                        scheduled.scheduledRestaurant(value);
                        provider.enableDailyRestaurant(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
