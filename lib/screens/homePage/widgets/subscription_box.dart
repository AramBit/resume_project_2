import 'package:flutter/material.dart';

import '../../../cubit/homeCubit/home_state.dart';

class SubscriptionBox extends StatelessWidget {
  const SubscriptionBox({
    super.key,
    required this.onTap,
    this.state,
    this.index = 0,
  });
  final Function()? onTap;
  final HomeState? state;
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          bottom: 10,
        ),
        child: Container(
          color: Colors.transparent,
          child: const Row(
            children: [
              // CustomImageView(
              //   imagePath: state!.subscriptionData[index].image,
              //   width: 44,
              // ),
              // const SizedBox(
              //   width: 10,
              // ),
              // Expanded(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       Text(
              //         state!.subscriptionData[index].subscriptionNameText,
              //         style: AppTextStyles.bodyRegular14.copyWith(
              //           color: AppColors.textBlack,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // if (!state!.subscriptionData[index].undo)
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // Text(
                  //   '\$${state!.subscriptionData[index].amountText}',
                  //   style: AppTextStyles.bodyRegular12.copyWith(
                  //     color: AppColors.textBlack,
                  //   ),
                  // ),
                  // Text(
                  //   '/${!state!.subscriptionData[index].regularPayment ? AppTexts.month : AppTexts.year}',
                  //   style: AppTextStyles.bodyRegular16,
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
