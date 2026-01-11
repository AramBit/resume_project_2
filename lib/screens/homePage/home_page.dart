import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/local_data_service.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/homeCubit/home_cubit.dart';
import '../../cubit/homeCubit/home_state.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../globalWidgets/custom_image_view.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    LocalDataService.localData!.put('isFirstTime', true);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    HomeCubit.homeCubit = context.watch<HomeCubit>();
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: HomeCubit.homeCubit,
      builder: (context, state) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  Assets.images.mainDefault.path,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: ResponsiveExtension.screenWidth / 7,
                  ),
                  CustomImageView(
                    imagePath: Assets.images.textBigPoints.path,
                    width: ResponsiveExtension.screenWidth / 1.25,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    AppTexts.andGetAResult,
                    style: AppTextStyles.extraBold16.copyWith(
                      fontFamily: FontFamily.codecProBold,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      NavigatorService.pushNamedAndRemoveUntil(
                        context: context,
                        AppRoutes.newGame,
                        removeCurrentPage: true,
                      );
                    },
                    child: Container(
                      height: ResponsiveExtension.screenHeight / 7,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            Assets.images.newGame.path,
                          ),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomImageView(
                            imagePath: Assets.images.ball.path,
                            width: 24,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            AppTexts.startNewGame,
                            style: AppTextStyles.extraBold16.copyWith(
                              fontFamily: FontFamily.codecProBold,
                              fontWeight: FontWeight.bold,
                              color: AppColors.backgroundTwo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigatorService.pushNamedAndRemoveUntil(
                              context: context,
                              AppRoutes.myfields,
                              removeCurrentPage: true,
                            );
                          },
                          child: Container(
                            height: ResponsiveExtension.screenHeight / 9,
                            decoration: BoxDecoration(
                              color: AppColors.layerOne,
                              borderRadius: BorderRadius.circular(
                                6,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: Assets.images.myField.path,
                                  width: 24,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTexts.myFields,
                                  style: AppTextStyles.bold12.copyWith(
                                    fontFamily: FontFamily.codecProBold,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.backgroundTwo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            NavigatorService.pushNamedAndRemoveUntil(
                              context: context,
                              AppRoutes.settingsScreen,
                              removeCurrentPage: true,
                            );
                          },
                          child: Container(
                            height: ResponsiveExtension.screenHeight / 9,
                            decoration: BoxDecoration(
                              color: AppColors.layerOne,
                              borderRadius: BorderRadius.circular(
                                6,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomImageView(
                                  imagePath: Assets.images.settings.path,
                                  width: 24,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  AppTexts.appSettings,
                                  style: AppTextStyles.bold12.copyWith(
                                    fontFamily: FontFamily.codecProBold,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.backgroundTwo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: ResponsiveExtension.screenHeight / 15,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
