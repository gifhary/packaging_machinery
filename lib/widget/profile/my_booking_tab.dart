import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/order_data.dart';
import 'package:packaging_machinery/widget/booking_item.dart';

class MyBookingTab extends StatelessWidget {
  final List<Item> item;
  final Function(String)? onTap;
  final Function(String, OrderData)? onSubmit;
  final Function(String)? onDelete;

  const MyBookingTab({
    Key? key,
    required this.item,
    this.onTap,
    this.onSubmit,
    this.onDelete,
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
            Container(
              height: 0.5,
              width: double.infinity,
              color: const Color.fromRGBO(117, 111, 99, 0.5),
            ),
            Flexible(
              child: ListView.builder(
                  itemCount: item.length,
                  itemBuilder: (context, index) {
                    return BookingItem(
                      item: item[index],
                      onDelete: onDelete,
                      onSubmit: onSubmit,
                      onTap: onTap,
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
