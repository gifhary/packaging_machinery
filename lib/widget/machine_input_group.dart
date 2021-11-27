import 'package:flutter/material.dart';

class MachineInputGroup extends StatefulWidget {
  const MachineInputGroup({Key? key}) : super(key: key);

  @override
  State<MachineInputGroup> createState() => _MachineInputGroupState();
}

class _MachineInputGroupState extends State<MachineInputGroup> {
  int _partCount = 1;

  _addPart() {
    setState(() {
      _partCount++;
    });
  }

  Widget _machinePartWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text('Parts Number:'),
              ),
              TextField(
                decoration: InputDecoration(
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
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 9),
                child: Text('Item:'),
              ),
              TextField(
                decoration: InputDecoration(
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
          children: const [
            Text('Machine Type: '),
            Flexible(
              child: TextField(
                decoration: InputDecoration(
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
        for (int i = 0; i < _partCount; i++) _machinePartWidget(),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: InkWell(
            onTap: _addPart,
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
