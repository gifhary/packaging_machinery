import 'package:flutter/material.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/order_data.dart';

class BookingItem extends StatelessWidget {
  final Item item;
  final Function(String)? onTap;
  final Function(String, OrderData)? onSubmit;
  final Function(String)? onDelete;
  const BookingItem(
      {Key? key, required this.item, this.onTap, this.onSubmit, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        InkWell(
          onTap: () => onTap!(item.orderId),
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
                        width: _width * 0.2,
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
                            Text('Booking ID: ${item.orderId}'),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(160, 152, 128, 1),
                            ),
                            onPressed: () =>
                                onSubmit!(item.orderId, item.orderData),
                            child: const Text('Submit'),
                          ),
                          const SizedBox(width: 20),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                primary:
                                    const Color.fromRGBO(160, 152, 128, 1)),
                            onPressed: () => onDelete!(item.orderId),
                            child: const Text('Delete'),
                          )
                        ],
                      )
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
