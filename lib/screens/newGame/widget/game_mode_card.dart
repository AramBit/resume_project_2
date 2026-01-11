import 'package:flutter/material.dart';

import '../../../core/utils/size_utils.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../globalWidgets/custom_image_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class GameModeCard extends StatelessWidget {
  const GameModeCard({
    super.key,
    required this.name,
    required this.number,
    required this.description,
    this.infoOnTap,
    required this.selectOnTap,
    this.timerIcon,
    this.isSelect = false,
  });
  final String number;
  final String name;
  final String description;
  final Function()? infoOnTap;
  final Function()? selectOnTap;
  final String? timerIcon;
  final bool isSelect;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            width: 1,
            color: AppColors.backgroundOne,
          ),
        ),
      ),
      padding: const EdgeInsets.all(
        10,
      ),
      child: Row(
        children: [
          if (timerIcon != null)
            CustomImageView(
              imagePath: timerIcon,
              width: 30,
            ),
          if (timerIcon == null)
            Text(
              number,
              style: AppTextStyles.newsItalic24.copyWith(
                fontFamily: FontFamily.codecProItalic,
                color: AppColors.accentOne,
              ),
            ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: AppTextStyles.extraBold16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 3,
                ),
                Text(
                  description,
                  style: AppTextStyles.news14.copyWith(
                    color: AppColors.layerThree,
                    fontSize: ResponsiveExtension.screenWidth / 30,
                  ),
                ),
              ],
            ),
          ),
          if (infoOnTap != null)
            GestureDetector(
              onTap: infoOnTap,
              child: CustomImageView(
                imagePath: Assets.images.info.path,
                width: 30,
              ),
            ),
          const SizedBox(
            width: 8,
          ),
          GestureDetector(
            onTap: selectOnTap,
            child: CustomImageView(
              imagePath: isSelect ? Assets.images.stateOn.path : Assets.images.stateOff.path,
              width: 30,
            ),
          ),
        ],
      ),
    );
  }
}
