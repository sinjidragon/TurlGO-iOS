import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:turlgo/feature/main/presentation/adoption/detail/detail_view_model.dart';
import 'package:turlgo/feature/main/presentation/home/home_view_model.dart';
import 'package:turlgo/feature/main/presentation/home/test/result/test_result_view_model.dart';
import 'feature/auth/presentation/login/login_view_model.dart';
import 'feature/auth/presentation/signup/signup_email_view_model.dart';
import 'feature/auth/presentation/signup/signup_view_model.dart';
import 'feature/shared/router/app_router.dart';

void main() async{
  await dotenv.load();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => SignupViewModel()),
          ChangeNotifierProvider(create: (_) => SignupEmailViewModel()),
          ChangeNotifierProvider(create: (_) => LoginViewModel()),
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => DetailViewModel()),
          ChangeNotifierProvider(create: (_) => TestResultViewModel())
        ],
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
      theme: ThemeData(
        splashColor: Colors.transparent,
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder()
          }
        ),
      ),
      routerConfig: router,
    );
  }
}