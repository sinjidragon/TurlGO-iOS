import 'package:go_router/go_router.dart';
import 'package:turlgo/feature/auth/first/first_view.dart';

final router = GoRouter(
  initialLocation: '/first',
    routes: [
        GoRoute(path: "/first",builder: (context, state) => FirstView())
    ]
);