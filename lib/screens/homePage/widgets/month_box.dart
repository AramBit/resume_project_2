// import 'package:flutter/material.dart';

// import '../../../gen/assets.gen.dart';
// import '../../globalWidgets/custom_image_view.dart';
// import '../../theme/app_colors.dart';
// import '../../theme/app_text_styles.dart';

// class MonthBox extends StatelessWidget {
//   const MonthBox({
//     super.key,
//     this.gradient,
//     this.boxColor,
//     this.boxBottomPadding = 10,
//     required this.content,
//     required this.month,
//     required this.subscrValue,
//     required this.monthOnTap,
//   });
//   final List<Color>? gradient;
//   final Color? boxColor;
//   final double boxBottomPadding;
//   final String month;
//   final String subscrValue;
//   final String content;
//   final Function()? monthOnTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(
//         20,
//       ),
//       decoration: BoxDecoration(
//         gradient: gradient == null
//             ? null
//             : LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: gradient!,
//                 stops: const [
//                   0.03,
//                   0.25,
//                   0.7,
//                   1,
//                 ],
//               ),
//         borderRadius: BorderRadius.circular(20),
//         color: boxColor,
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           GestureDetector(
//             onTap: monthOnTap,
//             child: Container(
//               color: Colors.transparent,
//               child: Row(
//                 children: [
//                   CustomImageView(
//                     imagePath: Assets.images.weekFilter.path,
//                     width: 12,
//                     height: 12,
//                   ),
//                   const SizedBox(
//                     width: 4,
//                   ),
//                   Text(
//                     month,
//                     style: AppTextStyles.regular3.copyWith(color: AppColors.text3),
//                   ),
//                   const Spacer(),
//                   CustomImageView(
//                     imagePath: Assets.images.weekBottomArrow.path,
//                     width: 10,
//                     height: 5,
//                   ),
//                   const SizedBox(
//                     width: 30,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Text(
//             '-\$ $subscrValue',
//             style: AppTextStyles.headerLarge1.copyWith(color: AppColors.text3),
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Text(
//             content,
//             style: AppTextStyles.regular3.copyWith(
//               color: AppColors.text3,
//             ),
//             maxLines: 2,
//             overflow: TextOverflow.ellipsis,
//           ),
//           SizedBox(
//             height: boxBottomPadding,
//           ),
//         ],
//       ),
//     );
//   }
// }
