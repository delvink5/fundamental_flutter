import 'package:flutter/material.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/provider/restaurant_provider.dart';
import 'package:fundamental_2/widgets/card_restaurant.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _tecSearch = TextEditingController();
  String dataSearch = '';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(context),
      child: Scaffold(
        body: Consumer<RestaurantSearchProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                  child: CircularProgressIndicator(color: primaryColor));
            } else if (state.state == ResultState.hasData) {
              return Stack(
                children: <Widget>[
                  SafeArea(
                    child: ListView.builder(
                      itemCount: state.result.restaurants.length,
                      itemBuilder: (context, index) {
                        return CardRestaurant(
                          restaurant: state.result.restaurants[index],
                        );
                      },
                      padding: const EdgeInsets.only(top: kToolbarHeight + 24),
                      shrinkWrap: true,
                    ),
                  ),
                  _searchAppbar(context, state),
                ],
              );
            } else if (state.state == ResultState.noData) {
              var onPressed;
              return Stack(
                children: [
                  _searchAppbar(context, state),
                  Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.search_off_rounded,
                          size: 150, color: Colors.black54),
                      SizedBox(height: 16),
                      Text(
                        'No Data.',
                        style: textStyle,
                      ),
                      ElevatedButton(
                          onPressed: onPressed, child: Text('Reload'))
                    ],
                  )),
                ],
              );
            } else if (state.state == ResultState.error) {
              return Stack(
                children: <Widget>[
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        state.message,
                      ),
                    ),
                  ),
                  _searchAppbar(context, state),
                ],
              );
            } else {
              return Stack(
                children: [
                  const Center(
                    child: Text('Check your internet connection'),
                  ),
                  _searchAppbar(context, state),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _searchAppbar(BuildContext context, RestaurantSearchProvider state) {
    return Container(
      padding: const EdgeInsets.only(left: 16, top: 30, bottom: 4),
      color: primaryColor,
      child: TextField(
          controller: _tecSearch,
          textInputAction: TextInputAction.search,
          style: hintTextStyle,
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
              color: Colors.white,
            ),
            hintText: 'Search...',
            hintStyle: hintTextStyle,
          ),
          onSubmitted: (value) {
            setState(() {
              dataSearch = value;
              state.setQuery(value);
            });
          }),
    );
  }
}
