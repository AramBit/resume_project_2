import 'dart:io';

import 'package:app_b_839/screens/theme/app_colors.dart';
import 'package:app_b_839/screens/theme/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../core/utils/local_data_service.dart';
import '../../core/utils/location_adress_route_service.dart';
import '../../gen/assets.gen.dart';
import '../../model/field_model.dart';
import '../addFieldCubit/add_field_cubit.dart';
import '../myFieldsCubit/my_fields_cubit.dart';
import 'field_details_state.dart';

class FieldDetailsCubit extends Cubit<FieldDetailsState> {
  FieldDetailsCubit()
      : super(
          FieldDetailsState(),
        );
  void clearData() {
    emit(
      state.copyWith(),
    );
  }

  Future<void> getListApps(BuildContext context) async {
    final availableMaps = await MapLauncher.installedMaps;
    if (availableMaps.isEmpty) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Нет доступных приложений карт")),
      );
      return;
    }
    showModalBottomSheet(
      // ignore: use_build_context_synchronously
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return ListView.builder(
          itemCount: availableMaps.length,
          itemBuilder: (context, index) {
            final map = availableMaps[index];
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundOne,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 86, 85, 85).withOpacity(0.15),
                      blurRadius: 6,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  leading: SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipOval(
                      child: SvgPicture.asset(
                        map.icon,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  title: Text(
                    map.mapName,
                    style: AppTextStyles.extraBold16,
                  ),
                  onTap: () async {
                    await map.showMarker(
                      coords: Coords(
                        state.currentFieldLocationLat,
                        state.currentFieldLocationLon,
                      ),
                      title: "Ocean Beach",
                    );
                    Navigator.pop(context);
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  void removeCourte(int index, BuildContext context) {
    List<FieldModel> result = AddFieldCubit.getFieldAsAnList();
    result.removeAt(index);
    LocalDataService.localData!.put('fields', result);
    MyFieldsCubit.myFieldsCubit!.getFields();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void moveToFieldLocation() async {
    final currentLocation = await LocationAddressRouteService().getCurrentLocation();

    if (currentLocation == null) return;
    final geo = await LocationAddressRouteService().mapboxGeocode(state.field!.adress);
    if (geo == null) {
      return null;
    }
    final route = await LocationAddressRouteService().getRouteMapbox(
      currentLocation.latitude!,
      currentLocation.longitude!,
      geo['lat'],
      geo['lng'],
    );

    if (route != null && route['routes'].isNotEmpty) {
      emit(
        state.copyWith(
          copycurrentFieldLocationLat: geo['lat'].toDouble(),
          copycurrentFieldLocationLon: geo['lng'].toDouble(),
          copydistance: route['routes'][0]['distance'].toDouble(),
        ),
      );
    }

    moveMap();
  }

  double _calculateDistance(LatLng from, LatLng to) {
    const Distance d = Distance();
    return d.as(LengthUnit.Meter, from, to);
  }

  void listenLocation() {
    Location location = Location();

    location.onLocationChanged.listen((LocationData currentLocation) {
      final LatLng newPosition = LatLng(
        currentLocation.latitude!,
        currentLocation.longitude!,
      );

      emit(state.copyWith(
        copydistance: _calculateDistance(
          LatLng(state.currentFieldLocationLat, state.currentFieldLocationLon),
          newPosition,
        ),
      ));

      moveToFieldLocation();
    });
  }

  void moveMap() {
    final target = LatLng(state.currentFieldLocationLat, state.currentFieldLocationLon);

    FieldDetailsState.mapController.move(target, 15.0);

    List<Marker> markers = [
      Marker(
        width: 20,
        height: 20,
        point: target,
        child: Image.asset(
          Assets.images.pin2.path,
          width: 20,
        ),
      ),
    ];

    emit(
      state.copyWith(
        copymarkers: markers,
      ),
    );
  }

  Future<void> shareField({
    String? imagePath,
    required String name,
    required String address,
    required String description,
    required ScreenshotController screenshotController,
  }) async {
    final String mapsUrl = "https://maps.google.com/?q=${Uri.encodeComponent(address)}";

    final String shareText = "$name\n\n$description\n\n📍 Адрес: $mapsUrl";

    // 1. Делаем скриншот через screenshot package
    final bytes = await screenshotController.capture();
    if (bytes == null) return;

    // 2. Сохраняем во временный файл
    final directory = await getTemporaryDirectory();
    final String screenshotPath = '${directory.path}/screenshot.png';
    final File screenshotFile = File(screenshotPath);
    await screenshotFile.writeAsBytes(bytes);

    // 3. Готовим список файлов
    List<XFile> files = [XFile(screenshotFile.path)];
    if (imagePath != null && imagePath.isNotEmpty) {
      files.add(XFile(imagePath));
    }

    // 4. Шарим
    await Share.shareXFiles(
      files,
      text: shareText,
      subject: "Поле: $name",
    );
  }

  void getField() {
    int fieldId = LocalDataService.localData!.get('fieldIdForDetails') ?? 0;
    FieldModel result = AddFieldCubit.getFieldAsAnList()[fieldId];
    emit(
      state.copyWith(
        copyfield: result,
        copyfieldId: fieldId,
      ),
    );
  }
}
