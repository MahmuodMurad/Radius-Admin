class SeriesVouchersModel {
  String? vouchersSeries;
  String? voucherCount;
  String? cardValue;
  String? totalUsed;
  String? createOnDate;
  String? expireDate;
  String? enableStatus;

  SeriesVouchersModel(
      {this.vouchersSeries,
      this.voucherCount,
      this.cardValue,
      this.totalUsed,
      this.createOnDate,
      this.expireDate,
      this.enableStatus});

  SeriesVouchersModel.fromJson(Map<String, dynamic> json) {
    vouchersSeries = json['vouchers_series'];
    voucherCount = json['Voucher_count'];
    cardValue = json['card_value'];
    totalUsed = json['total_used'];
    createOnDate = json['create_on_date'];
    expireDate = json['expire_date'];
    enableStatus = json['enable_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['vouchers_series'] = vouchersSeries;
    data['Voucher_count'] = voucherCount;
    data['card_value'] = cardValue;
    data['total_used'] = totalUsed;
    data['create_on_date'] = createOnDate;
    data['expire_date'] = expireDate;
    data['enable_status'] = enableStatus;
    return data;
  }
}
