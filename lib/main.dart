import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/providers/app_state_provider.dart';
import 'system/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => AppStateProvider(),
        child: MaterialApp.router(
          routeInformationProvider:
              AppRouter.router.routeInformationProvider, //context.go???
          routeInformationParser: AppRouter
              .router.routeInformationParser, //parser dengan widgetnya??
          routerDelegate: AppRouter.router.routerDelegate, //
          title: 'Go Router',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
        ));
  }
}
