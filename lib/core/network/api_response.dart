class ApiResponse<T> {
  final bool success;
  final String message;
  final T data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  static T readData<T>(Map<String, dynamic> json) {
    if (json.containsKey('data')) {
      return json['data'] as T;
    }
    return json as T;
  }
}
