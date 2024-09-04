class NetworkUsaingModel {
  String? networkName;
  String? hotspotSum;
  String? probandSum;
  String? monthSum;
  String? dailySum;
  String? allSum;

  NetworkUsaingModel(
      {this.networkName,
      this.hotspotSum,
      this.probandSum,
      this.monthSum,
      this.dailySum,
      this.allSum});

  NetworkUsaingModel.fromJson(Map<String, dynamic> json) {
    networkName = json['network_name'];
    hotspotSum = json['hotspot_sum'];
    probandSum = json['proband_sum'];
    monthSum = json['month_sum'];
    dailySum = json['daily_sum'];
    allSum = json['all_sum'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['network_name'] = networkName;
    data['hotspot_sum'] = hotspotSum;
    data['proband_sum'] = probandSum;
    data['month_sum'] = monthSum;
    data['daily_sum'] = dailySum;
    data['all_sum'] = allSum;
    return data;
  }
}
