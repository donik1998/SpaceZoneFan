import 'package:flutter/material.dart';
import 'package:space_fun_zone/data/models/apod_model.dart';
import 'package:space_fun_zone/data/services/apod_service.dart';

class PictureOfDayProvider extends ChangeNotifier {
  PictureOfDayProvider() {
    loadData();
  }
  APODModel? _apod;
  bool _isLoading = true;

  Future<void> loadData() async {
    final apod = await ApodService.instance.getPictureOfDay();
    _isLoading = false;
    if (apod is APODModel) _apod = apod;
    notifyListeners();
  }

  APODModel? get apod => _apod;

  bool get isLoading => _isLoading;
}
