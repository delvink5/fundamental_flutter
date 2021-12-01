import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fundamental_2/common/navigation.dart';

customDialog(BuildContext context) {
  return AlertDialog(
    title: const Text('Coming Soon!'),
    content: const Text('This feature will be coming soon!'),
    actions: [
      TextButton(
        onPressed: () {
          Navigation.back();
        },
        child: const Text('Ok'),
      ),
    ],
  );
}
