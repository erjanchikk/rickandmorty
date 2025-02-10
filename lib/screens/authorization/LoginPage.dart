import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickandmorty/bloc/authorization/authorization_bloc.dart';
import 'package:rickandmorty/screens/BottomBar.dart';
import 'package:rickandmorty/screens/CharactersPage.dart';
import 'package:rickandmorty/screens/authorization/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController controllerEmail;
  late final TextEditingController controllerPassword;

  late final AuthorizationBloc bloc;

  bool obscureText = true;

  @override
  void initState() {
    controllerEmail = TextEditingController();
    controllerPassword = TextEditingController();
    bloc = AuthorizationBloc();
    bloc.add(CheckUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener(
        bloc: bloc,
        listener: (context, state) {
          if (state is AuthorizationSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => BottomBar(),
                ));
          }
          if (state is AuthorizationErrorState) {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Error"),
                  content: const Text("Incorrect login or password entered"),
                  actions: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          side: const BorderSide(
                            color: Color(0xff22A2BD),
                            width: 2,
                          ),
                          foregroundColor: Color(0xff22A2BD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(ScreenUtil().setSp(28)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    "assets/icon.png",
                    alignment: Alignment.center,
                  ),
                ),
                65.verticalSpace,
                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.r,
                  ),
                ),
                8.verticalSpace,
                SizedBox(
                  height: 48.r,
                  width: 319.r,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14.r,
                      ),
                      prefixIcon: Icon(Icons.person_2_outlined),
                      filled: true,
                      fillColor: Color(0xffF2F2F2),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.r, horizontal: 16.r),
                    ),
                    controller: controllerEmail,
                  ),
                ),
                10.verticalSpace,
                Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14.r,
                  ),
                ),
                8.verticalSpace,
                SizedBox(
                  height: 48.r,
                  width: 319.r,
                  child: TextField(
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.r,
                      ),
                      prefixIcon: Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              obscureText = !obscureText;
                            });
                          },
                          icon: Icon(obscureText
                              ? Icons.remove_red_eye_outlined
                              : Icons.remove_red_eye)),
                      filled: true,
                      fillColor: Color(0xffF2F2F2),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 12.r, horizontal: 16.r),
                    ),
                    controller: controllerPassword,
                  ),
                ),
                24.verticalSpace,
                SizedBox(
                  height: 48.r,
                  width: 319.r,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff22A2BD),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () async {
                      bloc.add(Login(
                          email: controllerEmail.text,
                          password: controllerPassword.text));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.r,
                      ),
                    ),
                  ),
                ),
                24.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account yet?",
                      style: TextStyle(
                        color: Color(0xff5B6975),
                        fontWeight: FontWeight.w400,
                        fontSize: 14.r,
                      ),
                    ),
                    10.horizontalSpace,
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RegisterPage(),
                            ));
                      },
                      child: Text(
                        "Create",
                        style: TextStyle(
                          color: Color(0xff43D049),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.r,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
