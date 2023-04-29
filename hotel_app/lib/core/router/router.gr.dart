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
import 'package:auto_route/auto_route.dart' as _i8;
import 'package:flutter/material.dart' as _i9;

import '../../feature/home/page/home_screen.dart' as _i6;
import '../../feature/login/page/login_screen.dart' as _i2;
import '../../feature/login/page/phone_screen.dart' as _i3;
import '../../feature/login/page/signup_email_password_screen.dart' as _i4;
import '../../feature/main/main_route.dart' as _i1;
import '../../feature/profile/page/profile_screen.dart' as _i5;
import '../../feature/setting/page/settings_screen.dart' as _i7;

class AppRouter extends _i8.RootStackRouter {
  AppRouter([_i9.GlobalKey<_i9.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i8.PageFactory> pagesMap = {
    WrapperRoute.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthWrapper(),
      );
    },
    Login.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    Phone.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.PhoneScreen(),
      );
    },
    SignupEmailPassword.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmailPasswordSignup(),
      );
    },
    Profile.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.ProfileScreen(),
      );
    },
    Home.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    Settings.name: (routeData) {
      return _i8.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.SettingsScreen(),
      );
    },
  };

  @override
  List<_i8.RouteConfig> get routes => [
        _i8.RouteConfig(
          WrapperRoute.name,
          path: '/',
        ),
        _i8.RouteConfig(
          Login.name,
          path: '/login',
        ),
        _i8.RouteConfig(
          Phone.name,
          path: '/phone',
        ),
        _i8.RouteConfig(
          SignupEmailPassword.name,
          path: '/signup-email-password',
        ),
        _i8.RouteConfig(
          Profile.name,
          path: '/profile',
        ),
        _i8.RouteConfig(
          Home.name,
          path: '/home',
        ),
        _i8.RouteConfig(
          Settings.name,
          path: '/settings',
        ),
      ];
}

/// generated route for
/// [_i1.AuthWrapper]
class WrapperRoute extends _i8.PageRouteInfo<void> {
  const WrapperRoute()
      : super(
          WrapperRoute.name,
          path: '/',
        );

  static const String name = 'WrapperRoute';
}

/// generated route for
/// [_i2.LoginScreen]
class Login extends _i8.PageRouteInfo<void> {
  const Login()
      : super(
          Login.name,
          path: '/login',
        );

  static const String name = 'Login';
}

/// generated route for
/// [_i3.PhoneScreen]
class Phone extends _i8.PageRouteInfo<void> {
  const Phone()
      : super(
          Phone.name,
          path: '/phone',
        );

  static const String name = 'Phone';
}

/// generated route for
/// [_i4.EmailPasswordSignup]
class SignupEmailPassword extends _i8.PageRouteInfo<void> {
  const SignupEmailPassword()
      : super(
          SignupEmailPassword.name,
          path: '/signup-email-password',
        );

  static const String name = 'SignupEmailPassword';
}

/// generated route for
/// [_i5.ProfileScreen]
class Profile extends _i8.PageRouteInfo<void> {
  const Profile()
      : super(
          Profile.name,
          path: '/profile',
        );

  static const String name = 'Profile';
}

/// generated route for
/// [_i6.HomeScreen]
class Home extends _i8.PageRouteInfo<void> {
  const Home()
      : super(
          Home.name,
          path: '/home',
        );

  static const String name = 'Home';
}

/// generated route for
/// [_i7.SettingsScreen]
class Settings extends _i8.PageRouteInfo<void> {
  const Settings()
      : super(
          Settings.name,
          path: '/settings',
        );

  static const String name = 'Settings';
}
