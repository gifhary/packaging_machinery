import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:packaging_machinery/model/order_data.dart';

class MachineTableInvoice extends StatelessWidget {
  final MachineData machineData;

  const MachineTableInvoice({Key? key, required this.machineData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cur = NumberFormat("#,##0.00", "en_US");

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            color: const Color.fromRGBO(160, 152, 128, 0.16),
            child: Column(
              children: [
                Text(
                  'Machine Type: ${machineData.machineType}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: const Color.fromRGBO(117, 111, 99, 1),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  height: 3,
                  width: 500,
                  color: Colors.white,
                )
              ],
            ),
          ),
          DataTable(columns: [
            DataColumn(
              label: Text(
                'QTY',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Part Number',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Item',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Price (IDR)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Total (IDR)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ], rows: [
            for (String key in machineData.partRequest.keys)
              DataRow(
                cells: <DataCell>[
                  DataCell(
                      Text(machineData.partRequest[key]!.quantity.toString())),
                  DataCell(Text(machineData.partRequest[key]!.partNumber)),
                  DataCell(Text(machineData.partRequest[key]!.itemName)),
                  DataCell(Text(
                      cur.format(machineData.partRequest[key]!.price ?? 0))),
                  DataCell(
                    Text(cur.format(
                        ((machineData.partRequest[key]?.price ?? 0) *
                            machineData.partRequest[key]!.quantity))),
                  ),
                ],
              ),
          ]),
        ],
      ),
    );
  }
}
