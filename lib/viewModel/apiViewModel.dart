import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../model/Request.dart';

class ApiViewModel extends ChangeNotifier {
  final String baseUrl;

  ApiViewModel({required this.baseUrl});

  Future<List<Request>> getRequests() async {
    final response = await http.get(Uri.parse('$baseUrl/requests'));

    if (response.statusCode == 200) {
      try {
        dynamic data = json.decode(response.body);
        List<Request> requestList = [];

        if (data is Iterable) {
          requestList = data.map((item) => Request.fromJson(item)).toList();
        } else if (data is Map<dynamic, dynamic>) {
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