abstract class SubscribersState {}

class SubscribersInitial extends SubscribersState {}

class AllSubscribersLoading extends SubscribersState {}

class AllSubscribersSuccess extends SubscribersState {}

class AllSubscribersFailure extends SubscribersState {
  final String error;

  AllSubscribersFailure({required this.error});
}

class HostSubscribersLoading extends SubscribersState {}

class HostSubscribersSuccess extends SubscribersState {}

class HostSubscribersFailure extends SubscribersState {
  final String error;

  HostSubscribersFailure({required this.error});
}

class BroadbandSubscribersLoading extends SubscribersState {}

class BroadbandSubscribersSuccess extends SubscribersState {}

class BroadbandSubscribersFailure extends SubscribersState {
  final String error;

  BroadbandSubscribersFailure({required this.error});
}

class ServerGroupsLoading extends SubscribersState {}

class ServerGroupsSuccess extends SubscribersState {}

class ServerGroupsFailure extends SubscribersState {
  final String error;

  ServerGroupsFailure({required this.error});
}

class UserGroupsLoading extends SubscribersState {}

class UserGroupsSuccess extends SubscribersState {}

class UserGroupsFailure extends SubscribersState {
  final String error;

  UserGroupsFailure({required this.error});
}

class DeleteSubscribersLoading extends SubscribersState {}

class DeleteSubscribersSuccess extends SubscribersState {}

class DeleteSubscribersFailure extends SubscribersState {
  final String error;

  DeleteSubscribersFailure({required this.error});
}
class ReseteSubscriptionSubscribersLoading extends SubscribersState {}

class ReseteSubscriptionSubscribersSuccess extends SubscribersState {}

class ReseteSubscriptionSubscribersFailure extends SubscribersState {
  final String error;

  ReseteSubscriptionSubscribersFailure({required this.error});
}
class RenewSubscribersLoading extends SubscribersState {}

class RenewSubscribersSuccess extends SubscribersState {}

class RenewSubscribersFailure extends SubscribersState {
  final String error;

  RenewSubscribersFailure({required this.error});
}
class AllSubscribersUpdated extends SubscribersState {}

class AddSubscribersLoading extends SubscribersState {}

class AddSubscribersSuccess extends SubscribersState {

}

class AddSubscribersFailure extends SubscribersState {
  final String error;

  AddSubscribersFailure({required this.error});
}
class GetCustomerFinanciallStatusLoading extends SubscribersState {}

class GetCustomerFinanciallStatusSuccess extends SubscribersState {}

class GetCustomerFinanciallStatusFailure extends SubscribersState {
  final String error;

  GetCustomerFinanciallStatusFailure({required this.error});
}

class AddBalanceLoading extends SubscribersState {}

class AddBalanceSuccess extends SubscribersState {}

class AddBalanceFailure extends SubscribersState {
  final String error;

  AddBalanceFailure({required this.error});
}