import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/features/subscribers/data/models/series_vouchers_model.dart';
import 'package:redius_admin/features/subscribers/data/models/vouchers_deatails.dart';
import 'package:redius_admin/features/subscribers/data/repos/series_vouchers_repo.dart';
import 'package:redius_admin/features/subscribers/logic/series_vouchers/series_vouchers_state.dart';
import 'package:redius_admin/features/subscribers/ui/vouchers/vochers_detatils.dart';

class SeriesVouchersCubit extends Cubit<SeriesVouchersState> {
  SeriesVouchersCubit() : super(SeriesVouchersInitial()) {
    getSeriesVouchers();
  }

  final SeriesVouchersRepo seriesRepo = SeriesVouchersRepo();

  List<SeriesVouchersModel> seriesVouchers = [];
  List<VouchersDetails> vouchersDetails = [];

  Future<void> getSeriesVouchers() async {
    emit(SeriesVouchersLoading());
    try {
      final response = await seriesRepo.getSeries();
      seriesVouchers = response;
      print(seriesVouchers.first.toJson());
      emit(SeriesVouchersSuccess());
    } catch (e) {
      emit(SeriesVouchersFailure(error: e.toString()));
    }
  }
  Future<void> allVoucher({
    required String vouchersSeries,

  }) async {
    emit(SeriesAllVouchersLoading());
    try {
     final response = await seriesRepo.allVouchers(
        vouchersSeries: vouchersSeries,

      );
      vouchersDetails = response;
      emit(SeriesAllVouchersSuccess());
    } catch (e) {
      emit(SeriesAllVouchersFailure(error: e.toString()));
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
    emit(SeriesVouchersLoading());
    try {
      await seriesRepo.addVoucher(
        srvName: srvName,
        note: note,
        srvPrice: srvPrice,
        srvDays: srvDays,
        period: period,
        srvCount: srvCount,
      );
      await getSeriesVouchers(); // Refresh the vouchers list after adding a new one
      emit(SeriesVouchersSuccess());
    } catch (e) {
      emit(SeriesVouchersFailure(error: e.toString()));
    }
  }
}
