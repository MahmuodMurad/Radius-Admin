import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/core/services/api/api_consumer.dart';
import 'package:redius_admin/core/services/api/dio_consumer.dart';
import 'package:redius_admin/core/services/api/end_point.dart';
import 'package:redius_admin/core/services/errors/server_exceptions.dart';
import 'package:redius_admin/features/subscribers/data/models/customer_financial_status_model.dart';
import 'package:redius_admin/features/subscribers/data/models/server_group_model.dart';
import 'package:redius_admin/features/subscribers/data/models/subscribers_model.dart';
import 'package:redius_admin/features/subscribers/data/models/user_group_model.dart';
import 'package:redius_admin/main.dart';

class SubscribersRepo {
  final ApiConsumer api = DioConsumer();

  Future<List<DataModel>> getSubscribers() async {
    try {
      final response = await api.get(
        EndPoint.allSubscribers,
      );
     allActiveSubscribers = response['active_users'];
       allUnActiveSubscribers =response['expired_users_count'];
       allOnlineSubscribers = response['online_total'];
      final List<DataModel> subscribers =
          (response['data'] as List).map((e) => DataModel.fromJson(e)).toList();
      return subscribers;
    } on ServerExceptions catch (e) {
      print(e);
      print(e.errorModel.error);
      rethrow;
    }
  }
  Future<List<CustomerFinancialStatusModel>>
  getcustomerFinancialStatus() async {
    try {
      final response = await api.get(
        EndPoint.customerFinancialStatus,
      );
      final List<CustomerFinancialStatusModel> customerFinancialStatus =
      (response as List)
          .map((e) => CustomerFinancialStatusModel.fromJson(e))
          .toList();

      return customerFinancialStatus;
    } on ServerExceptions catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<List<DataModel>> getHostSubscribers() async {
    try {
      final response = await api.get(
        EndPoint.hotspotsSubscribers,
      );
      hotspotActiveSubscribers = response['active_users'];
      hotspotUnActiveSubscribers =response['expired_users_count'];
      hotspotOnlineSubscribers = response['online_total'];
      final List<DataModel> subscribers =
          (response['data'] as List).map((e) => DataModel.fromJson(e)).toList();
      return subscribers;
    } on ServerExceptions catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<DataModel>> getBroadbandSubscribers() async {
    try {
      final response = await api.get(
        EndPoint.broadbandSubscribers,
      );
      brodbandActiveSubscribers = response['active_users'];
      brodbandUnActiveSubscribers =response['expired_users_count'];
      brodbandOnlineSubscribers = response['online_total'];
      final List<DataModel> subscribers =
          (response['data'] as List).map((e) => DataModel.fromJson(e)).toList();
      return subscribers;
    } on ServerExceptions catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<ServerGroupModel>> getServerGroups() async {
    try {
      final response = await api.get(
        EndPoint.serverGroups,
      );
      final List<ServerGroupModel> serverGroups =
          (response as List).map((e) => ServerGroupModel.fromJson(e)).toList();
      return serverGroups;
    } on ServerExceptions catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<List<UserGroupModel>> getUserGroups() async {
    try {
      final response = await api.get(
        EndPoint.userGroups,
      );
      final List<UserGroupModel> userGroups =
      (response as List).map((e) => UserGroupModel.fromJson(e)).toList();
      return userGroups;
    } on ServerExceptions catch (e) {
      print(e);
      rethrow;
    }
  }
  Future<String> addSubscriber({
    required String clientName,
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

  }) async {
    try {
      final formData = FormData.fromMap({
        'client_name': clientName,
        'family': family,
        'username': userName,
        'password': password,
        'mobile': mobile,
        'pin': pin,
        'srv_type': srvType,
        'after_exp': afterExp,
        'after_quota_end': afterQoutaEnd,
        'post_credit': postCredit,
        'server_id': serverId,
        'usergroup': userGroup,
        'note': note,
        'allow_recieve_notifications': allowRecieveNotifications,
        'allow_self_pass_change': allowSelfPassChange,
        'allow_user_panel': allowUserPanel,
        'allow_user_sms': allowUserSms,


      });

      final response = await api.post(
        EndPoint.addSubscriber,
        body: formData,
        isFormData: true,
      );

      print('Subscriber Added');
      return response['status'];
    } on ServerExceptions catch (e) {
      print(e);
      return e.errorModel.error;
    }
  }


  Future<String> deleteSubscriber({required String userName}) async {
    try {
      final formData = FormData.fromMap({
        'username': userName,
      });

      final response = await api.post(
        EndPoint.deleteSubscriber,
        body: formData,
        isFormData: true,
      );

      print('Subscriber Deleted');
      return response['message'];
    } on ServerExceptions catch (e) {
      print(e);

      return e.errorModel.error;
    }
  }
  Future<String> resetSubscription({required String userName}) async {
    try {
      final formData = FormData.fromMap({
        'username': userName,
      });

      final response = await api.post(
        EndPoint.resetSubscription,
        body: formData,
        isFormData: true,
      );

      print('Subscriber reset_subscription');
      return response['message'];
    } on ServerExceptions catch (e) {
      print(e);

      return e.errorModel.error;
    }
  }


  Future<String> resetBalance({required String userName}) async {
    try {
      final formData = FormData.fromMap({
        'username': userName,
      });

      final response = await api.post(
        EndPoint.subscribersResetBalance,
        body: formData,
        isFormData: true,
      );

      print('Subscriber Deleted');
      return response['message'];
    } on ServerExceptions catch (e) {
      print(e);

      return e.errorModel.error;
    }
  }

  Future<String> addBalance({required String userName, required String amount}) async {
    try {
      final formData = FormData.fromMap({
        'username': userName,
        'balance': amount,
      });

      final response = await api.post(
        EndPoint.subscribersAddBalance,
        body: formData,
        isFormData: true,
      );

      print('balance added');
      return response['status'];
    } on ServerExceptions catch (e) {
      print(e);

      return e.errorModel.error;
    }
  }
  Future<String> renewSubscribtion({required String userName, required String id}) async {
    try {
      final formData = FormData.fromMap({
        'username': userName,
        'srv_id': id,
      });

      final response = await api.post(
        EndPoint.subscribersRenewSubscribtion,
        body: formData,
        isFormData: true,
      );

      print('renewSubscribtion');
      return response['message'];
    } on ServerExceptions catch (e) {
      print("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz${e.errorModel.error}");

      return e.errorModel.error;
    }
  }


  // Future<void> addSubscriber({
  //   required String userName,
  //   required String password,
  //   required String userGroup,
  //   required String serverGroup,
  //   required String profile,
  //   required String mac,
  //   required String ip,
  //   required String expireDate,
  //   required String comment,
  // }) async {
  //   try {
  //     await api.post(
  //       EndPoint.addSubscriber,
  //       isFormData: true,
  //       body: {
  //         'username': userName,
  //         'password': password,
  //         'usergroup': userGroup,
  //         'servergroup': serverGroup,
  //         'profile': profile,
  //         'mac': mac,
  //         'ip': ip,
  //         'expiredate': expireDate,
  //         'comment': comment,
  //       },
  //     );
  //   } on ServerExceptions catch (e) {
  //     print.e(e);
  //     rethrow;
  //   }
  // }
}
