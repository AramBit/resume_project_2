import 'package:flutter/material.dart';

import '../../../core/utils/size_utils.dart';
import '../../../gen/assets.gen.dart';
import '../../../gen/fonts.gen.dart';
import '../../globalWidgets/custom_image_view.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

class PlayerCard extends StatelessWidget {
  const PlayerCard({
    super.key,
    required this.name,
    required this.number,
    this.onTap,
  });
  final String number;
  final String name;
  final Function()? onTap;

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
          if (onTap != null)
            GestureDetector(
              onTap: onTap,
              child: CustomImageView(
                imagePath: Assets.images.random.path,
                width: 30,
              ),
            ),
        ],
      ),
    );
  }
}
