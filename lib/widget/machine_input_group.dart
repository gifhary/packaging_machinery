import 'package:flutter/material.dart';
import 'package:packaging_machinery/model/order_request.dart';

class MachineInputGroup extends StatelessWidget {
  final MachineRequest machineRequest;
  final VoidCallback? onAddMorePart;

  const MachineInputGroup(
      {Key? key, required this.machineRequest, this.onAddMorePart})
      : super(key: key);

  Widget _machinePartWidget(PartRequest partRequest) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text('Parts Number:'),
              ),
              TextField(
                controller: partRequest.partNumber,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(117, 111, 99, 1), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(117, 111, 99, 1), width: 1),
                  ),
                  hintText: 'Enter spare part number',
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 20),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text('Item:'),
              ),
              TextField(
                controller: partRequest.itemName,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(117, 111, 99, 1), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(117, 111, 99, 1), width: 1),
                  ),
                  hintText: 'Enter spare part name',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Machine Type: '),
            Flexible(
              child: TextField(
                controller: machineRequest.machineType,
                decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(117, 111, 99, 1), width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromRGBO(117, 111, 99, 1), width: 1),
                  ),
                  hintText: 'Enter Machine Type',
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        for (int i = 0; i < machineRequest.partRequest.length; i++)
          _machinePartWidget(machineRequest.partRequest[i]),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: InkWell(
            onTap: onAddMorePart,
            child: const Text(
              'Add more parts+',
              style: TextStyle(
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        )
      ],
    );
  }
}
