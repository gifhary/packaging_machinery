import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/route/route_constant.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final db = FirebaseDatabase.instance.reference();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  String loginError = '';

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    final users = db.child(DbConstant.user);

    _login() {
      users.child(getMd5(emailCtrl.text)).get().then((value) {
        if (value.exists && getMd5(passCtrl.text) == value.value['password']) {
          debugPrint("yee " + value.value.toString());
          GetStorage box = GetStorage();
          box.write('user', value.value);
          Get.offAllNamed(RouteConstant.home);
        } else {
          setState(() {
            loginError = 'invalid credentials';
          });
        }
      });
    }

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Log In',
            style: TextStyle(fontSize: 48),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('New to this site? '),
              InkWell(
                onTap: () => Get.offNamed(RouteConstant.register),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(color: Color.fromRGBO(117, 111, 99, 1)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Email'),
                TextField(
                  controller: emailCtrl,
                ),
                const SizedBox(height: 15),
                const Text('Password'),
                TextField(
                  controller: passCtrl,
                  obscureText: true,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: InkWell(
                    onTap: () {},
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 200,
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromRGBO(160, 152, 128, 1),
                  ),
                  onPressed: _login,
                  child: const Text('Log In'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    loginError,
                    style: const TextStyle(fontSize: 10, color: Colors.red),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
