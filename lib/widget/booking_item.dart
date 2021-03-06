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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                                  primary:
                                      const Color.fromRGBO(160, 152, 128, 1),
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
                    Text('Date created: ${item.orderData.orderTime}'),
                  ],
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: _width * 0.4,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Item', style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 10),
                          for (String key in item.orderData.machineList.keys)
                            for (String k in item
                                .orderData.machineList[key]!.partRequest.keys)
                              Text(
                                item.orderData.machineList[key]!.partRequest[k]!
                                    .itemName,
                                style: TextStyle(fontSize: 11),
                              ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Item Number',
                              style: TextStyle(color: Colors.grey)),
                          SizedBox(height: 10),
                          for (String key in item.orderData.machineList.keys)
                            for (String k in item
                                .orderData.machineList[key]!.partRequest.keys)
                              Text(
                                item.orderData.machineList[key]!.partRequest[k]!
                                    .partNumber,
                                style: TextStyle(fontSize: 11),
                              ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quantity',
                            style: TextStyle(color: Colors.grey),
                          ),
                          SizedBox(height: 11),
                          for (String key in item.orderData.machineList.keys)
                            for (String k in item
                                .orderData.machineList[key]!.partRequest.keys)
                              Text(
                                item.orderData.machineList[key]!.partRequest[k]!
                                    .quantity
                                    .toString(),
                                style: TextStyle(fontSize: 11),
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
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
