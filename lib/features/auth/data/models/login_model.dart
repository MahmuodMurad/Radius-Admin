class LoginModel {
  final String success;
  final String  sessionId;


  LoginModel({
    required this.success,
    required this.sessionId,
  });


  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      success: json['success'],
      sessionId: json['session_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'session_id': sessionId,
    };
  }
}
