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
import 'package:flutter/material.dart' as _i11;

import '../../feature/home/page/home_screen.dart' as _i6;
import '../../feature/home/page/hotel_detail_screen.dart' as _i2;
import '../../feature/login/page/login_screen.dart' as _i3;
import '../../feature/login/page/phone_screen.dart' as _i5;
import '../../feature/login/page/signup_email_password_screen.dart' as _i4;
import '../../feature/Navigation/navigation.dart' as _i1;
import '../../feature/profile/page/profile_screen.dart' as _i7;
import '../../feature/search_futures/pages/search_screen.dart' as _i9;
import '../../feature/setting/page/settings_screen.dart' as _i8;
import 'router.dart' as _i12;

class AppRouter extends _i10.RootStackRouter {
  AppRouter({
    _i11.GlobalKey<_i11.NavigatorState>? navigatorKey,
    required this.authGuard,
    required this.nonAuthGuard,
  }) : super(navigatorKey);

  final _i12.AuthGuard authGuard;

  final _i12.NonAuthGuard nonAuthGuard;

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    NavigationRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.NavigationScreens(),
      );
    },
    HotelDetailRoute.name: (routeData) {
      final args = routeData.argsAs<HotelDetailRouteArgs>();
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i2.HotelDetailScreen(hotelDatas: args.hotelDatas),
      );
    },
    LoginRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.LoginScreen(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.EmailPasswordSignupScreen(),
      );
    },
    PhoneRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.PhoneScreen(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HomeScreen(),
      );
    },
    ProfileRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.ProfileScreen(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.SettingsScreen(),
      );
    },
    SearchRoute.name: (routeData) {
      return _i10.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i9.SearchScreen(),
      );
    },
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(
          NavigationRoute.name,
          path: '/',
          guards: [authGuard],
          children: [
            _i10.RouteConfig(
              HomeRoute.name,
              path: 'home',
              parent: NavigationRoute.name,
              guards: [authGuard],
            ),
            _i10.RouteConfig(
              ProfileRoute.name,
              path: 'profile',
              parent: NavigationRoute.name,
              guards: [authGuard],
            ),
            _i10.RouteConfig(
              SettingsRoute.name,
              path: 'settings',
              parent: NavigationRoute.name,
              guards: [authGuard],
            ),
            _i10.RouteConfig(
              SearchRoute.name,
              path: 'search',
              parent: NavigationRoute.name,
              guards: [authGuard],
            ),
          ],
        ),
        _i10.RouteConfig(
          HotelDetailRoute.name,
          path: '/hotel-detail/:hotelDatas',
          guards: [authGuard],
        ),
        _i10.RouteConfig(
          LoginRoute.name,
          path: '/login',
          guards: [nonAuthGuard],
        ),
        _i10.RouteConfig(
          SignupRoute.name,
          path: '/signup',
          guards: [nonAuthGuard],
        ),
        _i10.RouteConfig(
          PhoneRoute.name,
          path: '/phone',
          guards: [nonAuthGuard],
        ),
      ];
}

/// generated route for
/// [_i1.NavigationScreens]
class NavigationRoute extends _i10.PageRouteInfo<void> {
  const NavigationRoute({List<_i10.PageRouteInfo>? children})
      : super(
          NavigationRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'NavigationRoute';
}

/// generated route for
/// [_i2.HotelDetailScreen]
class HotelDetailRoute extends _i10.PageRouteInfo<HotelDetailRouteArgs> {
  HotelDetailRoute({required Map<String, dynamic> hotelDatas})
      : super(
          HotelDetailRoute.name,
          path: '/hotel-detail/:hotelDatas',
          args: HotelDetailRouteArgs(hotelDatas: hotelDatas),
        );

  static const String name = 'HotelDetailRoute';
}

class HotelDetailRouteArgs {
  const HotelDetailRouteArgs({required this.hotelDatas});

  final Map<String, dynamic> hotelDatas;

  @override
  String toString() {
    return 'HotelDetailRouteArgs{hotelDatas: $hotelDatas}';
  }
}

/// generated route for
/// [_i3.LoginScreen]
class LoginRoute extends _i10.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: '/login',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i4.EmailPasswordSignupScreen]
class SignupRoute extends _i10.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: '/signup',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i5.PhoneScreen]
class PhoneRoute extends _i10.PageRouteInfo<void> {
  const PhoneRoute()
      : super(
          PhoneRoute.name,
          path: '/phone',
        );

  static const String name = 'PhoneRoute';
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i7.ProfileScreen]
class ProfileRoute extends _i10.PageRouteInfo<void> {
  const ProfileRoute()
      : super(
          ProfileRoute.name,
          path: 'profile',
        );

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i8.SettingsScreen]
class SettingsRoute extends _i10.PageRouteInfo<void> {
  const SettingsRoute()
      : super(
          SettingsRoute.name,
          path: 'settings',
        );

  static const String name = 'SettingsRoute';
}

/// generated route for
/// [_i9.SearchScreen]
class SearchRoute extends _i10.PageRouteInfo<void> {
  const SearchRoute()
      : super(
          SearchRoute.name,
          path: 'search',
        );

  static const String name = 'SearchRoute';
}
