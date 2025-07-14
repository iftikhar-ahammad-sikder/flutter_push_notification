import 'package:go_router/go_router.dart';
import 'package:push_notification/screens/recommendation_screen.dart';

import '../screens/home_screen.dart';

enum screens { home, recommendation }

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
        name: screens.home.name,
        path: "/home",
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        name: screens.recommendation.name,
        path: "/recommendation",
        builder: (context, state) => RecommendationScreen(),
      ),
    ],
  );
}
