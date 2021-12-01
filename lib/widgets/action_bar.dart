import 'package:flutter/material.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/provider/scheduling_provider.dart';
import 'package:fundamental_2/ui/menu_page.dart';
import 'package:fundamental_2/ui/search_page.dart';
import 'package:provider/provider.dart';

class ActionBar extends StatelessWidget {
  const ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: const [
            SizedBox(width: 8),
            Text('Tap Tap Eat',
                style: TextStyle(
                    fontFamily: 'Garet',
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const SearchPage();
                }));
              },
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ChangeNotifierProvider<SchedulingProvider>(
                    create: (_) => SchedulingProvider(),
                    child: const MenuPage(),
                  );
                }));
              },
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
          ],
        ),
      ],
    );
  }
}

class DetailActionBar extends StatelessWidget {
  const DetailActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: const [
            Text('Tap Tap Eat', style: textStyleBold),
          ],
        ),
      ],
    );
  }
}
