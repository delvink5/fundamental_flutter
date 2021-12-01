import 'package:flutter/material.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/model/restaurant.dart';
import 'package:fundamental_2/provider/restaurant_provider.dart';
import 'package:fundamental_2/widgets/action_bar.dart';
import 'package:fundamental_2/widgets/card_restaurant.dart';
import 'package:fundamental_2/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class RestaurantListPage extends StatefulWidget {
  const RestaurantListPage({Key? key, Restaurant? restaurant})
      : super(key: key);
  static const routeName = '/article_list';

  @override
  State<RestaurantListPage> createState() => _RestaurantListPageState();
}

class _RestaurantListPageState extends State<RestaurantListPage> {
  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _androidBuilder);
  }

  @override
  void initState() {
    super.initState();
  }

  Widget _androidBuilder(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ActionBar(),
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.loading) {
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        } else {
          if (state.state == ResultState.hasData) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 24, top: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text('Restaurants', style: textStyleHeading),
                          Text('Recommended restaurants for you:',
                              style: textStyle),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (context, index) {
                          var restaurant = state.result.restaurants[index];
                          return CardRestaurant(restaurant: restaurant);
                        }),
                  ],
                ),
              ),
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Text('');
          }
        }
      },
    );
  }
}
