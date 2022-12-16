// @CupertinoAutoRouter
// @AdaptiveAutoRouter
// @CustomAutoRouter
import 'package:auto_route/annotations.dart';
import 'package:crud/AuthFlow/auth_flow.dart';
import 'package:crud/pages/designation.page.dart';
import 'package:crud/pages/department.page.dart';
import 'package:crud/pages/home.page.dart';
import 'package:crud/pages/login.page.dart';
import 'package:crud/pages/signup.page.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: AuthFlowPage, initial: true, children: [
      AutoRoute(page: HomePage),
      AutoRoute(page: LoginPage),
    ]),
    AutoRoute(page: SignupPage),
    AutoRoute(page: DesignationPage),
    AutoRoute(page: DepartmentPage),
  ],
)
class $AppRouter {}
