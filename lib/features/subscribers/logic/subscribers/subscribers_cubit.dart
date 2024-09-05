import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/core/shared_widgets/toast.dart';
import 'package:redius_admin/features/subscribers/data/models/customer_financial_status_model.dart';
import 'package:redius_admin/features/subscribers/data/models/server_group_model.dart';
import 'package:redius_admin/features/subscribers/data/models/subscribers_model.dart';
import 'package:redius_admin/features/subscribers/data/models/user_group_model.dart';
import 'package:redius_admin/features/subscribers/data/repos/subscribers_repo.dart';
import 'package:redius_admin/features/subscribers/logic/subscribers/subscribers_state.dart';

class SubscribersCubit extends Cubit<SubscribersState> {
  SubscribersCubit() : super(SubscribersInitial()) {
    _initialize();
  }

  final SubscribersRepo _subscribersRepo = SubscribersRepo();

  List<SubscribersModel> allSubscribers = [];
  List<SubscribersModel> hostSubscribers = [];
  List<SubscribersModel> broadbandSubscribers = [];
  List<ServerGroupModel> serverGroups = [];
  List<UserGroupModel> userGroups = [];
  List<CustomerFinancialStatusModel> customerFinancialStatus = [];

  void _initialize() {
    getSubscribers();
    getHostSubscribers();
    getBroadbandSubscribers();
    getServerGroups();
    getUserGroups();
    getCustomerFinancialStatus();
  }

  Future<void> getCustomerFinancialStatus() async {
    emit(GetCustomerFinancialStatusLoading());
    try {
      final response = await _subscribersRepo.getcustomerFinancialStatus();

      customerFinancialStatus.addAll(response);
      print(customerFinancialStatus.first.toJson());
      emit(GetCustomerFinancialStatusSuccess());
    } catch (e) {
      print(e.toString());
      emit(GetCustomerFinancialStatusFailure(error: e.toString()));
    }
  }

  Future<void> getSubscribers() async {
    emit(AllSubscribersLoading());
    try {
      final response = await _subscribersRepo.getSubscribers();
      allSubscribers = response;
      emit(AllSubscribersSuccess());
    } catch (e) {
      print("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa$e");
      emit(AllSubscribersFailure(error: e.toString()));
    }
  }

  Future<void> getHostSubscribers() async {
    try {
      final response = await _subscribersRepo.getHostSubscribers();
      hostSubscribers = response;
      emit(HostSubscribersSuccess());
    } catch (e) {
      print("wwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwwww$e");
      emit(HostSubscribersFailure(error: e.toString()));
    }
  }

  Future<void> getBroadbandSubscribers() async {
    try {
      final response = await _subscribersRepo.getBroadbandSubscribers();
      broadbandSubscribers = response;
      emit(BroadbandSubscribersSuccess());
    } catch (e) {
      emit(BroadbandSubscribersFailure(error: e.toString()));
    }
  }

  Future<void> getServerGroups() async {
    try {
      final response = await _subscribersRepo.getServerGroups();
      serverGroups = response;
      emit(ServerGroupsSuccess());
    } catch (e) {
      emit(ServerGroupsFailure(error: e.toString()));
    }
  }

  Future<void> getUserGroups() async {
    try {
      final response = await _subscribersRepo.getUserGroups();
      userGroups = response;
      emit(UserGroupsSuccess());
    } catch (e) {
      emit(UserGroupsFailure(error: e.toString()));
    }
  }

  Future<void> addSubscribers(
      {required String clientName,
      required String family,
      required String userName,
      required String password,
      required String mobile,
      required String pin,
      required String srvType,
      required String afterExp,
      required String afterQoutaEnd,
      required String postCredit,
      required String serverId,
      required String userGroup,
      required String note,
      required String allowRecieveNotifications,
      required String allowSelfPassChange,
      required String allowUserPanel,
      required String allowUserSms,
      required BuildContext context}) async {
    emit(AddSubscribersLoading());
    try {
      final response = await _subscribersRepo.addSubscriber(
        clientName: clientName,
        family: family,
        userName: userName,
        password: password,
        mobile: mobile,
        pin: pin,
        srvType: (int.parse(srvType) + 1).toString(),
        afterExp: afterExp,
        afterQoutaEnd: afterQoutaEnd,
        postCredit: postCredit,
        serverId: serverId,
        userGroup: userGroup,
        note: note,
        allowRecieveNotifications: allowRecieveNotifications,
        allowSelfPassChange: allowSelfPassChange,
        allowUserPanel: allowUserPanel,
        allowUserSms: allowUserSms,
      );
      print("addSubscribers $userName");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                response == "success" ? "تمت العملية بنجاح" : "فشلت العملية"),
            backgroundColor: response == "success" ? Colors.green : Colors.red),
      );
      getSubscribers();
      getHostSubscribers();
      getBroadbandSubscribers();
      emit(AddSubscribersSuccess());
    } catch (e) {
      emit(AddSubscribersFailure(error: e.toString()));
    }
  }

  Future<void> deleteSubscribers(
      {required String userName, required BuildContext context}) async {
    emit(DeleteSubscribersLoading());
    try {
      final response =
          await _subscribersRepo.deleteSubscriber(userName: userName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("تم حذف $userName بنجاح "),
            backgroundColor: Colors.green),
      );
      print("deleteSubscribers $userName");

      allSubscribers.removeWhere((item) => item.username == userName);
      hostSubscribers.removeWhere((item) => item.username == userName);
      broadbandSubscribers.removeWhere((item) => item.username == userName);

      // emit(AllSubscribersUpdated());

      emit(DeleteSubscribersSuccess());
    } catch (e) {
      emit(DeleteSubscribersFailure(error: e.toString()));
    }
  }

  Future<void> resetBalance(
      {required String userName, required BuildContext context}) async {
    emit(DeleteSubscribersLoading());
    try {
      final response = await _subscribersRepo.resetBalance(userName: userName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("تم تصفير الحساب ل $userName بنجاح"),
            backgroundColor: Colors.green),
      );
      print("restBalanse for $userName");
      emit(DeleteSubscribersSuccess());
    } catch (e) {
      emit(DeleteSubscribersFailure(error: e.toString()));
    }
  }

  Future<void> addBalance(
      {required String userName,
        required BuildContext context,
        required String amount}) async {
    emit(AddBalanceLoading());
    try {
      await _subscribersRepo.addBalance(userName: userName, amount: amount);
      emit(AddBalanceSuccess());
    } catch (e) {
      emit(AddBalanceFailure(error: e.toString()));
    }
  }


  Future<void> renewSubscribtion(
      {required String userName,
      required BuildContext context,
      required String id}) async {
    emit(RenewSubscribersLoading());
    try {
      final response =
          await _subscribersRepo.renewSubscribtion(userName: userName, id: id);
      print(response);
      getSubscribers();
      getHostSubscribers();
      getBroadbandSubscribers();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response), backgroundColor: Colors.green),
      );
      print("شييBalanse for $userName");
      emit(RenewSubscribersSuccess());
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.green),
      );
      print(e.toString());
      emit(RenewSubscribersFailure(error: e.toString()));
    }
  }
}
