class SubscribersModel {
  final String username;
  final String fullname;
  final String subscriptionType;
  final String credit;
  final String expireDate;
  final String createdBy;
  final String totalQuota;
  final String currentPlan;
  final String totalUsed;
  final bool onlineStatus;

  SubscribersModel({
    required this.username,
    required this.fullname,
    required this.subscriptionType,
    required this.credit,
    required this.expireDate,
    required this.createdBy,
    required this.totalQuota,
    required this.currentPlan,
    required this.totalUsed,
    required this.onlineStatus,
  });

  factory SubscribersModel.fromJson(Map<String, dynamic> json) {
    return SubscribersModel(
      username: json['username'],
      fullname: json['fullname'],
      subscriptionType: json['subscribtion_type'],
      credit: json['credit'],
      expireDate: json['expire_date'],
      createdBy: json['created_by'],
      totalQuota: json['total_qouta'],
      currentPlan: json['current_plan'],
      totalUsed: json['total_used'],
      onlineStatus: json['online_status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'fullname': fullname,
      'subscribtion_type': subscriptionType,
      'credit': credit,
      'expire_date': expireDate,
      'created_by': createdBy,
      'total_qouta': totalQuota,
      'current_plan': currentPlan,
      'total_used': totalUsed,
      'online_status': onlineStatus,
    };
  }
}