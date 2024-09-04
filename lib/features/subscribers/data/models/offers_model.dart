class OffersModel {
  String? id;
  String? srvName;
  String? nasId;
  String? srvTime;
  String? timeIndex;
  String? srvDownload;
  String? srvUpload;
  String? userSrvDownload;
  String? userSrvUpload;
  String? gbUnitPrice;
  String? totalQouta;
  String? dailyQouta;
  String? srvPrice;
  String? srvPriceAgents;
  String? agentAllow;
  String? srvNameAgents;
  String? srvMikrotikSpeed;
  String? enableStatus;
  String? networkAdmin;
  String? createdOn;
  String? txReferanceValue;
  String? txIndexDayBased;
  String? gbRealValue;
  String? downloadUnqSpeed;
  String? uploadUnqSpeed;
  Null ipPool;
  Null note;

  OffersModel(
      {this.id,
      this.srvName,
      this.nasId,
      this.srvTime,
      this.timeIndex,
      this.srvDownload,
      this.srvUpload,
      this.userSrvDownload,
      this.userSrvUpload,
      this.gbUnitPrice,
      this.totalQouta,
      this.dailyQouta,
      this.srvPrice,
      this.srvPriceAgents,
      this.agentAllow,
      this.srvNameAgents,
      this.srvMikrotikSpeed,
      this.enableStatus,
      this.networkAdmin,
      this.createdOn,
      this.txReferanceValue,
      this.txIndexDayBased,
      this.gbRealValue,
      this.downloadUnqSpeed,
      this.uploadUnqSpeed,
      this.ipPool,
      this.note});

  OffersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    srvName = json['srv_name'];
    nasId = json['nas_id'];
    srvTime = json['srv_time'];
    timeIndex = json['time_index'];
    srvDownload = json['srv_download'];
    srvUpload = json['srv_upload'];
    userSrvDownload = json['user_srv_download'];
    userSrvUpload = json['user_srv_upload'];
    gbUnitPrice = json['gb_unit_price'];
    totalQouta = json['total_qouta'];
    dailyQouta = json['daily_qouta'];
    srvPrice = json['srv_price'];
    srvPriceAgents = json['srv_price_agents'];
    agentAllow = json['agent_allow'];
    srvNameAgents = json['srv_name_agents'];
    srvMikrotikSpeed = json['srv_mikrotik_speed'];
    enableStatus = json['enable_status'];
    networkAdmin = json['network_admin'];
    createdOn = json['created_on'];
    txReferanceValue = json['tx_referance_value'];
    txIndexDayBased = json['tx_index_day_based'];
    gbRealValue = json['gb_real_value'];
    downloadUnqSpeed = json['download_unq_speed'];
    uploadUnqSpeed = json['upload_unq_speed'];
    ipPool = json['ip_pool'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['srv_name'] = srvName;
    data['nas_id'] = nasId;
    data['srv_time'] = srvTime;
    data['time_index'] = timeIndex;
    data['srv_download'] = srvDownload;
    data['srv_upload'] = srvUpload;
    data['user_srv_download'] = userSrvDownload;
    data['user_srv_upload'] = userSrvUpload;
    data['gb_unit_price'] = gbUnitPrice;
    data['total_qouta'] = totalQouta;
    data['daily_qouta'] = dailyQouta;
    data['srv_price'] = srvPrice;
    data['srv_price_agents'] = srvPriceAgents;
    data['agent_allow'] = agentAllow;
    data['srv_name_agents'] = srvNameAgents;
    data['srv_mikrotik_speed'] = srvMikrotikSpeed;
    data['enable_status'] = enableStatus;
    data['network_admin'] = networkAdmin;
    data['created_on'] = createdOn;
    data['tx_referance_value'] = txReferanceValue;
    data['tx_index_day_based'] = txIndexDayBased;
    data['gb_real_value'] = gbRealValue;
    data['download_unq_speed'] = downloadUnqSpeed;
    data['upload_unq_speed'] = uploadUnqSpeed;
    data['ip_pool'] = ipPool;
    data['note'] = note;
    return data;
  }
}
