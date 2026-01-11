import 'package:flutter/material.dart';

import '../../../gen/assets.gen.dart';
import '../../globalWidgets/custom_image_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';
import '../../theme/app_texts.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    super.key,
    required this.value,
  });
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        border: const Border(
          top: BorderSide(
            width: 1,
            color: AppColors.backgroundOne,
          ),
        ),
      ),
      padding: const EdgeInsets.all(
        15,
      ),
      child: Row(
        children: [
          CustomImageView(
            imagePath: Assets.images.timer.path,
            width: 30,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppTexts.gameTimer,
                  style: AppTextStyles.extraBold16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Text(
            value,
            style: AppTextStyles.heavyItalic24.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
