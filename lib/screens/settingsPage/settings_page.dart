import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/local_data_service.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/onBoardingCubit/on_boarding_settings_cubit.dart';
import '../../cubit/onBoardingCubit/on_boarding_settings_state.dart';
import '../../gen/assets.gen.dart';
import '../globalWidgets/custom_appbar.dart';
import '../globalWidgets/custom_cup_dialog.dart';
import '../globalWidgets/custom_image_view.dart';
import '../globalWidgets/custom_text_field.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';
import 'widgets/settings_row.dart';
import 'widgets/settings_service.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {},
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    OnBoardingSettingsCubit settingsCubit = context.watch<OnBoardingSettingsCubit>();

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            text: AppTexts.appSettings,
            backOnTap: () {
              Navigator.pop(context);
            },
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      AppTexts.youCanChangeYourName,
                      style: AppTextStyles.news16.copyWith(
                        color: AppColors.layerThree,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            offset: Offset(0, 4),
                            blurRadius: 16,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x0A000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SettingsRow(
                            icon: Assets.images.player.path,
                            textColor: AppColors.accentTwo,
                            rightWidget: Row(
                              children: [
                                Text(
                                  AppTexts.edit.toUpperCase(),
                                  style: AppTextStyles.bold12.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                CustomImageView(
                                  imagePath: Assets.images.edit.path,
                                  width: 30,
                                  height: 26,
                                ),
                              ],
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: LocalDataService.localData!.get(
                                  'userName',
                                ) ??
                                'Strauss Zelnick',
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) =>
                                    BlocBuilder<OnBoardingSettingsCubit, OnBoardingSettingsState>(
                                  builder: (context, state) {
                                    return CustomAlertDialog(
                                      title: AppTexts.editYourName,
                                      content: Column(
                                        children: [
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          CustomTextField(
                                            maxLength: 25,
                                            controller: OnBoardingSettingsState.controller,
                                            onChange: settingsCubit.onChangeName,
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
                                      button1BackColor: AppColors.layerOne,
                                      onTap1Text: AppTexts.sAVECHANGES,
                                      onTap2Text: AppTexts.cANCEL,
                                      onTap1: () {
                                        if (OnBoardingSettingsState.controller.text
                                                .replaceAll(' ', '')
                                                .length <
                                            3) return;
                                        LocalDataService.localData!.put(
                                          'userName',
                                          OnBoardingSettingsState.controller.text,
                                        );
                                        setState(() {});
                                        Navigator.pop(context);
                                        // NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homePage,
                                        //     context: context);
                                      },
                                      onTap2: () {
                                        settingsCubit.clearData();
                                        Navigator.pop(context);

                                        // NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homePage,
                                        //     context: context);
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          SettingsRow(
                            icon: Assets.images.clearApp.path,
                            textColor: AppColors.accentOne,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.clearApp,
                            onTap: () {
                              showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (_) => CustomAlertDialog(
                                  title: AppTexts.cLEARAPP,
                                  content: Column(
                                    children: [
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        textAlign: TextAlign.center,
                                        AppTexts.doYouWantToClearThe,
                                        style: AppTextStyles.news16.copyWith(),
                                      ),
                                      SizedBox(
                                        height: ResponsiveExtension.screenHeight / 35,
                                      ),
                                    ],
                                  ),
                                  button1BackColor: AppColors.layerOne,
                                  onTap1Text: AppTexts.cLEARAPP,
                                  onTap2Text: AppTexts.cANCEL,
                                  onTap1: () {
                                    LocalDataService.localData!.clear();

                                    NavigatorService.pushNamedAndRemoveUntil(
                                      AppRoutes.preloadScreen,
                                      context: context,
                                    );
                                  },
                                  onTap2: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              );
                            },
                          ),
                          SettingsRow(
                            icon: Assets.images.notifications.path,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.notifications,
                            onTap: () {
                              SettingsServices().requestNotificationPermissions();
                            },
                          ),
                          SettingsRow(
                            icon: Assets.images.geolocation.path,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.geolocation,
                            onTap: () async {
                              await openAppSettings();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            offset: Offset(0, 4),
                            blurRadius: 16,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x0A000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SettingsRow(
                            icon: Assets.images.share.path,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.shareAppwithaFriend,
                            onTap: () {
                              SettingsServices().shareApp();
                            },
                          ),
                          SettingsRow(
                            icon: Assets.images.rateOurApp.path,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.rateOurApp,
                            onTap: () {
                              SettingsServices().launchPrivacyPolicy();
                            },
                          ),
                          SettingsRow(
                            icon: Assets.images.leaveFeedback.path,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.leaveaReview,
                            onTap: () {
                              SettingsServices().launchPrivacyPolicy();
                            },
                          ),
                          SettingsRow(
                            icon: Assets.images.appPolicy.path,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.applicationPolicy,
                            onTap: () {
                              SettingsServices().launchPrivacyPolicy();
                            },
                          ),
                          SettingsRow(
                            borderBottomVisibility: false,
                            icon: Assets.images.contactsUs.path,
                            rightWidget: CustomImageView(
                              imagePath: Assets.images.arrowRight.path,
                              width: 30,
                              height: 26,
                            ),
                            topLeft: 20,
                            topRight: 20,
                            text: AppTexts.contactUs,
                            onTap: () {
                              SettingsServices().launchPrivacyPolicy();
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x14000000),
                            offset: Offset(0, 4),
                            blurRadius: 16,
                            spreadRadius: 0,
                          ),
                          BoxShadow(
                            color: Color(0x0A000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: SettingsRow(
                        icon: Assets.images.share.path,
                        rightWidget: const SizedBox(),
                        topLeft: 20,
                        topRight: 20,
                        text: '${AppTexts.versionApp} 1.0.0',
                        onTap: () {},
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
