class ErrorResponse {
  final String message;

  const ErrorResponse({required this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> jsonData) {
    return ErrorResponse(message: jsonData['message']);
  }
}
