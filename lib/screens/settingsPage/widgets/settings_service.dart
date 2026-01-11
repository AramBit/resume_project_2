import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsServices {
  SettingsServices() : super();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermissions([String from = 'settings']) async {
    try {
      if (Platform.isIOS) {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
            ?.requestPermissions(alert: true, badge: true, sound: true);
      } else {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestNotificationsPermission();
      }

      if (from == 'settings') {
        await AppSettings.openAppSettings();
      }
    } catch (e) {}
  }

  Future<void> requestGeoPermissions() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      // Запрашиваем разрешение
      // status = await Permission.location.request();

      if (status.isDenied) {
        return;
      }
    }

    if (status.isPermanentlyDenied) {
      // Если уже "Не спрашивать больше" → сразу кидаем в настройки
      await openAppSettings();
    }
  }

  Future<void> launchPrivacyPolicy() async {
    try {
      await launchUrlString('https://www.google.com');
    } catch (e) {}
  }

  Future<void> shareApp() async {
    // ignore: deprecated_member_use
    await Share.share(
      "https://appdynamiclinka.page.link/76UZ",
      subject: 'Look what I made!',
    );
  }
}
