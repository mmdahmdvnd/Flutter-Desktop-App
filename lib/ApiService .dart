// api_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:riverpod/riverpod.dart';
import 'Request.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService(baseUrl: 'https://android-material.ir/test/login_.php');
});

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<List<Request>> getRequests() async {
    final response = await http.get(Uri.parse('$baseUrl/requests'));

    if (response.statusCode == 200) {
      try {
        dynamic data = json.decode(response.body);
        List<Request> requestList = [];

        if (data is Iterable) {
          // اگر داده‌ها از نوع Iterable هستند
          requestList = data.map((item) => Request.fromJson(item)).toList();
        } else if (data is Map<dynamic, dynamic>) {
          // اگر داده‌ها از نوع Map هستند
          var request = Request.fromJson(data);
          requestList.add(request);
        }

        return requestList;
      } catch (e) {
        throw Exception('Error parsing response data: $e');
      }
    } else {
      throw Exception('Failed to load requests: ${response.statusCode}');
    }
  }
}