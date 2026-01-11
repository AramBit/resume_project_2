import 'package:flutter/material.dart';

class AddFieldState {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController adressController = TextEditingController();
  static TextEditingController descriptionController = TextEditingController();
  static final FocusNode addressFocusNode = FocusNode();
  AddFieldState({
    this.image,
    this.nameTitleViewer = false,
    this.adressTitleViewer = false,
    this.descriptionTitleViewer = false,
    this.buttonisActive = false,
    this.adressSearchedInfo = false,
    this.adresses = const [],
  });
  final String? image;
  final bool nameTitleViewer;
  final bool adressTitleViewer;
  final bool descriptionTitleViewer;
  final bool buttonisActive;
  final bool adressSearchedInfo;
  final List<String> adresses;
  AddFieldState copyWith({
    String? copyimage,
    bool copyimageRemove = false,
    bool? copynameTitleViewer,
    bool? copyadressTitleViewer,
    bool? copydescriptionTitleViewer,
    bool? copybuttonisActive,
    bool? copyadressSearchedInfo,
    List<String>? copyaadresses,
  }) {
    return AddFieldState(
      image: copyimageRemove ? null : copyimage ?? image,
      nameTitleViewer: copynameTitleViewer ?? nameTitleViewer,
      adressTitleViewer: copyadressTitleViewer ?? adressTitleViewer,
      descriptionTitleViewer: copydescriptionTitleViewer ?? descriptionTitleViewer,
      buttonisActive: copybuttonisActive ?? buttonisActive,
      adressSearchedInfo: copyadressSearchedInfo ?? adressSearchedInfo,
      adresses: copyaadresses ?? adresses,
    );
  }
}
