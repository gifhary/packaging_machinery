import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packaging_machinery/widget/my_booking/history.dart';
import 'package:packaging_machinery/widget/my_booking/upcoming.dart';

class MyOrderTab extends StatelessWidget {
  const MyOrderTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: DefaultTabController(
        length: 2,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  'Manage Your Order',
                  style: TextStyle(fontSize: 30),
                ),
              ),
              const Text(
                  'View, reschedule or cancel your orders and easily order again.'),
              const SizedBox(height: 10),
              const Text('Time Zone: Western Indonesia Time'),
              const SizedBox(
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
              Container(
                height: 0.5,
                width: double.infinity,
                color: const Color.fromRGBO(117, 111, 99, 0.5),
              ),
              const Flexible(
                  child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [Upcoming(), History()]))
            ],
          ),
        ),
      ),
    );
  }
}
