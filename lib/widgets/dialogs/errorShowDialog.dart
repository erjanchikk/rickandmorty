import 'package:flutter/material.dart';

Future<dynamic> errorShowDialog(BuildContext context) {
    return showDialog(
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