import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class PlatformWidget extends StatelessWidget {
  final WidgetBuilder androidBuilder;
  const PlatformWidget({Key? key, required this.androidBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return androidBuilder(context);
      default:
        return androidBuilder(context);
    }
  }
}
