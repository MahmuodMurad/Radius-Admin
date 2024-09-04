import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/features/subscribers/data/models/offers_model.dart';
import 'package:redius_admin/features/subscribers/data/repos/offers_repo.dart';
import 'package:redius_admin/features/subscribers/logic/offers/offers_state.dart';

class OffersCubit extends Cubit<OffersState> {
  OffersCubit() : super(OffersInitial()) {
    getOffers();
  }

  final OffersRepo offersRepo = OffersRepo();

   List<OffersModel> offers = [];
  int _selecteddownloadSpeedUnit = 0; // Default to GB

  int get selecteddownloadSpeedUnit => _selecteddownloadSpeedUnit;

  void updateDownloadSelectedUnit(int value) {
    _selecteddownloadSpeedUnit = value;
    emit(OffersUnitChanged(value: value));
  }
  int _selectedUploadSpeedUnit = 0; // Default to GB

  int get selectedUploadSpeedUnit => _selectedUploadSpeedUnit;

  void updateUploadSelectedUnit(int value) {
    _selectedUploadSpeedUnit = value;
    emit(OffersUnitChanged(value: value));
  }
  int _selectedGBSpeedUnit = 0; // Default to GB

  int get selectedGBSpeedUnit => _selectedGBSpeedUnit;

  void updateGBSelectedUnit(int value) {
    _selectedGBSpeedUnit = value;
    emit(OffersUnitChanged(value: value));
  }
  Future<void> getOffers() async {
    emit(OffersLoading());
    try {
      final response = await offersRepo.getOffers();
      offers=response;
      print(offers.first.toJson());
      emit(OffersSuccess());
    } catch (e) {
      emit(OffersFailure(error: e.toString()));
    }
  }
  Future<void> addOffer({
    required BuildContext context,
    required String srvName,
    required String downloadSpeed,
    required String uploadSpeed,
    required double srvPrice,
    required int srvTime,
    required int gbValue,
    required int totalQuota,
    required double srvPriceExtra,
    // required double downSpeedUser,
    required double downloadValue,
    required double uploadValue,
    required double srvPriceExtraGb,    // New
    required double srvPriceAgents,     // New
    required String srvNameAgents,      // New
          // New
  }) async {
    emit(OffersLoading());
    try {
      // Call the API to add offer
      await offersRepo.addOffer(
        srvPriceExtra: srvPriceExtra,
        // downSpeedUser: downSpeedUser,
        downloadValue: downloadValue,
        uploadValue: uploadValue,
        srvName: srvName,
        downloadSpeed: downloadSpeed,
        uploadSpeed: uploadSpeed,
        srvPrice: srvPrice,
        srvTime: srvTime,
        gbValue: gbValue,
        totalQuota: totalQuota,
        srvPriceExtraGb: srvPriceExtraGb,   // New
        srvPriceAgents: srvPriceAgents,     // New
        srvNameAgents: srvNameAgents,       // New
           // New
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم اضافه العرض بنجاح'), backgroundColor: Colors.green),
      );
      await getOffers();
      Navigator.pop(context);
      emit(OffersSuccess());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(content: Text( e.toString()), backgroundColor: Colors.red),
      );
      emit(OffersFailure(error: e.toString()));
    }
  }

}
