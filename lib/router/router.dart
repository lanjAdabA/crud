// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/annotations.dart';
import 'package:crud/pages/deignation.page.dart';
import 'package:crud/pages/department.page.dart';
import 'package:crud/pages/home.page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: DesignationPage),
    AutoRoute(page: DepartmentPage),
  ],
)
class $AppRouter {}
