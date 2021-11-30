import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyBookingTab extends StatelessWidget {
  const MyBookingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Manage Your Booking',
                style: TextStyle(fontSize: 30),
              ),
            ),
            Text(
                'View, reschedule or cancel your bookings and easily book again.'),
            SizedBox(height: 10),
            Text('Time Zone: Western Indonesia Time'),
          ],
        ),
      ),
    );
  }
}
