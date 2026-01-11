import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';

class GameModeDialog extends StatelessWidget {
  const GameModeDialog({
    super.key,
    required this.title,
    required this.text,
    this.onTap,
  });
  final String title;
  final String text;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        insetPadding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            20,
          ),
        ),
        contentPadding: EdgeInsets.zero,
        actionsPadding: EdgeInsets.zero,
        content: Container(
          padding: const EdgeInsets.only(
            top: 20,
            right: 20,
            left: 20,
            bottom: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.backgroundTwo,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                textAlign: TextAlign.center,
                title,
                style: AppTextStyles.heavyItalic32.copyWith(
                  color: AppColors.accentTwo,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                textAlign: TextAlign.center,
                text,
                style: AppTextStyles.news16,
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    textAlign: TextAlign.center,
                    AppTexts.oKAY,
                    style: AppTextStyles.extraBold16.copyWith(
                      color: AppColors.accentOne,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
