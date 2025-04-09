import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'feature/shared/router/app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(),
      routerConfig: router,
    );
  }
}