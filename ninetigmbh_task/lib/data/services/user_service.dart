import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

class UserService {
  final baseUrl = 'https://dummyjson.com';

  Future<List<User>> fetchUsers({int limit = 20, int skip = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users?limit=$limit&skip=$skip'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['users'] as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<List<User>> searchUsers(String query) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/search?q=$query'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['users'] as List).map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Search failed');
    }
  }
}
