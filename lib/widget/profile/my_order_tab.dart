import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/route/route_constant.dart';
import 'package:packaging_machinery/widget/order_item.dart';

class MyOrderTab extends StatelessWidget {
  final List<Item> item;
  const MyOrderTab({Key? key, required this.item}) : super(key: key);

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
                'Manage Your Order',
                style: TextStyle(fontSize: 30),
              ),
            ),
            const Text(
                'View, reschedule or cancel your orders and easily order again.'),
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
                    return OrderItem(
                      onTap: (item) => Get.toNamed(RouteConstant.quotationOrder,
                          arguments: item.toMap()),
                      item: item[index],
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
