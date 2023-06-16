import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../constants/endpoints.dart';
import '../models/user_model.dart';

final usersServiceProvider = Provider<UserService>((ref) {
  return UserService();
});

final getUsersProvider = FutureProvider<List<UserModel>>((ref) async {
  final postService = ref.watch(usersServiceProvider);
  return postService.getPosts();
});

final getUserProvider = FutureProvider.family<UserModel, int>((ref, id) async {
  final postService = ref.watch(usersServiceProvider);
  return postService.getPost(id);
});

class UserService {
  Future<List<UserModel>> getPosts() async {
    final url = Uri.https(baseUrl, usersEndpoint);
    final response = await http.get(url);
    final posts = jsonDecode(response.body);
    List<UserModel> usersList = [];
    for (final post in posts) {
      usersList.add(UserModel.fromMap(post));
    }
    return usersList;
  }

  Future<UserModel> getPost(int id) async {
    final url = Uri.https(baseUrl, '$usersEndpoint/$id');
    final response = await http.get(url);
    final user = UserModel.fromJson(response.body);

    return user;
  }
}
