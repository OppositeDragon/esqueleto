import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NavigationPage extends ConsumerWidget {
  const NavigationPage({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation'),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_comment),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_inbox),
            label: 'Albums',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Todos',
          ),
        ],
				currentIndex: _calculateSelectedIndex(context),
        onTap: (int index) => _onItemTapped(index, context),
      ),
    );
  }
static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith('/posts')) {
      return 0;
    }
    if (location.startsWith('/albums')) {
      return 1;
    }
    if (location.startsWith('/todos')) {
      return 2;
    }
    return 0;
  }
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/posts');
        break;
      case 1:
        context.go('/albums');
        break;
      case 2:
        context.go('/todos');
        break;
    }
  }
}
