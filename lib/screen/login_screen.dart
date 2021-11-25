import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packaging_machinery/route/route_constant.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                onTap: () => Get.toNamed(RouteConstant.register),
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
                const TextField(),
                const SizedBox(height: 15),
                const Text('Password'),
                const TextField(
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
            child: Expanded(
                child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromRGBO(160, 152, 128, 1),
              ),
              onPressed: () {},
              child: const Text('Log In'),
            )),
          )
        ],
      ),
    );
  }
}
