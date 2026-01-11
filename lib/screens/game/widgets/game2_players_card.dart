import 'package:flutter/material.dart';

import '../../../core/utils/size_utils.dart';
import '../../../gen/fonts.gen.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class Game2PlayerCard extends StatelessWidget {
  const Game2PlayerCard({
    super.key,
    required this.name,
    required this.number,
    required this.score,
    this.scoreColor = AppColors.layerOne,
  });
  final String number;
  final String name;
  final String score;
  final Color scoreColor;

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
        15,
      ),
      child: Row(
        children: [
          Text(
            number,
            style: AppTextStyles.newsItalic24.copyWith(
              fontFamily: FontFamily.codecProItalic,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: ResponsiveExtension.screenWidth / 80),
            child: Text(
              name,
              style: AppTextStyles.extraBold16.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: Text(
              score,
              style: AppTextStyles.heavyItalic24.copyWith(
                fontWeight: FontWeight.bold,
                color: scoreColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
