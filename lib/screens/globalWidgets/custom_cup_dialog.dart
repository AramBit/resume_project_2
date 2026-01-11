import 'package:flutter/material.dart';

import '../../core/utils/size_utils.dart';
import '../../cubit/onBoardingCubit/on_boarding_settings_state.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'main_button.dart';

class CustomAlertDialog extends StatefulWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onTap1Text,
    required this.onTap2Text,
    this.onTap1,
    this.onTap2,
    this.button1BackColor = AppColors.layerOne,
    this.button1TextColor = AppColors.backgroundTwo,
    this.button2TextColor = AppColors.accentOne,
  });
  final String title;
  final Widget content;
  final String onTap1Text;
  final String onTap2Text;
  final Function()? onTap1;
  final Function()? onTap2;
  final Color button1BackColor;
  final Color button1TextColor;
  final Color button2TextColor;

  @override
  State<CustomAlertDialog> createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  void dispose() {
    OnBoardingSettingsState.controller.clear();
    super.dispose();
  }

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
        // backgroundColor: AppColors.backgroundTwo,
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
                widget.title,
                style: AppTextStyles.heavyItalic32.copyWith(
                  color: AppColors.accentTwo,
                ),
              ),
              widget.content,
              Column(
                children: [
                  SizedBox(
                    height: ResponsiveExtension.screenWidth / 6,
                    child: MainButton(
                      text: widget.onTap1Text,
                      onTap: widget.onTap1,
                      textColor: widget.button1TextColor,
                      backColor: widget.button1BackColor,
                    ),
                  ),
                  if (widget.onTap2 != null)
                    const SizedBox(
                      width: 10,
                    ),
                  if (widget.onTap2 != null)
                    SizedBox(
                      height: ResponsiveExtension.screenWidth / 12,
                      child: MainButton(
                        text: widget.onTap2Text,
                        onTap: widget.onTap2,
                        textColor: widget.button2TextColor,
                        backColor: Colors.transparent,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
