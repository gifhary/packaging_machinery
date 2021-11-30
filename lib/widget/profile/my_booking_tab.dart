import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packaging_machinery/widget/my_booking/history.dart';
import 'package:packaging_machinery/widget/my_booking/upcoming.dart';

class MyBookingTab extends StatelessWidget {
  const MyBookingTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Manage Your Bookings',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Text(
                  'View, reschedule or cancel your bookings and easily book again.'),
              SizedBox(height: 10),
              Text('Time Zone: Western Indonesia Time'),
              SizedBox(height: 20),
              SizedBox(
                width: 250,
                child: TabBar(
                  labelColor: Colors.black,
                  indicatorColor: Color.fromRGBO(117, 111, 99, 1),
                  tabs: [
                    Tab(child: Text('Upcoming')),
                    Tab(child: Text('History')),
                  ],
                ),
              ),
              Divider(color: Color.fromRGBO(117, 111, 99, 1)),
              Flexible(child: TabBarView(children: [Upcoming(), History()]))
            ],
          ),
        ),
      ),
    );
  }
}
