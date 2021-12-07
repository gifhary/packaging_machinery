import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/route/route_constant.dart';

class OrderItem extends StatelessWidget {
  final Item item;
  final Function(Item) onTap;

  const OrderItem({Key? key, required this.item, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    String _getStatus() {
      String status = '';
      if (!item.orderData.delivered) {
        if (item.orderData.confirmedBySales &&
            item.orderData.approvedByCustomer) {
          status = 'On delivery';
        } else if (item.orderData.confirmedBySales &&
            !item.orderData.approvedByCustomer) {
          status = 'Waiting for approval';
        } else if (!item.orderData.confirmedBySales &&
            !item.orderData.approvedByCustomer) {
          status = 'On process';
        }
      } else {
        status = 'Delivered';
      }
      return status;
    }

    int daysBetween() {
      DateTime from = DateTime.parse(item.orderData.deliveryNoteConfirmedDate!);
      DateTime to = DateTime.now();

      from = DateTime(from.year, from.month, from.day);
      to = DateTime(to.year, to.month, to.day);
      return (to.difference(from).inHours / 24).round();
    }

    _onTap() {
      if (!item.orderData.delivered) {
        onTap(item);
      }
    }

    return Column(
      children: [
        InkWell(
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: _width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: _width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.orderData.orderTitle,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Color.fromRGBO(117, 111, 99, 1)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text('Order ID: ${item.orderId}'),
                            Text('Status: ${_getStatus()}'),
                            Visibility(
                                visible: item.orderData.confirmedBySales &&
                                    item.orderData.approvedByCustomer,
                                child: Row(
                                  children: [
                                    Text('Tracking number: '),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  222, 222, 222, 1))),
                                      child: Text('109822873778'),
                                    )
                                  ],
                                )),
                            item.orderData.deliveryNoteConfirmedDate == null
                                ? Container()
                                : Text(
                                    'Due payment in ${45 - daysBetween()} days',
                                    style: TextStyle(
                                        color: 45 - daysBetween() < 3
                                            ? Colors.red
                                            : Colors.black),
                                  ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: item.orderData.delivered,
                        child: Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(160, 152, 128, 1),
                                ),
                                onPressed: () {},
                                child: const Text('Invoice'),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(160, 152, 128, 1)),
                                onPressed: () => Get.toNamed(
                                    RouteConstant.deliveryNote,
                                    arguments: item.toMap()),
                                child: const Text('Delivery Note'),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(160, 152, 128, 1)),
                                onPressed: () {},
                                child: const Text('Payment'),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text('Date created: ${item.orderData.orderTime}'),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: double.infinity,
          color: const Color.fromRGBO(117, 111, 99, 0.5),
        ),
      ],
    );
  }
}
