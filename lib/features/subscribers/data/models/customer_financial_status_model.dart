class CustomerFinancialStatusModel {
  String? fullName;
  String? expireDate;
  String? activeRecharge;
  String? chargedTime;
  int? creditStatus;
  String? userCredit;
  String? userBalance;

  CustomerFinancialStatusModel({
    this.fullName,
    this.expireDate,
    this.activeRecharge,
    this.chargedTime,
    this.creditStatus,
    this.userCredit,
    this.userBalance,
  });

  CustomerFinancialStatusModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    expireDate = json['expire_date'];
    activeRecharge = json['active_recharge'];
    chargedTime = json['charged_time'];
    creditStatus = json['credit_status'] is int
        ? json['credit_status']
        : int.tryParse(json['credit_status'] ?? '');
    userCredit = json['user_credit'];
    userBalance = json['user_balance'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['expire_date'] = expireDate;
    data['active_recharge'] = activeRecharge;
    data['charged_time'] = chargedTime;
    data['credit_status'] = creditStatus;
    data['user_credit'] = userCredit;
    data['user_balance'] = userBalance;
    return data;
  }
}
