import 'package:esqueleto/services/posts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final posts = ref.watch(getPostsProvider);
    return posts.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].title),
                  subtitle: Text(data[index].body),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text('error: $error'),
            );
          },
          loading: () {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        );
  }
}
