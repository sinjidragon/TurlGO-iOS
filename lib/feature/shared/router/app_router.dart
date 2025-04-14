import 'package:go_router/go_router.dart';
import 'package:turlgo/feature/auth/presentation/signup/signup_view.dart';
import '../../auth/presentation/first/first_view.dart';

final router = GoRouter(
  initialLocation: '/first',
    routes: [
      GoRoute(path: "/first",builder: (context, state) => FirstView()),
      GoRoute(path: "/signup",builder: (context, state) => SignupView())
    ]
);