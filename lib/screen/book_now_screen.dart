import 'package:flutter/material.dart';
import 'package:packaging_machinery/model/order_request.dart';
import 'package:packaging_machinery/widget/app_bar.dart';
import 'package:packaging_machinery/widget/machine_input_group.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({Key? key}) : super(key: key);

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  bool _approveAfterConfirm = false;

  final OrderRequest _orderRequest = OrderRequest(
    orderTitle: TextEditingController(),
    machineList: [
      MachineRequest(machineType: TextEditingController(), partRequest: [
        PartRequest(
            partNumber: TextEditingController(),
            itemName: TextEditingController())
      ]),
    ],
  );

  _addMachine() {
    setState(() {
      _orderRequest.machineList.add(
        MachineRequest(machineType: TextEditingController(), partRequest: [
          PartRequest(
              partNumber: TextEditingController(),
              itemName: TextEditingController())
        ]),
      );
    });
  }

  _addPart() {
    setState(() {
      _orderRequest
          .machineList[_orderRequest.machineList.length - 1].partRequest
          .add(PartRequest(
              partNumber: TextEditingController(),
              itemName: TextEditingController()));
    });
  }

  Widget _machineGroup(MachineRequest machineRequest) {
    return Column(
      children: [
        MachineInputGroup(
            machineRequest: machineRequest, onAddMorePart: _addPart),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Divider(color: Colors.white),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
          title: const AppBarWidget(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: _width * 0.35,
                  color: Colors.white,
                ),
                Container(
                  padding: const EdgeInsets.all(100),
                  width: _width * 0.65,
                  color: const Color.fromRGBO(160, 152, 128, 0.16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'PO Title:',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      TextField(
                        controller: _orderRequest.orderTitle,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(117, 111, 99, 1),
                                width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromRGBO(117, 111, 99, 1),
                                width: 1),
                          ),
                          hintText: 'Enter order title',
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Divider(color: Colors.white),
                      ),
                      for (int i = 0; i < _orderRequest.machineList.length; i++)
                        _machineGroup(_orderRequest.machineList[i]),
                      InkWell(
                        onTap: _addMachine,
                        child: const Text(
                          'Add more machine+',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          children: [
                            Checkbox(
                                value: _approveAfterConfirm,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _approveAfterConfirm = value!;
                                  });
                                }),
                            const Text(
                              'Immediately approve after confirmation.',
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(160, 152, 128, 1),
                            ),
                            onPressed: () {},
                            child: const Text('Book Now'),
                          ),
                          const SizedBox(width: 30),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                primary:
                                    const Color.fromRGBO(160, 152, 128, 1)),
                            onPressed: () {},
                            child: const Text('Discard'),
                          )
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
            Container(
              color: const Color.fromRGBO(117, 111, 99, 1),
              width: double.infinity,
              height: 43,
              child: const Center(
                child: Text(
                  '©2022 by Samantha Tiara W. Master\'s Thesis Project - EM.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}