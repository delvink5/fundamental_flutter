import 'package:flutter/material.dart';
import 'package:fundamental_2/common/navigation.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/model/restaurant.dart';
import 'package:fundamental_2/provider/database_provider.dart';
import 'package:fundamental_2/ui/detail_page.dart';
import 'package:provider/provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      return FutureBuilder<bool>(
        future: provider.isFavorited(restaurant.id),
        builder: (context, snapshot) {
          var isFavorited = snapshot.data ?? false;
          return Card(
            margin: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Column(
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigation.intentWithData(
                        RestaurantDetailPage.routeName, restaurant.id);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12)),
                    child: Image.network(
                      'https://restaurant-api.dicoding.dev/images/medium/${restaurant.pictureId}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(restaurant.name, style: textStyleBold),
                      Row(
                        children: <Widget>[
                          Text(restaurant.city.toUpperCase(), style: textStyle),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 12, bottom: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          const Icon(Icons.star_rounded,
                              color: Colors.orangeAccent),
                          Text('${restaurant.rating.toString()} User Rating',
                              style: textStyle),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                                isFavorited
                                    ? Icons.favorite_rounded
                                    : Icons.favorite_outline_rounded,
                                color: Colors.red),
                            onPressed: () {
                              const snackBarTrue = SnackBar(
                                content:
                                    Text('Restoran ditambahkan ke favorite.'),
                              );

                              const snackBarFalse = SnackBar(
                                  content:
                                      Text('Restoran dihapus dari favorite.'));

                              isFavorited
                                  ? provider.removeFavorite(restaurant.id)
                                  : provider.addFavorite(restaurant);
                              isFavorited
                                  ? ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarFalse)
                                  : ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBarTrue);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
