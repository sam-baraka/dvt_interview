import 'package:dvt_interview/pages/favorites_page.dart';
import 'package:dvt_interview/pages/main_home_page.dart';
import 'package:dvt_interview/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The route configuration.
final GoRouter appRouter = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: '/',
    builder: (BuildContext context, GoRouterState state) {
      return const SplashPage();
    },
    routes: <RouteBase>[
      GoRoute(
        path: 'main-home-page',
        builder: (BuildContext context, GoRouterState state) {
          return const MainHomePage();
        },
      ),
      GoRoute(
        path: 'favorites',
        builder: (BuildContext context, GoRouterState state) {
          return const FavoritesPage();
        },
      ),


    ],
  ),
]);
