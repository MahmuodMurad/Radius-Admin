class VouchersDetails {
  String? id;
  String? cardNum;
  String? cardValue;
  String? cardStatus;
  String? activeTime;
  String? chargedUser;
  String? createdBy;
  String? enableStatus;
  String? chargedBrief;
  String? createOnDate;
  String? vouchersSeries;
  String? expireDate;
  String? sendBySms;
  String? sendToMobile;
  String? attachedAgent;
  String? note;

  VouchersDetails(
      {this.id,
        this.cardNum,
        this.cardValue,
        this.cardStatus,
        this.activeTime,
        this.chargedUser,
        this.createdBy,
        this.enableStatus,
        this.chargedBrief,
        this.createOnDate,
        this.vouchersSeries,
        this.expireDate,
        this.sendBySms,
        this.sendToMobile,
        this.attachedAgent,
        this.note});

  VouchersDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cardNum = json['card_num'];
    cardValue = json['card_value'];
    cardStatus = json['card_status'];
    activeTime = json['active_time'];
    chargedUser = json['charged_user'];
    createdBy = json['created_by'];
    enableStatus = json['enable_status'];
    chargedBrief = json['charged_brief'];
    createOnDate = json['create_on_date'];
    vouchersSeries = json['vouchers_series'];
    expireDate = json['expire_date'];
    sendBySms = json['send_by_sms'];
    sendToMobile = json['send_to_mobile'];
    attachedAgent = json['attached_agent'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['card_num'] = cardNum;
    data['card_value'] = cardValue;
    data['card_status'] = cardStatus;
    data['active_time'] = activeTime;
    data['charged_user'] = chargedUser;
    data['created_by'] = createdBy;
    data['enable_status'] = enableStatus;
    data['charged_brief'] = chargedBrief;
    data['create_on_date'] = createOnDate;
    data['vouchers_series'] = vouchersSeries;
    data['expire_date'] = expireDate;
    data['send_by_sms'] = sendBySms;
    data['send_to_mobile'] = sendToMobile;
    data['attached_agent'] = attachedAgent;
    data['note'] = note;
    return data;
  }
}
