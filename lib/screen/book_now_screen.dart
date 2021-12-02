import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/model/order_data.dart';
import 'package:packaging_machinery/model/order_request.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/route/route_constant.dart';
import 'package:packaging_machinery/widget/app_bar.dart';
import 'package:packaging_machinery/widget/machine_input_group.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

class BookNowScreen extends StatefulWidget {
  const BookNowScreen({Key? key}) : super(key: key);

  @override
  State<BookNowScreen> createState() => _BookNowScreenState();
}

class _BookNowScreenState extends State<BookNowScreen> {
  final db = FirebaseDatabase.instance.reference();
  var uuid = const Uuid();

  late OrderRequest _orderRequest;
  OrderData _orderData = OrderData(machineList: {}, orderTitle: '');

  @override
  initState() {
    _orderRequest = OrderRequest(
      orderTitle: TextEditingController(),
      machineList: {
        uuid.v1():
            MachineRequest(machineType: TextEditingController(), partRequest: {
          uuid.v1(): PartRequest(
              partNumber: TextEditingController(),
              itemName: TextEditingController())
        }),
      },
    );
    super.initState();
  }

  _addMachine() {
    setState(() {
      _orderRequest.machineList.putIfAbsent(
          uuid.v1(),
          () => MachineRequest(
                  machineType: TextEditingController(),
                  partRequest: {
                    uuid.v1(): PartRequest(
                        partNumber: TextEditingController(),
                        itemName: TextEditingController())
                  }));
    });
  }

  _addPart(String key) {
    setState(() {
      _orderRequest.machineList[key]!.partRequest.putIfAbsent(
          uuid.v1(),
          () => PartRequest(
              partNumber: TextEditingController(),
              itemName: TextEditingController()));
    });
  }

  Widget _machineGroup(MachineRequest machineRequest, String key) {
    return Column(
      children: [
        MachineInputGroup(
            mapKey: key,
            machineRequest: machineRequest,
            onAddMorePart: _addPart),
        const Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Divider(color: Colors.white),
        ),
      ],
    );
  }

  _migrateReqToData() {
    //mampus ga ngerti
    _orderData = OrderData(
      orderTitle: _orderRequest.orderTitle.text,
      machineList: {
        for (String machineKey in _orderRequest.machineList.keys)
          machineKey: MachineData(
            machineType:
                _orderRequest.machineList[machineKey]!.machineType.text,
            partRequest: {
              for (String partKey
                  in _orderRequest.machineList[machineKey]!.partRequest.keys)
                partKey: PartData(
                  itemName: _orderRequest.machineList[machineKey]!
                      .partRequest[partKey]!.itemName.text,
                  partNumber: _orderRequest.machineList[machineKey]!
                      .partRequest[partKey]!.partNumber.text,
                ),
            },
          ),
      },
    );
  }

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    final booking = db.child(DbConstant.booking);
    double _width = MediaQuery.of(context).size.width;

    _bookNow() {
      GetStorage box = GetStorage();
      var data = box.read('user');
      User _user = User.fromJson(data);

      _migrateReqToData();
      booking
          .child(getMd5(_user.email))
          .push()
          .set(_orderData.toMap())
          .then((value) => Get.offNamed(
                RouteConstant.profile,
                arguments: 1,
              ));
    }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: _width * 0.35,
                  child: Column(
                    children: const [
                      SizedBox(height: 300),
                      Text(
                        'Spare Parts Order',
                        style: TextStyle(fontSize: 36),
                      ),
                      SizedBox(
                          width: 250,
                          child: Text(
                            'You can check your order in your account >> My Booking',
                            textAlign: TextAlign.center,
                          ))
                    ],
                  ),
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
                      for (String keys in _orderRequest.machineList.keys)
                        _machineGroup(_orderRequest.machineList[keys]!, keys),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        child: InkWell(
                          onTap: _addMachine,
                          child: const Text(
                            'Add more machine+',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: const Color.fromRGBO(160, 152, 128, 1),
                            ),
                            onPressed: _bookNow,
                            child: const Text('Book Now'),
                          ),
                          const SizedBox(width: 30),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                primary:
                                    const Color.fromRGBO(160, 152, 128, 1)),
                            onPressed: Get.back,
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
