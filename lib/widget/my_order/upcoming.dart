import 'package:flutter/material.dart';

class Upcoming extends StatelessWidget {
  const Upcoming({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: const [
            SizedBox(height: 100),
            Text('Upcoming'),
            SizedBox(height: 100),
            Text('Upcoming'),
            Text('Upcoming'),
            SizedBox(height: 100),
            Text('Upcoming'),
            Text('Upcoming'),
            SizedBox(height: 100),
            Text('Upcoming'),
            Text('Upcoming'),
            SizedBox(height: 100),
            Text('Upcoming'),
            SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
