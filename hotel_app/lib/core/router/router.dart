import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hotel_app/core/router/router.gr.dart';
import 'package:hotel_app/feature/home/page/home_screen.dart';
import 'package:hotel_app/feature/login/page/login_screen.dart';
import 'package:hotel_app/feature/login/page/phone_screen.dart';
import 'package:hotel_app/feature/profile/page/profile_screen.dart';
import 'package:hotel_app/feature/search_futures/pages/search_screen.dart';
import 'package:hotel_app/feature/setting/page/settings_screen.dart';

import '../../feature/Navigation/navigation.dart';
import '../../feature/home/page/hotel_detail_screen.dart';
import '../../feature/login/controller/firebase_auth_methods.dart';
import '../../feature/login/page/signup_email_password_screen.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Screen,Route',
  routes: [
    MaterialRoute(
      initial: true,
      path: '/',
      name: 'navigationRoute',
      page: NavigationScreens,
      guards: [AuthGuard],
      children: [
        MaterialRoute(
          path: 'home',
          name: 'homeRoute',
          page: HomeScreen,
          guards: [AuthGuard],
        ),
        MaterialRoute(
          path: 'profile',
          name: 'profileRoute',
          page: ProfileScreen,
          guards: [AuthGuard],
        ),
        MaterialRoute(
          path: 'settings',
          name: 'settingsRoute',
          page: SettingsScreen,
          guards: [AuthGuard],
        ),
        MaterialRoute(
          path: 'search',
          name: 'searchRoute',
          page: SearchScreen,
          guards: [AuthGuard],
        )
      ],
    ),
    MaterialRoute(
      path: '/hotel-detail/:hotelDatas',
      name: 'hotelDetailRoute',
      page: HotelDetailScreen,
      guards: [AuthGuard],
    ),
    MaterialRoute(
      path: '/login',
      name: 'loginRoute',
      page: LoginScreen,
      guards: [NonAuthGuard],
    ),
    MaterialRoute(
      path: '/signup',
      name: 'signupRoute',
      page: EmailPasswordSignupScreen,
      guards: [NonAuthGuard],
    ),
    MaterialRoute(
      path: '/phone',
      name: 'phoneRoute',
      page: PhoneScreen,
      guards: [NonAuthGuard],
    ),
  ],
)
class $AppRouter {}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final FirebaseAuthMethods authMethods =
        FirebaseAuthMethods(FirebaseAuth.instance);
    if (authMethods.user != null && authMethods.user!.uid.isNotEmpty) {
      resolver.next(true);
    } else {
      router.push(const LoginRoute()).then((_) => resolver.next(false));
    }
  }
}

class NonAuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final FirebaseAuthMethods authMethods =
        FirebaseAuthMethods(FirebaseAuth.instance);
    if (authMethods.user == null) {
      resolver.next(true);
    } else {
      router.push(const HomeRoute()).then((_) => resolver.next(false));
    }
  }
}
