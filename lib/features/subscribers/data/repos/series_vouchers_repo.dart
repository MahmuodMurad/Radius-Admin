import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/core/services/api/api_consumer.dart';
import 'package:redius_admin/core/services/api/dio_consumer.dart';
import 'package:redius_admin/core/services/api/end_point.dart';
import 'package:redius_admin/core/services/errors/server_exceptions.dart';
import 'package:redius_admin/features/subscribers/data/models/series_vouchers_model.dart';
import 'package:redius_admin/features/subscribers/data/models/vouchers_deatails.dart';
import 'package:redius_admin/features/subscribers/ui/vouchers/vochers_detatils.dart';

class SeriesVouchersRepo {
  final ApiConsumer api = DioConsumer();

  Future<List<SeriesVouchersModel>> getSeries() async {
    try {
      final response = await api.get(
        EndPoint.seriesVouchers,
      );
      final List<SeriesVouchersModel> seriesVouchers = (response as List)
          .map((e) => SeriesVouchersModel.fromJson(e))
          .toList();
      return seriesVouchers;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<VouchersDetails>> allVouchers({
    required String vouchersSeries,

  }) async {
    try {
      final response = await api.post(
        EndPoint.allVoucher,
        isFormData: true,
        body:FormData.fromMap( {
          'vouchers_series': vouchersSeries,

        }),
      );
      print("allVoucher$response");
      final List<VouchersDetails> allVouchers = (response as List)
          .map((e) => VouchersDetails.fromJson(e))
          .toList();
      return allVouchers;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> addVoucher({
    required String srvName,
    required String note,
    required double srvPrice,
    required int srvDays,
    required String period,
    required int srvCount,
  }) async {
    try {
      final response = await api.post(
        EndPoint.addVoucher,
        isFormData: true,
        body:FormData.fromMap( {
          'srv_name': srvName,
          'note': note,
          'srv_price': srvPrice,
          'srv_days': srvDays,
          'period': period,
          'srv_count': srvCount,
        }),
      );
      print("addVoucher$response");
      return response;
    } on DioException catch (e) {
      print(e);
      rethrow;
    }
  }
}
