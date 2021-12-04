import 'package:flutter/material.dart';
import 'package:packaging_machinery/model/item.dart';

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
      if (item.orderData.approvedByCompany &&
          item.orderData.approvedByCustomer) {
        status = 'On delivery';
      } else if (item.orderData.approvedByCompany &&
          !item.orderData.approvedByCustomer) {
        status = 'Waiting for confirmation';
      } else if (!item.orderData.approvedByCompany &&
          !item.orderData.approvedByCustomer) {
        status = 'On process';
      }
      return status;
    }

    return Column(
      children: [
        InkWell(
          onTap: () => onTap(item),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: _width * 0.35,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: _width * 0.35,
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Text('Date created: ${item.orderData.time}'),
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
