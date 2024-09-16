import 'package:redius_admin/features/subscribers/data/models/customer_financial_status_model.dart';
import 'package:redius_admin/features/subscribers/data/models/network_usaing_model.dart';
import 'package:redius_admin/features/subscribers/data/models/users_status_model.dart';

abstract class NetworksState {}

class NetworksInitial extends NetworksState {}
class ExpandedState extends NetworksState {}
class GetUsersStatusLoading extends NetworksState {}

class GetUsersStatusSuccess extends NetworksState {
  final List<UsersStatusModel> usersStatus;

  GetUsersStatusSuccess({required this.usersStatus});
}

class GetUsersStatusFailure extends NetworksState {
  final String error;

  GetUsersStatusFailure({required this.error});
}

class GetNetworkUsaingLoading extends NetworksState {}

class GetNetworkUsaingSuccess extends NetworksState {
  final List<NetworkUsaingModel> networkUsaingList;

  GetNetworkUsaingSuccess({required this.networkUsaingList});
}


class GetNetworkUsaingFailure extends NetworksState {
  final String error;

  GetNetworkUsaingFailure({required this.error});
}

class GetCustomerFinancialStatusLoading extends NetworksState {}

class GetCustomerFinancialStatusSuccess extends NetworksState {
  final List<CustomerFinancialStatusModel> customerFinancialStatus;

  GetCustomerFinancialStatusSuccess({required this.customerFinancialStatus});
}

class GetCustomerFinancialStatusFailure extends NetworksState {
  final String error;

  GetCustomerFinancialStatusFailure({required this.error});
}
