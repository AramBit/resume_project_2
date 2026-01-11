import 'package:app_b_839/core/utils/local_data_service.dart';
import 'package:app_b_839/screens/globalWidgets/custom_image_view.dart';
import 'package:app_b_839/screens/globalWidgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/onBoardingCubit/on_boarding_settings_cubit.dart';
import '../../cubit/onBoardingCubit/on_boarding_settings_state.dart';
import '../../gen/assets.gen.dart';
import '../../gen/fonts.gen.dart';
import '../globalWidgets/custom_cup_dialog.dart';
import '../globalWidgets/custom_text_field.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  Widget build(BuildContext context) {
    OnBoardingSettingsCubit onBoardingCubit = context.watch<OnBoardingSettingsCubit>();

    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          20,
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Assets.images.onboardingWelcomeScreen.path,
            ),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ResponsiveExtension.screenWidth / 7,
            ),
            CustomImageView(
              imagePath: Assets.images.textBig.path,
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
            Padding(
              padding: const EdgeInsets.only(
                left: 15,
              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: ResponsiveExtension.screenWidth / 43),
                        width: 4,
                        height: 4,
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle, color: AppColors.layerOne),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppTexts.multyplayGameModes,
                        style: AppTextStyles.news18.copyWith(
                          fontSize: ResponsiveExtension.screenWidth / 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle, color: AppColors.layerOne),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppTexts.trackScoresEasily,
                        style: AppTextStyles.news18.copyWith(
                          fontSize: ResponsiveExtension.screenWidth / 25,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 4,
                        height: 4,
                        decoration:
                            const BoxDecoration(shape: BoxShape.circle, color: AppColors.layerOne),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        AppTexts.customizeRulesFor,
                        style: AppTextStyles.news18.copyWith(
                          fontSize: ResponsiveExtension.screenWidth / 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: ResponsiveExtension.screenWidth / 10,
            ),
            MainButton(
              text: AppTexts.makeAThrow,
              onTap: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (_) => BlocBuilder<OnBoardingSettingsCubit, OnBoardingSettingsState>(
                    builder: (context, state) {
                      return CustomAlertDialog(
                        title: AppTexts.addYourName,
                        content: Column(
                          children: [
                            const SizedBox(
                              height: 15,
                            ),
                            CustomTextField(
                              maxLength: 25,
                              controller: OnBoardingSettingsState.controller,
                              onChange: onBoardingCubit.onChangeName,
                              titleName: AppTexts.yOURNAME,
                              titleVisible: state.titleNameVisibility,
                              hintText: AppTexts.enterYourName,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Text(
                              textAlign: TextAlign.center,
                              AppTexts.addYourNameWhichWill,
                              style: AppTextStyles.news16.copyWith(),
                            ),
                            SizedBox(
                              height: ResponsiveExtension.screenHeight / 16,
                            ),
                          ],
                        ),
                        button1BackColor:
                            state.buttonIsActive ? AppColors.layerOne : AppColors.layerThree,
                        onTap1Text: AppTexts.saveAndContinue,
                        onTap2Text: AppTexts.skip,
                        onTap1: () async {
                          if (OnBoardingSettingsState.controller.text.replaceAll(' ', '').length <
                              3) return;
                          LocalDataService.localData!.put(
                            'userName',
                            OnBoardingSettingsState.controller.text,
                          );

                          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homePage,
                              context: context);
                          onBoardingCubit.clearData();
                          await Permission.location.request();
                        },
                        onTap2: () {
                          onBoardingCubit.clearData();

                          NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homePage,
                              context: context);
                        },
                      );
                    },
                  ),
                );
              },
            ),
            SizedBox(
              height: ResponsiveExtension.screenWidth / 10,
            ),
          ],
        ),
      ),
    );
  }
}
