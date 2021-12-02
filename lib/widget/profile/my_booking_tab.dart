import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packaging_machinery/model/item.dart';

class MyBookingTab extends StatelessWidget {
  final List<Item> item;
  const MyBookingTab({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Text(
                'Manage Your Booking',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Text(
                'View, reschedule or cancel your bookings and easily book again.'),
            const SizedBox(height: 10),
            const Text('Time Zone: Western Indonesia Time'),
            Flexible(
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return Text(item[index].orderId);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
