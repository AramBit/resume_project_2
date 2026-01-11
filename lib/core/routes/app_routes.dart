import 'package:flutter/material.dart';

import '../../screens/fieldDetails/field_details.dart';
import '../../screens/game/game.dart';
import '../../screens/game/game2.dart';
import '../../screens/homePage/home_page.dart';
import '../../screens/myFields/my_fields.dart';
import '../../screens/newGame/new_game.dart';
import '../../screens/newGame/new_game_2.dart';
import '../../screens/onBoarding/on_boarding.dart';
import '../../screens/preloaderPage/preloader_page.dart';
import '../../screens/settingsPage/settings_page.dart';

class AppRoutes {
  static String preloadScreen = '/';
  static String homePage = 'HomePage';
  static String onBoarding = 'OnBoarding';
  static String settingsScreen = 'SettingsScreen';
  static String createAnAccount = 'CreateAnAccount';
  static String addSubscription = 'AddSubscription';
  static String allSubscription = 'AllSubscription';
  static String addGoals = 'AddGoals';
  static String archiveEvents = 'ArchiveEvents';
  static String creatingEvent = 'CreatingEvent';
  static String allEvents = 'AllEvents';
  static String allPosters = 'AllPosters';
  static String createPoster = 'CreatePoster';
  static String createPosterFinalPage = 'CreatePosterFinalPage';
  static String myfields = 'Myfields';
  static String fieldDetails = 'FieldDetails';
  static String newGame = 'NewGame';
  static String game = 'Game';
  static String newGame2 = 'NewGame2';
  static String game2 = 'Game2';

  static Map<String, WidgetBuilder> appRoutes = {
    AppRoutes.preloadScreen: (context) => const PreloadScreen(),
    AppRoutes.settingsScreen: (context) => const SettingsPage(),
    AppRoutes.homePage: (context) => const HomePage(),
    AppRoutes.onBoarding: (context) => const OnBoarding(),
    AppRoutes.myfields: (context) => const Myfields(),
    AppRoutes.fieldDetails: (context) => const FieldDetails(),
    AppRoutes.newGame: (context) => const NewGame(),
    AppRoutes.game: (context) => const Game(),
    AppRoutes.newGame2: (context) => const NewGame2(),
    AppRoutes.game2: (context) => const Game2(),
  };
}
