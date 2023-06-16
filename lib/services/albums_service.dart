import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../constants/endpoints.dart';
import '../models/albums_model.dart';

final albumsServiceProvider = Provider<PostService>((ref) {
  return PostService();
});

final getAlbumsProvider = FutureProvider<List<AlbumModel>>((ref) async {
  final postService = ref.watch(albumsServiceProvider);
  return postService.getPosts();
});

class PostService {
  Future<List<AlbumModel>> getPosts() async {
    final url = Uri.https(baseUrl, postsEndpoint);
    final response = await http.get(url);
    final posts = jsonDecode(response.body);
    List<AlbumModel> postsList = [];
    for (final post in posts) {
      postsList.add(AlbumModel.fromMap(post));
    }
    return postsList;
  }
}
