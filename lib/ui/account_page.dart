import 'package:flutter/material.dart';
import 'package:fundamental_2/common/styles.dart';
import 'package:fundamental_2/widgets/action_bar.dart';

class AccountPage extends StatelessWidget {
  static const String title = 'Account';

  const AccountPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const ActionBar(), backgroundColor: primaryColor),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: [
                        Image.asset('images/pp.jpg', height: 120, width: 120),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              const Padding(
                                padding: EdgeInsets.only(bottom: 8, left: 6),
                                child: Text("Delvin Kurniawan",
                                    style: textStyleBold),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Icon(Icons.star_rounded, color: Colors.black),
                                  Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Text('6.600 XP', style: textStyle),
                                  ),
                                  Icon(Icons.blender_rounded,
                                      color: Colors.black),
                                  Text('0 Points', style: textStyle),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const <Widget>[
                                  Icon(Icons.location_on, color: Colors.black),
                                  Text(
                                    'Kabupaten Bekasi, Jawa Barat',
                                    style: textStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Text('Bergabung Sejak', style: textStyleBold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        '7 Juli 2021',
                        style: textStyle,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 24),
                      child: Text('Tentang Saya', style: textStyleBold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Halo semuanya! Nama saya Delvin Kurniawan. Saya berasal dari Kab. Bekasi, Jawa Barat. Saya seorang mahasiswa Teknik Informatika Universitas Bunda Mulia yang sedang mengikuti program Studi Independen Kampus Merdeka 2021 bersama Dicoding Indonesia.',
                        style: textStyle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
