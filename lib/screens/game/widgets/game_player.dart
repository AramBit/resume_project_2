import 'package:flutter/material.dart';

import '../../../core/utils/size_utils.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../globalWidgets/custom_image_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class GamePlayer extends StatelessWidget {
  const GamePlayer({
    super.key,
    required this.name,
    required this.number,
    required this.onTapDecrement,
    required this.onTapIncrement,
    required this.value,
    required this.onTapDecrementLognPress,
    required this.onTapIncrementLognPress,
    this.decrementBorder = '3',
    this.incrementBorder = '6',
  });
  final String number;
  final String name;
  final String value;
  final Function()? onTapDecrement;
  final Function()? onTapIncrement;
  final Function()? onTapDecrementLognPress;
  final Function()? onTapIncrementLognPress;
  final String decrementBorder;
  final String incrementBorder;

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
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            Text(
              number,
              style: AppTextStyles.newsItalic24.copyWith(
                fontFamily: FontFamily.codecProItalic,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  name,
                  style: AppTextStyles.extraBold16.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            GestureDetector(
              onTap: onTapDecrement,
              onLongPress: onTapDecrementLognPress,
              child: CustomImageView(
                imagePath: value == decrementBorder
                    ? Assets.images.plus.path
                    : Assets.images.plusActive.path,
                width: 30,
              ),
            ),
            SizedBox(
              width: ResponsiveExtension.screenWidth / 20,
            ),
            Text(
              value,
              style: AppTextStyles.extraBold16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: ResponsiveExtension.screenWidth / 20,
            ),
            GestureDetector(
              onTap: onTapIncrement,
              onLongPress: onTapIncrementLognPress,
              child: CustomImageView(
                imagePath: value == incrementBorder
                    ? Assets.images.plus.path
                    : Assets.images.plusActive.path,
                width: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
