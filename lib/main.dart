import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
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
          ChangeNotifierProvider(create: (_) => LoginViewModel())
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
        splashColor: Colors.transparent
      ),
      routerConfig: router,
    );
  }
}