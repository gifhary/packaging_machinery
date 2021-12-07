import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/model/address.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/widget/machine_table.dart';

class DeliveryNoteScreen extends StatefulWidget {
  @override
  State<DeliveryNoteScreen> createState() => _DeliveryNoteScreenState();
}

class _DeliveryNoteScreenState extends State<DeliveryNoteScreen> {
  final Item _item = Item.fromMap(Get.arguments);
  late User _user;

  @override
  void initState() {
    _getLocalUserData();
    super.initState();
  }

  _getLocalUserData() {
    GetStorage box = GetStorage();
    var data = box.read('user');
    if (data == null) return;
    _user = User.fromJson(data);
  }

  String _getAddress(Address address) {
    String str = '';
    debugPrint(address.toString());

    if (address.address1.isNotEmpty) {
      str += address.address1 + ', ';
    }
    if (address.address2?.isNotEmpty ?? false) {
      str += address.address2! + ', ';
    }
    if (address.street?.isNotEmpty ?? false) {
      str += address.street! + ', ';
    }
    if (address.city.isNotEmpty) {
      str += address.city + ', ';
    }
    if (address.zipcode.isNotEmpty) {
      str += address.zipcode + ', ';
    }
    if (address.country.isNotEmpty) {
      str += address.country + '.';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
        ),
      ),
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
        Image.asset(
          'assets/img/banner_1.png',
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: const Color.fromRGBO(0, 0, 0, 0.6),
        ),
        Container(
          padding: EdgeInsets.all(30),
          height: double.infinity,
          width: _width * 0.75,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Delivery Note ',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Order: ${_item.orderId}',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('PT KHS PACKAGING MACHINERY INDONESIA'),
                        Text('THE PRIME - Office Sunter, 3rd floor'),
                        Text('Jl. Yos Sudarso Kav. 30 Sunter Agun'),
                        Text('Jakarta Utara'),
                      ],
                    ),
                    Image.asset(
                      'assets/img/khs_logo.png',
                      width: 234,
                      height: 72,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
                const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PT Coca-Cola Bottling Indonesia',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 5),
                          Text(
                            _getAddress(_user.userDetail!.deliveryAddress),
                            style: TextStyle(height: 1.5),
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              Text('ATTENTION: '),
                              Text(
                                'SPAREPART DEPARTMENT',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 300,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Date',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text('Customer Id',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text('Ref No.',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(height: 5),
                              Text('Rn No',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(DateTime.now().toString()),
                              SizedBox(height: 5),
                              Text('d6fb7961400d219'),
                              SizedBox(height: 5),
                              Text('21/129'),
                              SizedBox(height: 5),
                              Text('2')
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20),
                for (String key in _item.orderData.machineList.keys)
                  MachineTable(machineData: _item.orderData.machineList[key]!),
                const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'RN',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Name',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(160, 152, 128, 1))),
                          child: Text('10982'),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(160, 152, 128, 1))),
                          child: Text(DateTime.now().toString()),
                        ),
                        SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:
                                      const Color.fromRGBO(160, 152, 128, 1))),
                          child: Text(_user.userDetail?.name ?? ''),
                        )
                      ],
                    )
                  ],
                ),
                const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                SizedBox(height: 15),
                Text('Remarks,', style: TextStyle(fontStyle: FontStyle.italic)),
                SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 300,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          width: 150,
                          height: 2,
                          color: Colors.black,
                        ),
                        Text(
                          'LEONI ANDRIYATI',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text('KHS Packaging Machinery Indonesia')
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 200,
                          width: 300,
                          color: Colors.grey,
                        ),
                        Container(
                          margin: EdgeInsets.all(15),
                          width: 150,
                          height: 2,
                          color: Colors.black,
                        ),
                        Text(
                          _user.userDetail?.name ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromRGBO(160, 152, 128, 1),
                      ),
                      onPressed: () {},
                      child: const Text('Submit'),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
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
      ]),
    );
  }
}
