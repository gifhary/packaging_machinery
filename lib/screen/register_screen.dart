import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              width: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Email'),
                  TextField(),
                  SizedBox(height: 15),
                  Text('Password'),
                  TextField(
                    obscureText: true,
                  ),
                  SizedBox(height: 15),
                  Text('Confirm Password'),
                  TextField(
                    obscureText: true,
                  ),
                  SizedBox(height: 30),
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
                child: const Text('Sign Up'),
              )),
            )
          ],
        ),
      ),
    );
  }
}
