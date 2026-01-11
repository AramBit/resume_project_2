import 'package:flutter/material.dart';

class NavigatorService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static Future<dynamic> pushNamed(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static void goBack({bool? result}) {
    return navigatorKey.currentState?.pop(result);
  }

  static void pushNamedAndRemoveUntil(
    String routeName, {
    dynamic arguments,
    required BuildContext context,
    bool removeCurrentPage = false,
  }) async {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (context) => removeCurrentPage,
      arguments: arguments,
    );
  }

  static Future<dynamic> popAndPushNamed(String routeName, {dynamic arguments}) async {
    return navigatorKey.currentState?.popAndPushNamed(routeName, arguments: arguments);
  }
}
