import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/screens/utility/not_found_page.dart';

class Routes {
  static const root = '/';
  static const generatorNamedPage = '/generator';
  static const favoritesNamedPage = '/favorites';
  static const deletesNamedPage = '/deletes';
  static const catNamedPage = '/cat';
  //static profileNamedPage([String? name]) => '/${name ?? ':profile'}';
  static Widget errorWidget(BuildContext context, GoRouterState state) =>
      const NotFoundPage();
}
