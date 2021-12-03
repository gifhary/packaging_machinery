import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/route/route_constant.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final db = FirebaseDatabase.instance.reference();

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confrmPassCtrl = TextEditingController();

  String emailError = '';
  String passError = '';

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  bool _isEmailValid(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  bool _isPassValid(String pass, String confrmPass) {
    return pass == confrmPass;
  }

  @override
  Widget build(BuildContext context) {
    final users = db.child(DbConstant.user);

    _postData() {
      users.child(getMd5(emailCtrl.text)).set({
        'email': emailCtrl.text,
        'password': getMd5(passCtrl.text),
      }).then((_) {
        GetStorage box = GetStorage();
        box.write(
            'user',
            User(email: emailCtrl.text, password: getMd5(passCtrl.text))
                .toJson());
        Get.offAllNamed(RouteConstant.home);
      }).onError((error, stackTrace) {
        setState(() {
          emailError = error.toString();
        });
      });
    }

    _register() {
      if (!_isEmailValid(emailCtrl.text)) {
        setState(() {
          emailError = 'invalid email';
        });
        return;
      } else {
        setState(() {
          emailError = '';
        });
      }
      if (!_isPassValid(passCtrl.text, confrmPassCtrl.text)) {
        setState(() {
          passError = 'password not match';
        });
        return;
      } else {
        setState(() {
          passError = '';
        });
      }
      //check and post
      users.child(getMd5(emailCtrl.text)).get().then((value) {
        if (value.exists) {
          setState(() {
            emailError = 'use another email';
          });
        } else {
          _postData();
        }
      });
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sign Up',
              style: TextStyle(fontSize: 48),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: 350,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Email'),
                      const SizedBox(width: 10),
                      Text(
                        emailError,
                        style: const TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ],
                  ),
                  TextField(
                    controller: emailCtrl,
                  ),
                  const SizedBox(height: 15),
                  const Text('Password'),
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Text('Confirm Password'),
                      const SizedBox(width: 10),
                      Text(
                        passError,
                        style: const TextStyle(fontSize: 10, color: Colors.red),
                      ),
                    ],
                  ),
                  TextField(
                    controller: confrmPassCtrl,
                    obscureText: true,
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            SizedBox(
              width: 200,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color.fromRGBO(160, 152, 128, 1),
                ),
                onPressed: _register,
                child: const Text('Sign Up'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
