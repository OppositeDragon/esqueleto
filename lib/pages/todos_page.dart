import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../services/todos_service.dart';

class TodosPage extends ConsumerWidget {
  const TodosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(getTodosProvider);
    return todos.when(
      data: (data) {
        return RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(getTodosProvider);
          },
          child: ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return ListTile(
								onTap: () => context.goNamed('todo', pathParameters: {'id':data[index].id.toString()}),
                title: Text(data[index].title),
                trailing:
                    data[index].completed ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
              );
            },
          ),
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

class TodoPage extends ConsumerWidget {
  const TodoPage({required this.id, super.key});
  final int id;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todo = ref.watch(getTodoUserProvider(id));
    return todo.when(
      data: (data) {
        return Card(
					child: ListTile(
						title: Text('Created by: ${data.$1.name}'),
						trailing: data.$2.completed ? const Icon(Icons.check_box) : const Icon(Icons.check_box_outline_blank),
					),
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
