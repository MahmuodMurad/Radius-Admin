class UserGroupModel {
  String? groupId;
  String? groupName;
  String? groupTag;
  String? createdBy;
  String? attachedAgent;
  String? enable;
  String? createdOn;

  UserGroupModel(
      {this.groupId,
        this.groupName,
        this.groupTag,
        this.createdBy,
        this.attachedAgent,
        this.enable,
        this.createdOn});

  UserGroupModel.fromJson(Map<String, dynamic> json) {
    groupId = json['group_id'];
    groupName = json['group_name'];
    groupTag = json['group_tag'];
    createdBy = json['created_by'];
    attachedAgent = json['attached_agent'];
    enable = json['enable'];
    createdOn = json['created_on'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['group_id'] = this.groupId;
    data['group_name'] = this.groupName;
    data['group_tag'] = this.groupTag;
    data['created_by'] = this.createdBy;
    data['attached_agent'] = this.attachedAgent;
    data['enable'] = this.enable;
    data['created_on'] = this.createdOn;
    return data;
  }
}
