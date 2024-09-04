class UsersStatusModel {
  String? fullName;
  String? srvtype;
  String? srvMikrotikSpeed;
  String? expireDate;
  String? activeRecharge;
  String? chargedTime;
  String? overQouta;
  String? lastSeen;
  String? qoutaUsed;

  UsersStatusModel(
      {this.fullName,
      this.srvtype,
      this.srvMikrotikSpeed,
      this.expireDate,
      this.activeRecharge,
      this.chargedTime,
      this.overQouta,
      this.lastSeen,
      this.qoutaUsed});

  UsersStatusModel.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    srvtype = json['srvtype'];
    srvMikrotikSpeed = json['srv_mikrotik_speed'];
    expireDate = json['expire_date'];
    activeRecharge = json['active_recharge'];
    chargedTime = json['charged_time'];
    overQouta = json['over_qouta'];
    lastSeen = json['last_seen'];
    qoutaUsed = json['qouta_used'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['full_name'] = fullName;
    data['srvtype'] = srvtype;
    data['srv_mikrotik_speed'] = srvMikrotikSpeed;
    data['expire_date'] = expireDate;
    data['active_recharge'] = activeRecharge;
    data['charged_time'] = chargedTime;
    data['over_qouta'] = overQouta;
    data['last_seen'] = lastSeen;
    data['qouta_used'] = qoutaUsed;
    return data;
  }
}
