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
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:flutter/material.dart' as _i5;

import '../pages/deignation.page.dart' as _i2;
import '../pages/department.page.dart' as _i3;
import '../pages/home.page.dart' as _i1;

class AppRouter extends _i4.RootStackRouter {
  AppRouter([_i5.GlobalKey<_i5.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.HomePage(),
      );
    },
    DesignationRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.DesignationPage(),
      );
    },
    DepartmentRoute.name: (routeData) {
      return _i4.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.DepartmentPage(),
      );
    },
  };

  @override
  List<_i4.RouteConfig> get routes => [
        _i4.RouteConfig(
          HomeRoute.name,
          path: '/',
        ),
        _i4.RouteConfig(
          DesignationRoute.name,
          path: '/designation-page',
        ),
        _i4.RouteConfig(
          DepartmentRoute.name,
          path: '/department-page',
        ),
      ];
}

/// generated route for
/// [_i1.HomePage]
class HomeRoute extends _i4.PageRouteInfo<void> {
  const HomeRoute()
      : super(
          HomeRoute.name,
          path: '/',
        );

  static const String name = 'HomeRoute';
}

/// generated route for
/// [_i2.DesignationPage]
class DesignationRoute extends _i4.PageRouteInfo<void> {
  const DesignationRoute()
      : super(
          DesignationRoute.name,
          path: '/designation-page',
        );

  static const String name = 'DesignationRoute';
}

/// generated route for
/// [_i3.DepartmentPage]
class DepartmentRoute extends _i4.PageRouteInfo<void> {
  const DepartmentRoute()
      : super(
          DepartmentRoute.name,
          path: '/department-page',
        );

  static const String name = 'DepartmentRoute';
}
