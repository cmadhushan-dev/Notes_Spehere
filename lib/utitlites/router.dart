import 'package:dp_notes_spehere_08/pages/home_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final routers = GoRouter(
    navigatorKey: GlobalKey<NavigatorState>(),
    debugLogDiagnostics: true,
    initialLocation: '/homePage',
    routes: [
      GoRoute(
        name: '/homePage',
        path: '/homePage',
        builder: (context, state) {
          return const HomePage();
        },
      ),
    ],
  );
}
