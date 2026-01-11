import 'package:app_b_839/core/utils/local_data_service.dart';
import 'package:app_b_839/screens/globalWidgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/routes/app_routes.dart';
import '../../core/utils/navigator_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/myFieldsCubit/my_fields_cubit.dart';
import '../../cubit/myFieldsCubit/my_fields_state.dart';
import '../../gen/assets.gen.dart';
import '../globalWidgets/custom_appbar.dart';
import '../globalWidgets/empthy_fields_widget.dart';
import '../globalWidgets/field_widget.dart';
import '../theme/app_colors.dart';
import '../theme/app_texts.dart';
import 'widgets/custom_bottom_sheet.dart';

class Myfields extends StatefulWidget {
  const Myfields({super.key});

  @override
  State<Myfields> createState() => _MyfieldsState();
}

class _MyfieldsState extends State<Myfields> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        MyFieldsCubit.myFieldsCubit!.getFields();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyFieldsCubit.myFieldsCubit = context.watch<MyFieldsCubit>();

    return BlocBuilder<MyFieldsCubit, MyFieldsState>(
        bloc: MyFieldsCubit.myFieldsCubit,
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColors.backgroundOne,
            body: Stack(
              children: [
                Column(
                  children: [
                    CustomAppBar(
                      text: AppTexts.myFields,
                      backOnTap: () {
                        Navigator.pop(context);
                      },
                      rightWidget: GestureDetector(
                        onTap: () {
                          CustomBottomSheet.showBlurBottomSheet(
                            context,
                            pageType: 0,
                          );
                        },
                        child: CustomImageView(
                          imagePath: Assets.images.addField.path,
                          width: ResponsiveExtension.screenWidth / 10,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(
                                20,
                              ),
                              child: Column(
                                children: List.generate(
                                  state.fields.length,
                                  (index) {
                                    return Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                      ),
                                      child: FieldWidget(
                                          field: state.fields[index].image,
                                          onTap: () {
                                            LocalDataService.localData!.put(
                                              'fieldIdForDetails',
                                              index,
                                            );
                                            NavigatorService.pushNamedAndRemoveUntil(
                                              context: context,
                                              AppRoutes.fieldDetails,
                                              removeCurrentPage: true,
                                            );
                                          },
                                          courtName: state.fields[index].courtName,
                                          distance: state.fields[index].distance == null
                                              ? null
                                              : MyFieldsCubit.formatDistance(
                                                  state.fields[index].distance!)),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                if (state.fields.isEmpty) const EmpthyFieldsWidget(),
              ],
            ),
          );
        });
  }
}
