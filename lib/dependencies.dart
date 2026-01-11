import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_routes.dart';
import 'core/utils/size_utils.dart';
import 'cubit/addFieldCubit/add_field_cubit.dart';
import 'cubit/fieldDetailsCubit/field_details_cubit.dart';
import 'cubit/game2Cubit/game2_cubit.dart';
import 'cubit/gameCubit/game_cubit.dart';
import 'cubit/homeCubit/home_cubit.dart';
import 'cubit/myFieldsCubit/my_fields_cubit.dart';
import 'cubit/newGameCubit/new_game_cubit.dart';
import 'cubit/onBoardingCubit/on_boarding_settings_cubit.dart';
import 'cubit/settingsCubit/settings_cubit.dart';
import 'screens/theme/app_colors.dart';

class AppGameDependencies extends StatelessWidget {
  const AppGameDependencies({super.key});

  @override
  Widget build(BuildContext context) {
    ResponsiveExtension.initScreenSize(context);

    return Sizer(
      builder: (BuildContext context, Orientation orientation, DeviceType deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
            ),
            BlocProvider<SettingsCubit>(
              create: (context) => SettingsCubit(),
            ),
            BlocProvider<HomeCubit>(
              create: (context) => HomeCubit(),
            ),
            BlocProvider<OnBoardingSettingsCubit>(
              create: (context) => OnBoardingSettingsCubit(),
            ),
            BlocProvider<NewGameCubit>(
              create: (context) => NewGameCubit(),
            ),
            BlocProvider<GameCubit>(
              create: (context) => GameCubit(),
            ),
            BlocProvider<MyFieldsCubit>(
              create: (context) => MyFieldsCubit(),
            ),
            BlocProvider<AddFieldCubit>(
              create: (context) => AddFieldCubit(),
            ),
            BlocProvider<FieldDetailsCubit>(
              create: (context) => FieldDetailsCubit(),
            ),
            BlocProvider<Game2Cubit>(
              create: (context) => Game2Cubit(),
            ),
          ],
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            child: MaterialApp(
              theme: ThemeData(
                scaffoldBackgroundColor: AppColors.backgroundOne,
                appBarTheme: const AppBarTheme(
                  systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarIconBrightness: Brightness.light,
                  ),
                ),
              ),
              initialRoute: AppRoutes.preloadScreen,
              routes: AppRoutes.appRoutes,
              debugShowCheckedModeBanner: false,
            ),
          ),
        );
      },
    );
  }
}
