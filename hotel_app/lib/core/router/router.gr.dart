// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:auto_route/empty_router_widgets.dart' as _i6;
import 'package:flutter/material.dart' as _i11;

import '../../feature/home/page/home_screen.dart' as _i8;
import '../../feature/home/page/home_test.dart' as _i9;
import '../../feature/login/page/login_screen.dart' as _i2;
import '../../feature/login/page/phone_screen.dart' as _i3;
import '../../feature/login/page/signup_email_password_screen.dart' as _i4;
import '../../feature/main/main_route.dart' as _i1;
import '../../feature/profile/page/profile_screen.dart' as _i5;
import '../../feature/setting/page/settings_screen.dart' as _i7;

class AppRouter extends _i10.RootStackRouter {
  AppRouter([_i11.GlobalKey<_i11.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    WrapperRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthWrapper(),
      );
    },
    Login.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    Phone.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.PhoneScreen(),
      );
    },
    SignupEmailPassword.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmailPasswordSignup(),
      );
    },
    Profile.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ProfileScreen(),
      );
    },
    Home.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.EmptyRouterPage(),
      );
    },
    Settings.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsScreen(),
      );
    },
    HomeScreen.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.HomeScreen(),
      );
    },
    HomeTest.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<HomeTestArgs>(
          orElse: () => HomeTestArgs(id: pathParams.getInt('id')));
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i9.HomeTest(
          key: args.key,
          id: args.id,
        ),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          WrapperRoute.name,
          path: '/',
          children: [
            _i10.RouteConfig(
              Login.name,
              path: 'login',
              parent: WrapperRoute.name,
            ),
            _i10.RouteConfig(
              Phone.name,
              path: 'phone',
              parent: WrapperRoute.name,
            ),
            _i10.RouteConfig(
              SignupEmailPassword.name,
              path: 'signup-email-password',
              parent: WrapperRoute.name,
            ),
            _i10.RouteConfig(
              Profile.name,
              path: 'Profile',
              parent: WrapperRoute.name,
            ),
            _i10.RouteConfig(
              Home.name,
              path: 'home',
              parent: WrapperRoute.name,
              children: [
                _i10.RouteConfig(
                  HomeScreen.name,
                  path: '',
                  parent: Home.name,
                ),
                _i10.RouteConfig(
                  HomeTest.name,
                  path: ':id',
                  parent: Home.name,
                ),
              ],
            ),
            _i10.RouteConfig(
              Settings.name,
              path: 'settings',
              parent: WrapperRoute.name,
            ),
          ],
        )
      ];
}

/// generated route for
/// [_i1.AuthWrapper]
class WrapperRoute extends _i10.PageRouteInfo<void> {
  const WrapperRoute({List<_i10.PageRouteInfo>? children})
      : super(
          WrapperRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'WrapperRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class Login extends _i10.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: 'login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i3.PhoneScreen]
class Phone extends _i10.PageRouteInfo<void> {
  const Phone()
      : super(
          Phone.name,
          path: 'phone',
        );

  static const String name = 'Phone';
}

/// generated route for
/// [_i4.EmailPasswordSignup]
class SignupEmailPassword extends _i10.PageRouteInfo<void> {
  const SignupEmailPassword()
      : super(
          SignupEmailPassword.name,
          path: 'signup-email-password',
        );

  static const String name = 'SignupEmailPassword';
}

/// generated route for
/// [_i5.ProfileScreen]
class Profile extends _i10.PageRouteInfo<void> {
  const Profile()
      : super(
          Profile.name,
          path: 'Profile',
        );

  static const String name = 'Profile';
}

/// generated route for
/// [_i6.EmptyRouterPage]
class Home extends _i10.PageRouteInfo<void> {
  const Home({List<_i10.PageRouteInfo>? children})
      : super(
          Home.name,
          path: 'home',
          initialChildren: children,
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i7.SettingsScreen]
class Settings extends _i10.PageRouteInfo<void> {
  const Settings()
      : super(
          Settings.name,
          path: 'settings',
        );

  static const String name = 'Settings';
}

/// generated route for
/// [_i8.HomeScreen]
class HomeScreen extends _i10.PageRouteInfo<void> {
  const HomeScreen()
      : super(
          HomeScreen.name,
          path: '',
        );

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i9.HomeTest]
class HomeTest extends _i10.PageRouteInfo<HomeTestArgs> {
  HomeTest({
    _i11.Key? key,
    required int id,
  }) : super(
          HomeTest.name,
          path: ':id',
          args: HomeTestArgs(
            key: key,
            id: id,
          ),
          rawPathParams: {'id': id},
        );

  static const String name = 'HomeTest';
}

class HomeTestArgs {
  const HomeTestArgs({
    this.key,
    required this.id,
  });

  final _i11.Key? key;

  final int id;

  @override
  String toString() {
    return 'HomeTestArgs{key: $key, id: $id}';
  }
}
