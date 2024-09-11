import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/core/services/api/api_consumer.dart';
import 'package:redius_admin/core/services/api/dio_consumer.dart';
import 'package:redius_admin/core/services/api/end_point.dart';
import 'package:redius_admin/core/services/errors/server_exceptions.dart';
import 'package:redius_admin/features/subscribers/data/models/offers_model.dart';

class OffersRepo {
  final ApiConsumer api = DioConsumer();

  Future<List<OffersModel>> getOffers() async {
    try {
      final response = await api.get(
        EndPoint.allOffers,
      );
      final List<OffersModel> offers =
          (response as List).map((e) => OffersModel.fromJson(e)).toList();
      return offers;
    } on ServerExceptions catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<String> deleteOffer({required String id}) async {
    try {
      final formData = FormData.fromMap({
        'id': id,
      });

      final response = await api.post(
        EndPoint.deleteOffer,
        body: formData,
        isFormData: true,
      );

      print('offer Deleted');
      return response['message'];
    } on ServerExceptions catch (e) {
      print(e);

      return e.errorModel.error;
    }
  }
  Future<String> addOffer({
    required String srvName,
    required String downloadSpeed,
    required String uploadSpeed,
    required double srvPrice,
    required int srvTime,
    required double gbValue,
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
    try {
      final response = await api.post(
        EndPoint.addOffer,
        isFormData: true,
        body: FormData.fromMap({
          'srv_name': srvName,
          'download_speed': downloadSpeed,
          'upload_speed': uploadSpeed,
          'srv_price': srvPrice,
          'srv_time': srvTime,
          'srv_price_extra': srvPriceExtra,
          // 'down_speed_user': downSpeedUser,
          'download_value': downloadValue,
          'upload_value': uploadValue,
          'gb_value': gbValue,
          'total_qouta': totalQuota,
          'srv_price_extra_gb': srvPriceExtraGb,  // New
          'srv_price_agents': srvPriceAgents,     // New
          'srv_name_agents': srvNameAgents,       // New

        }),
      );
      print("addoffer$response");
      return response['success'];
    } on DioException catch (e) {
      return e.response?.data['error'];
    }
  }

}
