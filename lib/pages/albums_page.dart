import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/albums_service.dart';

class AlbumsPage extends ConsumerWidget {
	const AlbumsPage({super.key});

	@override
	Widget build(BuildContext context, WidgetRef ref) {
		final albums = ref.watch(getAlbumsProvider);
    return albums.when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
									leading: CircleAvatar(child: FittedBox(child: Text(data[index].id.toString()),),),
                  title: Text(data[index].title),
                 
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