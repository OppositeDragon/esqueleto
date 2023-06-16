import 'package:esqueleto/pages/albums_page.dart';
import 'package:esqueleto/pages/navigation_page.dart';
import 'package:esqueleto/pages/todos_page.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../pages/posts_page.dart';
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
		navigatorKey: _rootNavigatorKey,

    initialLocation: '/posts',
    routes: [
      ShellRoute(
				navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return NavigationPage(child: child);
        },
        routes: [
          GoRoute(path: '/posts', builder: (context, state) => const PostsPage(),
							),
          GoRoute(path: '/albums', builder: (context, state) => const AlbumsPage()),
          GoRoute(path: '/todos', builder: (context, state) => const TodosPage(),
					routes:[
						GoRoute(path: ':id',name:'todo', builder: (context, state) =>  TodoPage(id:int.parse( state.pathParameters['id']!)),
						),
					],
					),
        ],
      ),
    ],
  );
});
