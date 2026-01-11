import 'package:app_b_839/screens/globalWidgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:screenshot/screenshot.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/location_adress_route_service.dart';
import '../../core/utils/size_utils.dart';
import '../../cubit/fieldDetailsCubit/field_details_cubit.dart';
import '../../cubit/fieldDetailsCubit/field_details_state.dart';
import '../../cubit/myFieldsCubit/my_fields_cubit.dart';
import '../../gen/assets.gen.dart';
import '../globalWidgets/custom_appbar.dart';
import '../globalWidgets/main_button.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../theme/app_texts.dart';
import 'widgets/field_description_widget.dart';
import 'widgets/show_more.dart';

class FieldDetails extends StatefulWidget {
  const FieldDetails({super.key});
  static FieldDetailsCubit? fieldDetailsCubit;

  @override
  State<FieldDetails> createState() => _FieldDetailsState();
}

class _FieldDetailsState extends State<FieldDetails> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        FieldDetails.fieldDetailsCubit!.getField();
        FieldDetails.fieldDetailsCubit!.moveToFieldLocation();
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FieldDetails.fieldDetailsCubit = context.watch<FieldDetailsCubit>();

    return BlocBuilder<FieldDetailsCubit, FieldDetailsState>(
      bloc: FieldDetails.fieldDetailsCubit,
      builder: (context, state) {
        return WillPopScope(
          onWillPop: () async {
            const target = LatLng(38.9072, -77.0369);

            FieldDetailsState.mapController.move(target, 15.0);
            Navigator.pop(context);
            return false;
          },
          child: Scaffold(
            backgroundColor: AppColors.backgroundOne,
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomAppBar(
                        text: AppTexts.fIELDDETAILS,
                        backOnTap: () {
                          const target = LatLng(38.9072, -77.0369);

                          FieldDetailsState.mapController.move(target, 15.0);
                          Navigator.pop(context);
                        },
                        rightWidget: GestureDetector(
                          onTap: () {
                            showDialog(
                              barrierLabel: "BlurPopup",
                              context: context,
                              builder: (_) => ShowMore(
                                state: state,
                              ),
                            );
                          },
                          child: CustomImageView(
                            imagePath: Assets.images.menuMore.path,
                            width: ResponsiveExtension.screenWidth / 10,
                          ),
                        ),
                      ),
                      Screenshot(
                        controller: FieldDetailsState.screenshotController,
                        child: Column(
                          children: [
                            FieldDescriptionWidget(
                              image: state.field?.image,
                              courtName: state.field == null ? '' : state.field!.courtName,
                              addres: state.field == null ? '' : state.field!.adress,
                              description:
                                  state.field == null ? '' : state.field!.description ?? '',
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                              ),
                              height: ResponsiveExtension.screenWidth / 2,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: FlutterMap(
                                      mapController: FieldDetailsState.mapController,
                                      options: const MapOptions(
                                        initialCenter: LatLng(38.9072, -77.0369),
                                        initialZoom: 9.2,
                                      ),
                                      children: [
                                        TileLayer(
                                          urlTemplate:
                                              "https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}",
                                          additionalOptions: {
                                            'accessToken':
                                                LocationAddressRouteService().mapboxApiKey,
                                            'id': 'mapbox/streets-v11',
                                          },
                                          userAgentPackageName: 'com.example.app',
                                        ),
                                        MarkerLayer(
                                          markers: state.markers,
                                        ),
                                        RichAttributionWidget(
                                          attributions: [
                                            TextSourceAttribution(
                                              '© Mapbox',
                                              onTap: () => launchUrl(
                                                Uri.parse('https://www.mapbox.com/about/maps/'),
                                              ),
                                            ),
                                            TextSourceAttribution(
                                              '© OpenStreetMap contributors',
                                              onTap: () => launchUrl(
                                                Uri.parse(
                                                    'https://www.openstreetmap.org/copyright'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: Container(
                                      margin: const EdgeInsets.only(
                                        top: 15,
                                        right: 15,
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10,
                                        vertical: 10,
                                      ),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          width: 1,
                                          color: const Color(0xffa1abb5),
                                        ),
                                        color: AppColors.layerOne,
                                        borderRadius: BorderRadius.circular(
                                          6,
                                        ),
                                      ),
                                      child: Text.rich(
                                        textAlign: TextAlign.center,
                                        TextSpan(
                                          children: [
                                            TextSpan(
                                              text: AppTexts.dIStance,
                                              style: AppTextStyles.bold12.copyWith(
                                                color: AppColors.layerThree,
                                                fontWeight: FontWeight.bold,
                                                fontSize: ResponsiveExtension.screenWidth / 35,
                                              ),
                                            ),
                                            TextSpan(
                                              text: state.distance == null
                                                  ? '   NO DATA'
                                                  : '   ${MyFieldsCubit.formatDistance(state.distance!)} METERS',
                                              style: AppTextStyles.bold12.copyWith(
                                                color: AppColors.accentTwo,
                                                fontWeight: FontWeight.bold,
                                                fontSize: ResponsiveExtension.screenWidth / 35,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: MainButton(
                          text: AppTexts.goToMap,
                          onTap: () {
                            FieldDetails.fieldDetailsCubit!.getListApps(context);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),

                // const EmpthyFieldsWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}
