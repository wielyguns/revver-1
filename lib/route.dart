import 'package:go_router/go_router.dart';
import 'package:revver/view/accoount/account.dart';
import 'package:revver/view/auth/registration.dart';
import 'package:revver/view/event/event.dart';
import 'package:revver/view/event/globalEvent.dart';
import 'package:revver/view/event/personalEvent.dart';
import 'package:revver/view/home/home.dart';
import 'package:revver/view/homepage.dart';
import 'package:revver/view/leads/leads.dart';
import 'package:revver/view/auth/login.dart';
import 'package:revver/view/news/news.dart';
import 'package:revver/view/news/newsDetail.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => Registration(),
    ),
    GoRoute(
      path: '/homepage',
      builder: (context, state) => Homepage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => Home(),
    ),
    GoRoute(
      path: '/event',
      builder: (context, state) => Event(),
    ),
    GoRoute(
      path: '/global-event/:id',
      builder: (context, state) {
        int id = int.parse(state.params['id']);
        return GlobalEvent(id: id);
      },
    ),
    GoRoute(
        path: '/personal-event/:id',
        builder: (context, state) {
          int id = int.parse(state.params['id']);
          return PersonalEvent(id: id);
        }),
    GoRoute(
      path: '/leads',
      builder: (context, state) => Leads(),
    ),
    GoRoute(
      path: '/account',
      builder: (context, state) => Account(),
    ),
    GoRoute(
      path: '/news',
      builder: (context, state) => News(),
    ),
    GoRoute(
      path: '/news-detail',
      builder: (context, state) => NewsDetail(),
    ),
  ],
);
