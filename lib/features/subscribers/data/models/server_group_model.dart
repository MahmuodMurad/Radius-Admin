class ServerGroupModel {
  String? id;
  String? nasId;
  String? nasName;
  String? location;
  String? nasRequestName;
  String? enableStatus;
  String? activeStatus;
  String? createdOn;
  String? maxRegClients;
  String? networkAdmin;
  String? primaryId;
  String? mikrotikVersion;
  String? note;

  ServerGroupModel(
      {this.id,
      this.nasId,
      this.nasName,
      this.location,
      this.nasRequestName,
      this.enableStatus,
      this.activeStatus,
      this.createdOn,
      this.maxRegClients,
      this.networkAdmin,
      this.primaryId,
      this.mikrotikVersion,
      this.note});

  ServerGroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nasId = json['nas_id'];
    nasName = json['nas_name'];
    location = json['location'];
    nasRequestName = json['nas_request_name'];
    enableStatus = json['enable_status'];
    activeStatus = json['active_status'];
    createdOn = json['created_on'];
    maxRegClients = json['max_reg_clients'];
    networkAdmin = json['network_admin'];
    primaryId = json['primary_id'];
    mikrotikVersion = json['mikrotik_version'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nas_id'] = nasId;
    data['nas_name'] = nasName;
    data['location'] = location;
    data['nas_request_name'] = nasRequestName;
    data['enable_status'] = enableStatus;
    data['active_status'] = activeStatus;
    data['created_on'] = createdOn;
    data['max_reg_clients'] = maxRegClients;
    data['network_admin'] = networkAdmin;
    data['primary_id'] = primaryId;
    data['mikrotik_version'] = mikrotikVersion;
    data['note'] = note;
    return data;
  }
}
