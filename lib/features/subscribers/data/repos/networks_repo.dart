import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:redius_admin/core/services/api/api_consumer.dart';
import 'package:redius_admin/core/services/api/dio_consumer.dart';
import 'package:redius_admin/core/services/api/end_point.dart';
import 'package:redius_admin/core/services/errors/server_exceptions.dart';
import 'package:redius_admin/features/subscribers/data/models/customer_financial_status_model.dart';
import 'package:redius_admin/features/subscribers/data/models/network_usaing_model.dart';
import 'package:redius_admin/features/subscribers/data/models/users_status_model.dart';

class NetworksRepo {
  final ApiConsumer api = DioConsumer();

  Future<List<UsersStatusModel>> getUsersStatus() async {
    try {
      final response = await api.get(EndPoint.networkUsersStatus);
      return (response as List).map((e) => UsersStatusModel.fromJson(e)).toList();
    } on ServerExceptions catch (e) {
      print('Error fetching users status: $e');
      rethrow;
    }
  }

  Future<List<NetworkUsaingModel>> getNetworkUsaing() async {
    try {
      final response = await api.get(EndPoint.networkUsaing);
      return (response as List).map((e) => NetworkUsaingModel.fromJson(e)).toList();
    } on ServerExceptions catch (e) {
      print('Error fetching network usage: $e');
      rethrow;
    }
  }


  Future<List<CustomerFinancialStatusModel>> getCustomerFinancialStatus() async {
    try {
      final response = await api.get(EndPoint.customerFinancialStatus);
      return (response as List).map((e) => CustomerFinancialStatusModel.fromJson(e)).toList();
    } on ServerExceptions catch (e) {
      print('Error fetching customer financial status: $e');
      rethrow;
    }
  }
}

