import 'dart:convert';
import 'dart:io';

import 'package:app_b_839/core/utils/local_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

import '../../core/utils/image_service.dart';
import '../../core/utils/location_adress_route_service.dart';
import '../../model/field_model.dart';
import '../../screens/fieldDetails/field_details.dart';
import '../myFieldsCubit/my_fields_cubit.dart';
import '../newGameCubit/new_game_cubit.dart';
import 'add_field_state.dart';

class AddFieldCubit extends Cubit<AddFieldState> {
  AddFieldCubit()
      : super(
          AddFieldState(),
        );

  void getEditData(int? id) {
    if (id == null) return;
    FieldModel result = getField();
    AddFieldState.nameController.text = result.courtName;
    AddFieldState.adressController.text = result.adress;

    AddFieldState.descriptionController.text = result.description ?? '';
    emit(
      state.copyWith(
        copyimage: result.image,
        copybuttonisActive: true,
        copyadressTitleViewer: true,
        copydescriptionTitleViewer: true,
        copynameTitleViewer: true,
      ),
    );
  }

  FieldModel getField() {
    int fieldId = LocalDataService.localData!.get('fieldIdForDetails') ?? 0;
    FieldModel result = AddFieldCubit.getFieldAsAnList()[fieldId];
    return result;
  }

  void clearData() {
    AddFieldState.adressController.clear();
    AddFieldState.nameController.clear();
    AddFieldState.descriptionController.clear();
    emit(
      state.copyWith(
        copyimageRemove: true,
        copyadressTitleViewer: false,
        copybuttonisActive: false,
        copydescriptionTitleViewer: false,
        copynameTitleViewer: false,
        copyaadresses: [],
        copyadressSearchedInfo: false,
      ),
    );
  }

  static List<FieldModel> getFieldAsAnList() {
    List<FieldModel> result = [];
    for (FieldModel e in (LocalDataService.localData!.get('fields') ?? [])) {
      result.add(e);
    }
    return result;
  }

  void saveField(BuildContext context, {int? fieldId, required int fieldType}) {
    if (!state.buttonisActive) return;
    List<FieldModel> result = getFieldAsAnList();
    if (fieldId != null) {
      result[fieldId] = FieldModel(
        distance: null,
        image: state.image,
        courtName: AddFieldState.nameController.text,
        adress: AddFieldState.adressController.text,
        description: AddFieldState.descriptionController.text,
      );
    } else {
      result.insert(
        0,
        FieldModel(
          distance: null,
          image: state.image,
          courtName: AddFieldState.nameController.text,
          adress: AddFieldState.adressController.text,
          description: AddFieldState.descriptionController.text,
        ),
      );
    }

    LocalDataService.localData!.put(
      'fields',
      result,
    );
    if (fieldType == 0) MyFieldsCubit.myFieldsCubit!.getFields();
    if (fieldType == 1) NewGameCubit.newGameCubit!.getFields();

    if (fieldId != null) {
      FieldDetails.fieldDetailsCubit!.getField();
      FieldDetails.fieldDetailsCubit!.moveToFieldLocation();
    }

    Navigator.pop(context);

    clearData();
  }

  void changeStateAdressesWindow(bool value) {
    emit(
      state.copyWith(
        copyadressSearchedInfo: value,
      ),
    );
  }

  void clearField(int type, BuildContext context) {
    switch (type) {
      case 0:
        AddFieldState.nameController.clear();
        emit(
          state.copyWith(
            copynameTitleViewer: false,
          ),
        );
        break;
      case 1:
        AddFieldState.adressController.clear();
        emit(
          state.copyWith(
            copyadressTitleViewer: false,
          ),
        );
        break;
      case 2:
        AddFieldState.descriptionController.clear();
        emit(
          state.copyWith(
            copydescriptionTitleViewer: false,
          ),
        );
        break;
    }
    fieldsValidation();
    FocusScope.of(context).unfocus();
  }

  void onChangeName(String value) async {
    bool titleViewerResult = false;
    if (value.replaceAll(' ', '').isNotEmpty) {
      titleViewerResult = true;
    }
    fieldsValidation();

    changeStateAdressesWindow(false);

    emit(
      state.copyWith(
        copynameTitleViewer: titleViewerResult,
      ),
    );
  }

  void onChangeAdress(String value) {
    bool titleViewerResult = false;
    if (value.replaceAll(' ', '').isNotEmpty) {
      titleViewerResult = true;
    }
    fieldsValidation();
    searchAddress(value);
    LocationAddressRouteService().getCurrentLocation();
    emit(
      state.copyWith(
        copyadressTitleViewer: titleViewerResult,
        copyadressSearchedInfo: titleViewerResult,
      ),
    );
  }

  void chosesRecomendedAdress(int index) {
    AddFieldState.adressController.text = state.adresses[index];
    emit(
      state.copyWith(
        copyadressSearchedInfo: false,
      ),
    );
  }

  Future<void> searchAddress(String query) async {
    final url = Uri.parse(
      "https://nominatim.openstreetmap.org/search?q=$query&format=json&addressdetails=1&limit=5",
    );
    final response =
        await http.get(url, headers: {"User-Agent": "YourAppName/1.0 (youremail@example.com)"});
    if (response.statusCode == 200) {
      List<String> result = [];
      final List data = json.decode(response.body);
      for (Map name in data) {
        result.add(name['display_name']);
      }
      emit(
        state.copyWith(
          copyaadresses: result,
        ),
      );
    } else {
      throw Exception("Ошибка запроса: ${response.statusCode}");
    }
  }

  void onChangeDescription(String value) {
    bool titleViewerResult = false;
    // bool buttonResult = true;
    // String text = value.replaceAll(' ', '');
    // if (text.isNotEmpty) {
    //   titleViewerResult = true;
    //   if (text.isNotEmpty && text.length <= 3) {
    //     buttonResult = false;
    //   }
    // }
    changeStateAdressesWindow(false);
    fieldsValidation();

    emit(
      state.copyWith(
        copydescriptionTitleViewer: titleViewerResult,
        // copybuttonisActive: buttonResult,
      ),
    );
  }

  void fieldsValidation() {
    bool validResult = false;
    String name = AddFieldState.nameController.text.replaceAll(' ', '');
    String adress = AddFieldState.adressController.text.replaceAll(' ', '');
    String description = AddFieldState.descriptionController.text.replaceAll(' ', '');

    if (name.length >= 3 && adress.length >= 3) {
      validResult = true;
    }
    if (description.isNotEmpty && description.length < 3) {
      validResult = false;
    }
    emit(
      state.copyWith(
        copybuttonisActive: validResult,
      ),
    );
  }

  static Future<bool> requestPermissions() async {
    try {
      if (Platform.isAndroid) {
        final photos = await Permission.photos.request();
        final storage = await Permission.storage.request();
        final media = await Permission.mediaLibrary.request();
        final manage = await Permission.manageExternalStorage.request();

        return photos.isGranted || storage.isGranted || media.isGranted || manage.isGranted;
      } else if (Platform.isIOS) {
        final photos = await Permission.photos.request();

        return photos.isGranted;
      }
    } catch (e) {
      print('Permission request error: $e');
    }

    return false;
  }

  void addImage() async {
    final hasPermission = await requestPermissions();
    if (!hasPermission) {
      print('Permission not granted');
      return;
    }

    String? filePath = await ImageService.pickAndSaveImage();
    if (filePath != null) {
      emit(
        state.copyWith(
          copyimage: filePath,
        ),
      );
    }
  }
}
