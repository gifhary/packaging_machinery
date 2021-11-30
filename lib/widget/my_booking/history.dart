import 'package:flutter/material.dart';

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: const [
            Text('History'),
            SizedBox(height: 200),
            Text('History'),
            SizedBox(height: 200),
            Text('History'),
            SizedBox(height: 200),
            Text('History'),
            SizedBox(height: 200),
            Text('History'),
            SizedBox(height: 200),
          ],
        ),
      ),
    );
  }
}
