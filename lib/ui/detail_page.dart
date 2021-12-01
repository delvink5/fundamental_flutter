import 'package:flutter/material.dart';
import 'package:fundamental_2/api/api_service.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/model/restaurant.dart';
import 'package:fundamental_2/provider/restaurant_provider.dart';
import 'package:fundamental_2/widgets/action_bar.dart';
import 'package:fundamental_2/widgets/platform_widget.dart';
import 'package:provider/provider.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const String title = 'Detail';
  static const routeName = '/detail_page';
  final String restaurantId;

  const RestaurantDetailPage({Key? key, required this.restaurantId})
      : super(key: key);

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(androidBuilder: _androidBuilder);
  }

  Widget _androidBuilder(BuildContext context) {
    return _buildDetail(context);
  }

  Widget _buildDetail(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const DetailActionBar(),
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
        ),
        body: ChangeNotifierProvider<RestaurantDetailProvider>(
          create: (_) => RestaurantDetailProvider(
              apiService: ApiService(), id: widget.restaurantId),
          child: Consumer<RestaurantDetailProvider>(
            builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                    child: CircularProgressIndicator(color: primaryColor));
              } else if (state.state == ResultState.hasData) {
                var restaurantDetail = state.resultDetail.restaurant;
                return DataDetail(restaurantDetail: restaurantDetail);
              } else if (state.state == ResultState.noData) {
                return Center(child: Text(state.message));
              } else if (state.state == ResultState.error) {
                return Center(child: Text(state.message));
              } else {
                return const Text('');
              }
            },
          ),
        ));
  }
}

class DataDetail extends StatelessWidget {
  final RestaurantDetail restaurantDetail;
  const DataDetail({Key? key, required this.restaurantDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Image.network(
              'https://restaurant-api.dicoding.dev/images/medium/${restaurantDetail.pictureId}'),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Center(
                  child: Text(restaurantDetail.name, style: textStyleHeading),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.location_city_rounded,
                        color: Colors.black54),
                    Text(restaurantDetail.city, style: textStyle),
                    const SizedBox(width: 16),
                    const Icon(Icons.star_rounded, color: Colors.orangeAccent),
                    Text('${restaurantDetail.rating.toString()} User Rating',
                        style: textStyle),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_rounded,
                        color: Colors.black54),
                    Text(restaurantDetail.address, style: textStyle),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Category', style: textStyle),
                SizedBox(
                  height: 40,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemCount: restaurantDetail.categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var category = restaurantDetail.categories[index];
                        return CategoryList(category: category);
                      }),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: <Widget>[
                        const Text('Description', style: textStyleBold),
                        const SizedBox(height: 12),
                        Text(restaurantDetail.description, style: textStyle),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text('Menu Available', style: textStyleHeading),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Card(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(12),
                                child: Column(
                                  children: <Widget>[
                                    const Text('Foods:', style: textStyleBold),
                                    _buildFoodsItem(
                                        context, restaurantDetail.menus.foods),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Card(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  children: <Widget>[
                                    const Text('Drinks:', style: textStyleBold),
                                    _buildDrinkItem(
                                        context, restaurantDetail.menus.drinks),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _buildFoodsItem(BuildContext context, List<Category> foods) {
    List<Widget> text = [];
    int num = 1;

    for (var foods in foods) {
      text.add(const SizedBox(
        height: 5,
      ));
      text.add(Text('$num. ${foods.name}', style: textStyle));
      num++;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: text,
    );
  }

  _buildDrinkItem(BuildContext context, List<Category> drinks) {
    List<Widget> text = [];
    int num = 1;

    for (var drinks in drinks) {
      text.add(const SizedBox(
        height: 5,
      ));
      text.add(Text('$num. ${drinks.name}', style: textStyle));
      num++;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: text,
    );
  }
}

class CategoryList extends StatelessWidget {
  final Category category;
  const CategoryList({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade100,
      child: Padding(
          padding: const EdgeInsets.all(6),
          child: Text(category.name, style: textStyle)),
    );
  }
}
