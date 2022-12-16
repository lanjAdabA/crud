import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:crud/logic/cubit/login_cubit.dart';
import 'package:crud/router/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscurePassword = true;
  void togglePasswordObscure() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    var c = context.watch<LoginCubit>();

    var status = c.state.status;
    switch (status) {
      case Status.initial:
        log("initial state");
        break;
      case Status.loading:
        log("loading state");
        EasyLoading.show(status: "please wait");
        break;
      case Status.loaded:
        context.router.push(const AuthFlowRoute());
        EasyLoading.dismiss();
        log("loaded state");

        break;
      case Status.error:
        log("error state");
        EasyLoading.showError("Invalid username/password");

        break;
    }
    return Builder(builder: (context) {
      return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text("Login Page"),
            backgroundColor: const Color.fromARGB(255, 222, 252, 238),
            foregroundColor: const Color.fromARGB(255, 32, 32, 32),
          ),
          body: SafeArea(
            child: Container(
              color: const Color.fromARGB(255, 222, 252, 238),
              child: Column(
                children: [
                  //*background image
                  const Center(
                    child: SizedBox(
                      height: 300,
                      child: Opacity(
                        opacity: .2,
                        child: Image(image: AssetImage("assets/userLogin.png")),
                      ),
                    ),
                  ),
                  //* username field
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30, bottom: 10),
                    child: Card(
                      elevation: 12,
                      color: const Color.fromARGB(255, 229, 250, 241),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: userNameController,
                          decoration: const InputDecoration(
                              prefixIcon: Icon(Icons.account_circle),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(
                                        255, 181, 216, 245)), //<-- SEE HERE
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(
                                        255, 213, 246, 230)), //<-- SEE HERE
                              ),
                              hintText: '   Username'),
                          showCursor: true,
                        ),
                      ),
                    ),
                  ),
                  //*password
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Card(
                      elevation: 12,
                      color: const Color.fromARGB(255, 229, 250, 241),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          controller: passwordController,
                          obscureText: obscurePassword,
                          decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: togglePasswordObscure,
                                  child: Icon(obscurePassword
                                      ? Icons.hide_source_rounded
                                      : Icons.remove_red_eye_outlined)),
                              prefixIcon: const Icon(Icons.password_outlined),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(
                                        255, 181, 216, 245)), //<-- SEE HERE
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 2,
                                    color: Color.fromARGB(
                                        255, 213, 246, 230)), //<-- SEE HERE
                              ),
                              hintText: '   Enter Password'),
                          showCursor: true,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  //* login button
                  Column(
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints.tightFor(
                            height: 54, width: 160),
                        child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              elevation: 20,
                              shadowColor: Colors.deepPurpleAccent,
                              backgroundColor: Colors
                                  .deepPurple[300], // background (button) color
                              foregroundColor:
                                  Colors.white, // foreground (text) color
                            ),
                            onPressed: () {
                              context.read<LoginCubit>().loginUser(
                                  username: userNameController.text,
                                  password: passwordController.text);
                            },
                            icon: const Icon(
                              Icons.login,
                              size: 20,
                            ),
                            label: const Text(
                              "Login",
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      //*not a user? sign up

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Not a Member yet ?   "),
                          TextButton(
                              onPressed: () {
                                context.router.push(const SignupRoute());
                              },
                              child: const Text(
                                "Click here to Register now",
                                style: TextStyle(fontSize: 16),
                              ))
                        ],
                      )
                    ],
                  )

                  //* forgot pass
                ],
              ),
            ),
          ));
    });
  }
}
