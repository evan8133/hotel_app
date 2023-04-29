import 'package:auto_route/auto_route.dart';
import 'package:auto_route/empty_router_widgets.dart';
import 'package:hotel_app/feature/home/page/home_screen.dart';
import 'package:hotel_app/feature/home/page/home_test.dart';
import 'package:hotel_app/feature/login/page/login_screen.dart';
import 'package:hotel_app/feature/login/page/phone_screen.dart';
import 'package:hotel_app/feature/profile/page/profile_screen.dart';
import 'package:hotel_app/feature/setting/page/settings_screen.dart';

import '../../feature/login/page/signup_email_password_screen.dart';
import '../../feature/main/main_route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(
      initial: true,
      path: '/',
      name: 'WrapperRoute',
      page: AuthWrapper,
      children: [
        AutoRoute(
          path: 'login',
          name: 'Login',
          page: LoginScreen,
        ),
        AutoRoute(
          path: 'phone',
          name: 'Phone',
          page: PhoneScreen,
        ),
        AutoRoute(
          path: 'signup-email-password',
          name: 'SignupEmailPassword',
          page: EmailPasswordSignup,
        ),
        AutoRoute(
          path: 'Profile',
          name: 'Profile',
          page: ProfileScreen,
        ),
        AutoRoute(
          path: 'home',
          name: 'Home',
          page: EmptyRouterPage,
          children: [
            AutoRoute(
              path: '',
              page: HomeScreen,
            ),
            AutoRoute(
              path: ':id',
              page: HomeTest,
            ),
          ],
        ),
        AutoRoute(
          path: 'settings',
          name: 'Settings',
          page: SettingsScreen,
        )
      ],
    ),
  ],
)
class $AppRouter {}
