// ignore_for_file: non_constant_identifier_names

import 'package:go_router/go_router.dart';
import 'package:revver/view/EHealth/EHealthDetail.dart';
import 'package:revver/view/EHealth/EHealthForm.dart';
import 'package:revver/view/EHealth/EHealthList.dart';
import 'package:revver/view/ELearning/ELearning.dart';
import 'package:revver/view/ELearning/ELearningDetail.dart';
import 'package:revver/view/accoount/aboutApps.dart';
import 'package:revver/view/accoount/account.dart';
import 'package:revver/view/accoount/changePassword.dart';
import 'package:revver/view/accoount/orderHistory.dart';
import 'package:revver/view/accoount/privacyPolicy.dart';
import 'package:revver/view/accoount/profile.dart';
import 'package:revver/view/accoount/refundPolicy.dart';
import 'package:revver/view/auth/registration.dart';
import 'package:revver/view/companyProfile/companyProfile.dart';
import 'package:revver/view/event/event.dart';
import 'package:revver/view/event/globalEvent.dart';
import 'package:revver/view/event/personalEvent.dart';
import 'package:revver/view/home/home.dart';
import 'package:revver/view/homepage.dart';
import 'package:revver/view/leads/leadDetailMeetingForm.dart';
import 'package:revver/view/leads/leads.dart';
import 'package:revver/view/auth/login.dart';
import 'package:revver/view/leads/leadsDetail.dart';
import 'package:revver/view/leads/leadsDetailForm.dart';
import 'package:revver/view/news/news.dart';
import 'package:revver/view/news/newsDetail.dart';
import 'package:revver/view/note/note.dart';
import 'package:revver/view/note/noteDetail.dart';
import 'package:revver/view/notifications/notifications.dart';
import 'package:revver/view/order/cart.dart';
import 'package:revver/view/order/invoice.dart';
import 'package:revver/view/plan/plan.dart';
import 'package:revver/view/product/product.dart';
import 'package:revver/view/product/productDetail.dart';
import 'package:revver/view/report/report.dart';
import 'package:revver/view/splash.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Splash(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => Login(),
    ),
    GoRoute(
      path: '/registration',
      builder: (context, state) => Registration(),
    ),
    GoRoute(
      path: '/homepage/:index',
      builder: (context, state) {
        int id = int.parse(state.params['index']);
        return Homepage(index: id);
      },
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
      path: '/leads-detail/:id',
      builder: (context, state) {
        int id = int.parse(state.params['id']);
        return LeadsDetail(id: id);
      },
    ),
    GoRoute(
      path: '/leads-detail-form',
      builder: (context, state) => LeadsDetailForm(),
    ),
    GoRoute(
      path: '/leads-detail-meeting-form/:id/:lead_id',
      builder: (context, state) {
        int id = int.parse(state.params['id']);
        int lead_id = int.parse(state.params['lead_id']);
        return LeadsDetailMeetingForm(id: id, lead_id: lead_id);
      },
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
      path: '/news-detail/:id',
      builder: (context, state) {
        int id = int.parse(state.params['id']);
        return NewsDetail(id: id);
      },
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) => Product(),
    ),
    GoRoute(
      path: '/product-detail/:id',
      builder: (context, state) {
        int id = int.parse(state.params['id']);
        return ProductDetail(id: id);
      },
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => Profile(),
    ),
    GoRoute(
      path: '/change-password',
      builder: (context, state) => ChangePassword(),
    ),
    GoRoute(
      path: '/order-history',
      builder: (context, state) => OrderHistory(),
    ),
    GoRoute(
      path: '/privacy-policy',
      builder: (context, state) => PrivacyPolicy(),
    ),
    GoRoute(
      path: '/refund-policy',
      builder: (context, state) => RefundPolicy(),
    ),
    GoRoute(
      path: '/about-apps',
      builder: (context, state) => AboutApps(),
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => Cart(),
    ),
    GoRoute(
      path: '/invoice/:id/:isHistory',
      builder: (context, state) {
        int id = int.parse(state.params['id']);
        bool isHistory = state.params['isHistory'] == 'true';
        return Invoice(id: id, isHistory: isHistory);
      },
    ),
    GoRoute(
      path: '/notification',
      builder: (context, state) => Notifications(),
    ),
    GoRoute(
      path: '/e-learning',
      builder: (context, state) => ELearning(),
    ),
    GoRoute(
      path: '/e-learning-detail/:id',
      builder: (context, state) {
        int id = int.parse(state.params['id']);
        return ELearningDetail(id: id);
      },
    ),
    GoRoute(
      path: '/plan',
      builder: (context, state) => Plan(),
    ),
    GoRoute(
      path: '/report',
      builder: (context, state) => Report(),
    ),
    GoRoute(
      path: '/company-profile',
      builder: (context, state) => CompanyProfile(),
    ),
    GoRoute(
      path: '/note',
      builder: (context, state) => Note(),
    ),
    GoRoute(
      path: '/note-detail/:id',
      builder: (context, state) {
        String id = state.params['id'];
        return NoteDetail(id: id);
      },
    ),
    GoRoute(
      path: '/e-health-form',
      builder: (context, state) => EHealthForm(),
    ),
    GoRoute(
      path: '/e-health-list/:name/:height/:weight/:ages',
      builder: (context, state) {
        String name = state.params['name'];
        String height = state.params['height'];
        String weight = state.params['weight'];
        String age = state.params['age'];
        return EHealthList(
            name: name, height: height, weight: weight, age: age);
      },
    ),
    GoRoute(
      path: '/e-health-detail',
      builder: (context, state) {
        String name = state.params['name'];
        String height = state.params['height'];
        String weight = state.params['weight'];
        String age = state.params['age'];
        return EHealthDetail(
            name: name, height: height, weight: weight, age: age);
      },
    ),
  ],
);
