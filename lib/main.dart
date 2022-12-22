import 'dart:developer';

import 'package:crud/firebase_options.dart';
import 'package:crud/logic/cubit/authFlow/cubit/auth_flow_cubit.dart';
import 'package:crud/logic/cubit/login_cubit.dart';
import 'package:crud/router/router.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "High importance channel", "high importance notification",
    importance: Importance.high, playSound: true);

Future<void> _firebaseBackgroundMessaging(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("handling a background message: ${message.messageId}");
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value) => log(value.toString()));

  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessaging);

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("got msg while on foreground ${message.data}");

    if (message.notification != null) {
      print("message also contains a notification: ${message.notification}");
    }
  });

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
