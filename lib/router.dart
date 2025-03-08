import 'package:go_router/go_router.dart';
import 'package:template/main.dart';
import 'package:template/src/views/bottom_nav_view.dart';
import 'package:template/src/views/feed_view.dart';
import 'package:template/src/views/notifications_view.dart';
import 'package:template/src/views/post_view.dart';
import 'package:template/src/views/profile_view.dart';
import 'package:template/src/views/search_view.dart';
import 'package:template/src/views/splash_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const SplashView(),
      ),
      redirect: (context, state) => '/feed',
    ),
    GoRoute(
      path: '/feed',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const BottomNavView(
          currentIndex: 0,
          child: FeedView(),
        ),
      ),
    ),
    GoRoute(
      path: '/search',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const BottomNavView(
          currentIndex: 1,
          child: SearchView(),
        ),
      ),
    ),
    GoRoute(
      path: '/post',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const BottomNavView(
          currentIndex: 2,
          child: PostView(),
        ),
      ),
    ),
    GoRoute(
      path: '/notifications',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const BottomNavView(
          currentIndex: 3,
          child: NotificationsView(),
        ),
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) => NoTransitionPage(
        child: const BottomNavView(
          currentIndex: 4,
          child: ProfileView(),
        ),
      ),
    ),
  ],
);