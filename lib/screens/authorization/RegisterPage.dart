import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rickandmorty/bloc/authorization/authorization_bloc.dart';

import '../../widgets/customTextFeild.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerFirstName = TextEditingController();
  final TextEditingController controllerLastName = TextEditingController();
  final AuthorizationBloc bloc = AuthorizationBloc();

  bool obscureText = true;
  bool _isPasswordValid = true;

  void _validatePassword(String value) {
    setState(() {
      _isPasswordValid = value.length >= 8 && value.contains(RegExp(r'[0-9]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(28.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_outlined,
                  size: 36.r,
                ),
              ),
              28.verticalSpace,
              Text(
                "Create an account",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34.r),
              ),
              40.verticalSpace,
              Text(
                "First name",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.r,
                ),
              ),
              8.verticalSpace,
              CustomTextFeild(
                  controller: controllerFirstName,
                  text: 'First name',
                ),
              10.verticalSpace,
              Text(
                "Last name",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.r,
                ),
              ),
              8.verticalSpace,
              CustomTextFeild(
                  controller: controllerLastName,
                  text: 'Last name',
                ),
              36.verticalSpace,
              Divider(),
              36.verticalSpace,
              Text(
                "Email",
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.r,
                ),
              ),
              8.verticalSpace,
              CustomTextFeild(
                  controller: controllerEmail,
                  text: 'Email',
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
                          obscureText = !obscureText;
                          setState(() {});
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
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    errorText: _isPasswordValid
                        ? null
                        : 'Password must be at least 8 characters long and contain numbers',
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
                  ),
                  onChanged: _validatePassword,
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
                    if (_isPasswordValid) {
                      bloc.add(Register(
                        email: controllerEmail.text,
                        password: controllerPassword.text,
                        firstname: controllerFirstName.text,
                        lastname: controllerLastName.text,
                      ));
                      Navigator.pop(context);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Error"),
                            content: const Text(
                                "Incorrect login or password entered"),
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
                  child: Text(
                    "Create",
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.r,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
