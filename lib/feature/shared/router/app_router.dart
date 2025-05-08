import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:turlgo/feature/auth/presentation/login/login_view.dart';
import 'package:turlgo/feature/auth/presentation/signup/signup_emali_view.dart';
import 'package:turlgo/feature/auth/presentation/signup/signup_view.dart';
import '../../auth/presentation/first/first_view.dart';
import '../../main/presentation/adoption/adoption_view.dart';
import '../../main/presentation/adoption/detail/detail_view.dart';
import '../../main/presentation/education/education_view.dart';
import '../../main/presentation/education/video/video_view.dart';
import '../../main/presentation/home/home_view.dart';
import '../../main/presentation/my/my_view.dart';
import '../../model/video.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
    navigatorKey: _rootNavigatorKey,
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
      GoRoute(path: "/login",builder: (context, state) => LoginView()),
      ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (context, state, child) {
            return MainScaffold(child: child);
          },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeView(),
          ),
          GoRoute(
            path: '/adoption',
            builder: (context, state) => const AdoptionView(),
          ),
          GoRoute(
            path: '/education',
            builder: (context, state) => const EducationView(),
          ),
          GoRoute(
            path: '/my',
            builder: (context, state) => const MyView(),
          ),
        ]
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/video',
        builder: (context, state) {
          final video = state.extra as Video;
          return VideoView(video: video);
        },
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/detail',
        builder: (context, state) {
          final animalNo = state.extra as String;
          return DetailView(animalNo: animalNo);
        },
      )
    ]
);


class MainScaffold extends StatelessWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    if (location.startsWith('/adoption')) return 1;
    if (location.startsWith('/education')) return 2;
    if (location.startsWith('/my')) return 3;
    return 0;
  }

  void _onItemTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/adoption');
        break;
      case 2:
        context.go('/education');
        break;
      case 3:
        context.go('/my');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _getSelectedIndex(context);

    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        selectedItemColor: Color(0xFFEF798A),
        unselectedItemColor: Color(0xFF9CA3AF),
        onTap: (index) => _onItemTap(context, index),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/home.svg',
              color: selectedIndex == 0 ? Color(0xFFEF798A) : Color(0xFF9CA3AF),
            ),
            label: '홈',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/adoption.svg',
              color: selectedIndex == 1 ? Color(0xFFEF798A) : Color(0xFF9CA3AF),
            ),
            label: '입양',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/education.svg',
              color: selectedIndex == 2 ? Color(0xFFEF798A) : Color(0xFF9CA3AF),
            ),
            label: '교육',
            backgroundColor: Colors.white
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
                'assets/icons/my.svg',
              color: selectedIndex == 3 ? Color(0xFFEF798A) : Color(0xFF9CA3AF),
            ),
            label: '마이',
            backgroundColor: Colors.white
          ),
        ],
      ),
    );
  }
}