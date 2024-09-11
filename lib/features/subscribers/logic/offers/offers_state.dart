abstract class OffersState {}

final class OffersInitial extends OffersState {}

final class OffersLoading extends OffersState {}


final class OffersSuccess extends OffersState {


  OffersSuccess();
}

final class OffersFailure extends OffersState {
  final String error;

  OffersFailure({required this.error});
}
final class OffersUnitChanged extends OffersState {
final int value;
  OffersUnitChanged({required this.value});

}

final class DeleteOfferLoading extends OffersState {}

final class DeleteOfferSuccess extends OffersState {}

final class DeleteOfferFailure extends OffersState {
  final String error;

  DeleteOfferFailure({required this.error});
}