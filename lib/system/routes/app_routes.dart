import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_flutter/app/screens/main/favorites/favorites_page.dart';
import 'package:test_flutter/app/screens/main/deletes/deletes_page.dart';
import 'package:test_flutter/app/screens/cat/cat_page.dart';
import 'package:test_flutter/app/screens/main/generator/generator_page.dart';
import 'package:test_flutter/app/screens/main/main_page.dart';
import 'package:test_flutter/app/screens/utility/not_found_page.dart';
import 'package:test_flutter/data/bloc/favorite/favorite_bloc.dart';

import '../../data/cubit/navigation/navigation_cubit.dart';
import '../constants/constants.dart';

class AppRouter {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static final GoRouter _router = GoRouter(
    initialLocation: Routes.generatorNamedPage,
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return BlocProvider(
            create: (context) => NavigationCubit(),
            child: MainPage(screen: child),
          );
        },
        routes: [
          GoRoute(
            path: Routes.generatorNamedPage,
            pageBuilder: (context, state) => NoTransitionPage(
                child: BlocProvider(
                    create: (context) => FavoriteBloc(),
                    child: GeneratorPage())),
          ),
          GoRoute(
            path: Routes.favoritesNamedPage,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                  create: (context) => FavoriteBloc(), child: FavoritesPage()),
            ),
          ),
          GoRoute(
            path: Routes.deletesNamedPage,
            pageBuilder: (context, state) => NoTransitionPage(
              child: BlocProvider(
                  create: (context) => FavoriteBloc(), child: DeletesPage()),
            ),
          ),
        ],
      ),
      GoRoute(
        path: Routes.catNamedPage,
        pageBuilder: (context, state) => NoTransitionPage(
          child: CatPage(),
        ),
      ),
    ],
    errorBuilder: (context, state) => const NotFoundPage(),
  );

  static GoRouter get router => _router;
}
