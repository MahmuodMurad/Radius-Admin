import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:redius_admin/features/subscribers/data/models/customer_financial_status_model.dart';
import 'package:redius_admin/features/subscribers/data/models/network_usaing_model.dart';
import 'package:redius_admin/features/subscribers/data/models/users_status_model.dart';
import 'package:redius_admin/features/subscribers/data/repos/networks_repo.dart';
import 'package:redius_admin/features/subscribers/logic/Networks/networks_state.dart';

class NetworksCubit extends Cubit<NetworksState> {
  NetworksCubit() : super(NetworksInitial()) {
    getUsersStatus();
    getNetworkUsaing();
    getCustomerFinancialStatus();
  }

  final NetworksRepo networksRepo = NetworksRepo();

  List<UsersStatusModel> usersStatus = [];
  List<CustomerFinancialStatusModel> customerFinancialStatus = [];
  List<NetworkUsaingModel> networkUsaingList = []; // Store list of network usage data

  List<bool> isExpandedList = [];

  void expandList(int index) {
    isExpandedList[index] = !isExpandedList[index];
    emit(ExpandedState()); // Emit state after toggling expansion
  }

  Future<void> getUsersStatus() async {
    emit(GetUsersStatusLoading());
    try {
      final response = await networksRepo.getUsersStatus();
      usersStatus = response;
      emit(GetUsersStatusSuccess(usersStatus: usersStatus));
    } catch (e) {
      emit(GetUsersStatusFailure(error: e.toString()));
    }
  }


  Future<void> getNetworkUsaing() async {
    emit(GetNetworkUsaingLoading());
    try {
      final response = await networksRepo.getNetworkUsaing();
      print("API Response: ${response}");
      networkUsaingList = response; // Ensure this is a list
      emit(GetNetworkUsaingSuccess(networkUsaingList: networkUsaingList));
    } catch (e) {
      print("API Error: $e");
      emit(GetNetworkUsaingFailure(error: e.toString()));
    }
  }


  Future<void> getCustomerFinancialStatus() async {
    emit(GetCustomerFinancialStatusLoading());
    try {
      final response = await networksRepo.getCustomerFinancialStatus();
      customerFinancialStatus = response;
      isExpandedList = List<bool>.filled(customerFinancialStatus.length, false);
      emit(GetCustomerFinancialStatusSuccess(customerFinancialStatus: customerFinancialStatus));
    } catch (e) {
      emit(GetCustomerFinancialStatusFailure(error: e.toString()));
    }
  }
}
