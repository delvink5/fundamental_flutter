import 'package:flutter/material.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/widgets/action_bar.dart';
import 'package:fundamental_2/provider/database_provider.dart';
import 'package:fundamental_2/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  static const String title = 'Favorite';
  static const routeName = '/favorite_page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const ActionBar(), backgroundColor: primaryColor),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: 16),
                  CardRestaurant(restaurant: provider.favorites[index])
                ],
              );
            },
          );
        } else {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text(
                provider.message,
                style: textStyle,
              ),
            ),
          );
        }
      },
    );
  }
}
