import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/model/address.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/order_data.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/route/route_constant.dart';
import 'package:packaging_machinery/widget/machine_table.dart';

class QuotationOrderScreen extends StatefulWidget {
  const QuotationOrderScreen({Key? key}) : super(key: key);

  @override
  State<QuotationOrderScreen> createState() => _QuotationOrderScreenState();
}

class _QuotationOrderScreenState extends State<QuotationOrderScreen> {
  final Item _item = Item.fromMap(Get.arguments);
  final TextEditingController approverController = TextEditingController();
  late User _user;
  final db = FirebaseDatabase.instance.reference();
  late DatabaseReference order;
  late DatabaseReference cancelledOrder;

  @override
  void initState() {
    _getLocalUserData();
    order = db.child(DbConstant.order);
    cancelledOrder = db.child(DbConstant.cancelledOrder);
    super.initState();
  }

  _getLocalUserData() {
    GetStorage box = GetStorage();
    var data = box.read('user');
    if (data == null) return;
    _user = User.fromJson(data);
    approverController.text = _user.userDetail!.name;
  }

  _cancelOrder(String orderId, OrderData data) {
    cancelledOrder
        .child('${getMd5(_user.email)}/$orderId')
        .set(data.toMap())
        .then((value) {
      _deleteOrder(orderId);
    });
  }

  _deleteOrder(String orderId) {
    order.child('${getMd5(_user.email)}/$orderId').remove().then((value) {
      debugPrint('order cancelled');
    });
  }

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
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
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
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
            height: double.infinity,
            width: _width * 0.75,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Row(
                      children: [
                        Text(
                          'Quotation ',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Order: ${_item.orderId} ',
                          style: TextStyle(fontSize: 30),
                        ),
                        !_item.orderData.confirmedBySales
                            ? Text(
                                '(waiting for confirmation)',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              )
                            : Container()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('PO Title: hehe'),
                    ),
                    //section 1
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(160, 152, 128, 1))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Purchase Order',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      color: const Color.fromRGBO(160, 152, 128, 0.16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Invoice Bill To',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 100),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(_user.userDetail!.company ?? ''),
                              SizedBox(
                                width: 300,
                                child: Text(
                                  _getAddress(
                                      _user.userDetail!.invoiceBillAddress!),
                                  style: TextStyle(height: 1.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(150),
                            1: FixedColumnWidth(300),
                          },
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Buyer',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child:
                                    Text(_user.userDetail!.name.toUpperCase()),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Order Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(_item.orderData.orderTime),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Delivery Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _item.orderData.confirmedBySales
                                      ? DateUtils.dateOnly(DateTime.now())
                                          .toString()
                                      : '(waiting for confirmation)',
                                  style: TextStyle(
                                      color: _item.orderData.confirmedBySales
                                          ? Colors.black
                                          : Colors.grey),
                                ),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Goods Ship To',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(_getAddress(
                                    _user.userDetail!.deliveryAddress)),
                              )
                            ]),
                          ],
                        ),
                        Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(150),
                            1: FixedColumnWidth(300),
                          },
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Supplier',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'KHS PACKAGING MACHINERY INDONESIA, PT'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Address',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'JL YOS SUDARSO KAV 30 SUNTER THE PRIME - OFFICE'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Telephone',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('0210000'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Fax No.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('0210000'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Invoice Sent To',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(_user.userDetail!.company ?? ''),
                                      Text(_getAddress(_user.userDetail!
                                          .invoiceBillingSettlementAddress!)),
                                    ],
                                  ))
                            ]),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(160, 152, 128, 1))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Part Line Items',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    for (String key in _item.orderData.machineList.keys)
                      MachineTable(
                          machineData: _item.orderData.machineList[key]!),
                    const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Currency',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Indonesia Rupiah (IDR)'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('36000000'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 450,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Approver*',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    controller: approverController,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(117, 111, 99, 1),
                                            width: 1),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(117, 111, 99, 1),
                                            width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Payment Terms',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('YI45'),
                                  ],
                                ),
                                const Divider(
                                    color: Color.fromRGBO(160, 152, 128, 1)),
                                Text('45 days from Invoice Receipt'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(160, 152, 128, 1),
                          ),
                          onPressed:
                              _item.orderData.confirmedBySales ? () {} : null,
                          child: const Text('Approve'),
                        ),
                        const SizedBox(width: 30),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              primary: const Color.fromRGBO(160, 152, 128, 1)),
                          onPressed: () {
                            _cancelOrder(_item.orderId, _item.orderData);
                            Get.offAllNamed(RouteConstant.home);
                          },
                          child: const Text('Cancel Order'),
                        )
                      ],
                    ),
                    Visibility(
                      visible: !_item.orderData.confirmedBySales,
                      child: Text(
                        'waiting for confirmation before approving',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
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
        ],
      ),
    );
  }
}
