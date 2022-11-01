import 'package:go_router/go_router.dart';
import 'package:revver/view/accoount/account.dart';
import 'package:revver/view/auth/registration.dart';
import 'package:revver/view/event/event.dart';
import 'package:revver/view/home/home.dart';
import 'package:revver/view/homepage.dart';
import 'package:revver/view/leads/leads.dart';
import 'package:revver/view/auth/login.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Login(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => const Registration(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => const Homepage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: '/event',
      builder: (context, state) => const Event(),
    ),
    GoRoute(
      path: '/leads',
      builder: (context, state) => const Leads(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => const Account(),
    ),
  ],
);
