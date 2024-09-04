class ErrorModel {
  final String error;

  ErrorModel({required this.error});

  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    return ErrorModel(
      error: json['error'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
    };
  }
}
