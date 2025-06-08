import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ninetigmbh_task/data/models/post_model.dart';
import 'package:ninetigmbh_task/data/models/todo_model.dart';
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

  Future<List<Post>> fetchUserPosts(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/user/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['posts'] as List).map((e) => Post.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<Todo>> fetchUserTodos(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/todos/user/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return (data['todos'] as List).map((e) => Todo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }
}
