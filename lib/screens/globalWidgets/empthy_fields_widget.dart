import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EmpthyFieldsWidget extends StatelessWidget {
  const EmpthyFieldsWidget({super.key, this.topPadding});
  final double? topPadding;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Padding(
        padding: EdgeInsets.only(
          top: topPadding ??
              ResponsiveExtension.screenWidth / 6 + ResponsiveExtension.screenWidth / 20,
        ),
        child: Text.rich(
          textAlign: TextAlign.center,
          TextSpan(
            children: [
              TextSpan(
                text: 'Your list of fields is empty.\nYou can add a new field by ',
                style: AppTextStyles.news16.copyWith(
                  color: AppColors.layerThree,
                ),
              ),
              TextSpan(
                text: 'clicking on\nthe “Add” button in the upper right corner.\n',
                style: AppTextStyles.news16.copyWith(
                  color: Colors.black,
                ),
              ),
              TextSpan(
                text: ' Or when starting a new game.',
                style: AppTextStyles.news16.copyWith(
                  color: AppColors.layerThree,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
