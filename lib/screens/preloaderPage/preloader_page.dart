import 'dart:async';

import 'package:app_b_839/screens/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/local_data_service.dart';
import '../../core/utils/navigator_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_texts.dart';

class PreloadScreen extends StatefulWidget {
  const PreloadScreen({super.key});

  @override
  State<PreloadScreen> createState() => _PreloaderScreenState();
}

class _PreloaderScreenState extends State<PreloadScreen> {
  late final Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (_) async {
      if (LocalDataService.localData!.get('isFirstTime') == null) {
        NavigatorService.pushNamedAndRemoveUntil(context: context, AppRoutes.onBoarding);
        return;
      }
      NavigatorService.pushNamedAndRemoveUntil(AppRoutes.homePage, context: context);
      return;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: LoadingAnimationWidget.progressiveDots(
                    color: const Color(0xFF1A1A3F),
                    size: 70,
                  ),
                ),
              ),
              Text(
                AppTexts.loading,
                style: AppTextStyles.newsItalic24.copyWith(
                  color: AppColors.layerThree,
                ),
              ),
              const SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
