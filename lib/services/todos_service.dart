import 'dart:convert';

import 'package:esqueleto/services/user_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../constants/endpoints.dart';
import '../models/todo_model.dart';
import '../models/user_model.dart';

final todosServiceProvider = Provider<TodoService>((ref) {
  return TodoService();
});

final getTodosProvider = FutureProvider<List<TodoModel>>((ref) async {
  final postService = ref.watch(todosServiceProvider);
  return postService.getPosts();
});

final getTodoProvider = FutureProvider.family<TodoModel, int>((ref, id) async {
  final postService = ref.watch(todosServiceProvider);
  return postService.getPost(id);
});
typedef Params = ({ int idUser,int id});
final getTodoUserProvider = FutureProvider.family<(UserModel, TodoModel),int>((ref, id) async {
	final todo = await ref.watch(getTodoProvider(id).future);
	final user = await ref.watch(getUserProvider(todo.userId).future);
	return (user, todo);
});

class TodoService {
  Future<List<TodoModel>> getPosts() async {
    final url = Uri.https(baseUrl, todosEndpoint);
    final response = await http.get(url);
    final posts = jsonDecode(response.body);
    List<TodoModel> postsList = [];
    for (final post in posts) {
      postsList.add(TodoModel.fromMap(post));
    }
    return postsList;
  }

  Future<TodoModel> getPost(int id) async {
    final url = Uri.https(baseUrl, '$todosEndpoint/$id');
    final response = await http.get(url);
    final post = TodoModel.fromJson(response.body);

    return post;
  }
}
