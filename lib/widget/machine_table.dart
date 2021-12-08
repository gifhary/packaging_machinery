import 'package:flutter/material.dart';
import 'package:packaging_machinery/model/order_data.dart';

class MachineTable extends StatelessWidget {
  final MachineData machineData;

  const MachineTable({Key? key, required this.machineData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                'Item',
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
                'QTY',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Contract Discount %',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Unit Price\nTotal Tax Amount\nTotal Extra Charges',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            DataColumn(
              label: Text(
                'Total',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ], rows: [
            for (String key in machineData.partRequest.keys)
              DataRow(
                cells: <DataCell>[
                  DataCell(Text(machineData.partRequest[key]!.itemName)),
                  DataCell(Text(machineData.partRequest[key]!.partNumber)),
                  DataCell(
                      Text(machineData.partRequest[key]!.quantity.toString())),
                  DataCell(Text('0.00')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
          ]),
        ],
      ),
    );
  }
}