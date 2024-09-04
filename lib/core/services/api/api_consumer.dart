abstract class ApiConsumer {
  Future<dynamic> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
  Future<dynamic> post(
    String path, {
    Map<String, dynamic>? queryParameters,
    required dynamic body,

    bool isFormData = false,
  });
  Future<dynamic> patch(
    String path, {
    Map<String, dynamic>? queryParameters,
    required dynamic body,
    bool isFormData = false,
  });
  Future<dynamic> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  });
}
