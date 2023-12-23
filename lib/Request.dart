// request_model.dart

class Request {
  final String status;
  final String message;

  Request({required this.status, required this.message});

  factory Request.fromJson(Map<dynamic, dynamic> json) {
    return Request(
      status: json['status'],
      message: json['message'],
    );
  }
}