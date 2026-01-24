import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {

  Future<http.Response> postRequest(String url, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );
    return response;
  }

  Future<http.Response> getRequest(String url) async {  
    final response = await http.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    return response;
  }
  
}