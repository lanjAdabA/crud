import 'package:crud/logic/cubit/authFlow/cubit/auth_flow_cubit.dart';
import 'package:crud/logic/cubit/login_cubit.dart';
import 'package:crud/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(),
        ),
        BlocProvider(
          create: (context) => AuthFlowCubit(),
        ),
      ],
      child: MaterialApp.router(
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            backgroundColor: Colors.grey,
            appBarTheme: const AppBarTheme(color: Colors.grey)),
        builder: EasyLoading.init(),

        // home: const HomePage()
      ),
    );
  }
}
