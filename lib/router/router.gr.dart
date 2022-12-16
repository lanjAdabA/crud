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
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;

import '../AuthFlow/auth_flow.dart' as _i1;
import '../pages/department.page.dart' as _i4;
import '../pages/designation.page.dart' as _i3;
import '../pages/home.page.dart' as _i6;
import '../pages/login.page.dart' as _i5;
import '../pages/signup.page.dart' as _i2;

class AppRouter extends _i7.RootStackRouter {
  AppRouter([_i8.GlobalKey<_i8.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    AuthFlowRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.AuthFlowPage(),
      );
    },
    SignupRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SignupPage(),
      );
    },
    DesignationRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.DesignationPage(),
      );
    },
    DepartmentRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i4.DepartmentPage(),
      );
    },
    LoginRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPage(),
      );
    },
    HomeRoute.name: (routeData) {
      return _i7.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
  };

  @override
  List<_i7.RouteConfig> get routes => [
        _i7.RouteConfig(
          AuthFlowRoute.name,
          path: '/',
          children: [
            _i7.RouteConfig(
              LoginRoute.name,
              path: 'login-page',
              parent: AuthFlowRoute.name,
            ),
            _i7.RouteConfig(
              HomeRoute.name,
              path: 'home-page',
              parent: AuthFlowRoute.name,
            ),
          ],
        ),
        _i7.RouteConfig(
          SignupRoute.name,
          path: '/signup-page',
        ),
        _i7.RouteConfig(
          DesignationRoute.name,
          path: '/designation-page',
        ),
        _i7.RouteConfig(
          DepartmentRoute.name,
          path: '/department-page',
        ),
      ];
}

/// generated route for
/// [_i1.AuthFlowPage]
class AuthFlowRoute extends _i7.PageRouteInfo<void> {
  const AuthFlowRoute({List<_i7.PageRouteInfo>? children})
      : super(
          AuthFlowRoute.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'AuthFlowRoute';
}

/// generated route for
/// [_i2.SignupPage]
class SignupRoute extends _i7.PageRouteInfo<void> {
  const SignupRoute()
      : super(
          SignupRoute.name,
          path: '/signup-page',
        );

  static const String name = 'SignupRoute';
}

/// generated route for
/// [_i3.DesignationPage]
class DesignationRoute extends _i7.PageRouteInfo<void> {
  const DesignationRoute()
      : super(
          DesignationRoute.name,
          path: '/designation-page',
        );

  static const String name = 'DesignationRoute';
}

/// generated route for
/// [_i4.DepartmentPage]
class DepartmentRoute extends _i7.PageRouteInfo<void> {
  const DepartmentRoute()
      : super(
          DepartmentRoute.name,
          path: '/department-page',
        );

  static const String name = 'DepartmentRoute';
}

/// generated route for
/// [_i5.LoginPage]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute()
      : super(
          LoginRoute.name,
          path: 'login-page',
        );

  static const String name = 'LoginRoute';
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i7.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: 'home-page',
        );

  static const String name = 'HomeRoute';
}
