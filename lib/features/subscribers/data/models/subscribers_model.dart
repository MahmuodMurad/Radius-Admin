class SubscribersModel {
  List<DataModel>? data;
  int? onlineTotal;
  int? expiredUsersCount;
  int? activeUsers;

  SubscribersModel(
      {this.data, this.onlineTotal, this.expiredUsersCount, this.activeUsers});

  SubscribersModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DataModel>[];
      json['data'].forEach((v) {
        data!.add(new DataModel.fromJson(v));
      });
    }
    onlineTotal = json['online_total'];
    expiredUsersCount = json['expired_users_count'];
    activeUsers = json['active_users'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['online_total'] = this.onlineTotal;
    data['expired_users_count'] = this.expiredUsersCount;
    data['active_users'] = this.activeUsers;
    return data;
  }
}

class DataModel {
  String? username;
  String? fullname;
  String? subscribtionType;
  String? credit;
  String? expireDate;
  String? createdBy;
  String? totalQouta;
  String? currentPlan;
  String? totalUsed;
  String? balance;
  String? remainingQouta;
  bool? onlineStatus;

  DataModel(
      {this.username,
        this.fullname,
        this.subscribtionType,
        this.credit,
        this.expireDate,
        this.createdBy,
        this.totalQouta,
        this.currentPlan,
        this.totalUsed,
        this.balance,
        this.remainingQouta,
        this.onlineStatus});

  DataModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    fullname = json['fullname'];
    subscribtionType = json['subscribtion_type'];
    credit = json['credit'];
    expireDate = json['expire_date'];
    createdBy = json['created_by'];
    totalQouta = json['total_qouta'];
    currentPlan = json['current_plan'];
    totalUsed = json['total_used'];
    balance = json['balance'];
    remainingQouta = json['remaining_qouta'];
    onlineStatus = json['online_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['subscribtion_type'] = this.subscribtionType;
    data['credit'] = this.credit;
    data['expire_date'] = this.expireDate;
    data['created_by'] = this.createdBy;
    data['total_qouta'] = this.totalQouta;
    data['current_plan'] = this.currentPlan;
    data['total_used'] = this.totalUsed;
    data['balance'] = this.balance;
    data['remaining_qouta'] = this.remainingQouta;
    data['online_status'] = this.onlineStatus;
    return data;
  }
}
