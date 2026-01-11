import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/utils/size_utils.dart';
import '../../gen/fonts.gen.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.hintText,
    this.fieldRightWidget,
    this.hintStyle,
    this.keyboardType,
    this.onChange,
    this.controller,
    this.maxLength,
    this.horizontalPadding = 20,
    this.enabled = true,
    this.titleVisible = false,
    this.titleName = '',
    this.focusNode,
    this.maxLines,
    this.formatter,
  });
  final String hintText;
  final Widget? fieldRightWidget;
  final double horizontalPadding;
  final TextStyle? hintStyle;
  final TextInputType? keyboardType;
  final Function(String value)? onChange;
  final TextEditingController? controller;
  final int? maxLength;
  final bool enabled;
  final bool titleVisible;
  final String titleName;
  final FocusNode? focusNode;
  final int? maxLines;
  final List<TextInputFormatter>? formatter;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: [
          TextField(
            style: AppTextStyles.extraBold16.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: FontFamily.codecProBold,
            ),
            expands: false,
            maxLines: maxLines,
            minLines: 1,
            inputFormatters: formatter,
            buildCounter: (
              BuildContext context, {
              required int currentLength,
              required bool isFocused,
              required int? maxLength,
            }) {
              return null;
            },
            maxLength: maxLength,
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChange,
            textAlign: TextAlign.center,
            focusNode: focusNode,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              enabled: enabled,
              filled: true,
              fillColor: AppColors.backgroundOne,
              hintText: hintText,
              hintStyle: hintStyle ??
                  AppTextStyles.news16.copyWith(
                    color: AppColors.layerTwo,
                  ),
              contentPadding: EdgeInsets.symmetric(
                vertical: ResponsiveExtension.screenWidth / 20,
                horizontal: horizontalPadding,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.inputBorder, width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: Colors.transparent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: const BorderSide(color: AppColors.accentTwo, width: 1),
              ),
            ),
          ),
          if (fieldRightWidget != null) fieldRightWidget!,
          if (titleVisible)
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: ResponsiveExtension.screenHeight / 23,
                ),
                child: Text(
                  titleName.toUpperCase(),
                  style: AppTextStyles.bold10.copyWith(
                    color: AppColors.layerThree,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class NoLeadingSpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.startsWith(' ')) {
      return oldValue;
    }
    return newValue;
  }
}
