import 'package:go_router/go_router.dart';
import 'package:turlgo/feature/auth/presentation/login/login_view.dart';
import 'package:turlgo/feature/auth/presentation/signup/signup_emali_view.dart';
import 'package:turlgo/feature/auth/presentation/signup/signup_view.dart';
import '../../auth/presentation/first/first_view.dart';

final router = GoRouter(
  initialLocation: '/first',
    routes: [
      GoRoute(path: "/first",builder: (context, state) => FirstView()),
      GoRoute(path: "/signup",builder: (context, state) => SignupView()),
      GoRoute(
          path: "/signup_email",
          builder: (context, state) {
            final extra = state.extra as Map<String, String>?;

            return SignupEmailView(
              id: extra!['id']!,
              password: extra['password']!,
            );
          },
      ),
      GoRoute(path: "/login",builder: (context, state) => LoginView())
    ]
);