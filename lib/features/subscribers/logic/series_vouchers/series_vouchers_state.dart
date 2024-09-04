abstract class SeriesVouchersState {}

class SeriesVouchersInitial extends SeriesVouchersState {}

class SeriesVouchersLoading extends SeriesVouchersState {}

class SeriesVouchersSuccess extends SeriesVouchersState {}

class SeriesVouchersFailure extends SeriesVouchersState {
  final String error;

  SeriesVouchersFailure({required this.error});
}

class SeriesAllVouchersLoading extends SeriesVouchersState {}

class SeriesAllVouchersSuccess extends SeriesVouchersState {}

class SeriesAllVouchersFailure extends SeriesVouchersState {
  final String error;

  SeriesAllVouchersFailure({required this.error});
}