import 'dart:convert';

import 'package:esqueleto/models/post_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../constants/endpoints.dart';

final postServiceProvider = Provider<PostService>((ref) {
  return PostService();
});

final getPostsProvider = FutureProvider<List<PostModel>>((ref) async {
  final postService = ref.watch(postServiceProvider);
  return postService.getPosts();
});

class PostService {
  Future<List<PostModel>> getPosts() async {
    final url = Uri.https(baseUrl, postsEndpoint);
    final response = await http.get(url);
    final posts = jsonDecode(response.body);
    List<PostModel> postsList = [];
    for (final post in posts) {
      postsList.add(PostModel.fromMap(post));
    }
    return postsList;
  }
}
