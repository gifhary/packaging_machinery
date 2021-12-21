import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:packaging_machinery/model/address.dart';
import 'package:packaging_machinery/model/delivery_note.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/staff.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/route/route_constant.dart';
import 'package:packaging_machinery/widget/machine_table_invoice.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:html' as html; //ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js; // ignore: avoid_web_libraries_in_flutter

class InvoiceScreen extends StatefulWidget {
  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
  final Item _item = Item.fromMap(Get.arguments['item']);
  final Staff _salesManager = Get.arguments['salesManager'] as Staff;
  final Staff _director = Get.arguments['director'] as Staff;
  final DeliveryNote _note = Get.arguments['note'] as DeliveryNote;

  late User _user;
  ScreenshotController screenshotController = ScreenshotController();

  final cur = NumberFormat("#,##0.00", "en_US");
  double _total = 0;

  @override
  void initState() {
    _getLocalUserData();
    if (_item.orderData.confirmedBySales) _calculateTotal();
    super.initState();
  }

  _calculateTotal() {
    for (String i in _item.orderData.machineList.keys) {
      for (String j in _item.orderData.machineList[i]!.partRequest.keys) {
        _total += (_item.orderData.machineList[i]!.partRequest[j]!.quantity *
            (_item.orderData.machineList[i]!.partRequest[j]!.price ?? 0));
      }
    }
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

  _downloadInvoice() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        js.context.callMethod("saveAs", [
          html.Blob([image]),
          'invoice${_item.orderId}.png'
        ]);
      }
    });
  }

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
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
          SizedBox(
            height: double.infinity,
            width: _width * 0.75,
            child: SingleChildScrollView(
              child: Screenshot(
                controller: screenshotController,
                child: Container(
                  padding: EdgeInsets.all(30),
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Invoice ',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
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
                                  _user.userDetail!.company ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  _getAddress(
                                      _user.userDetail!.deliveryAddress),
                                  style: TextStyle(height: 1.5),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text('ATTENTION: '),
                                    Text(
                                      'BILLING STATEMENT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 350,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('Customer Id',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('Ref No.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('RN No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(_note.date),
                                    SizedBox(height: 5),
                                    Text(getMd5(_user.email)),
                                    SizedBox(height: 5),
                                    Text(_note.refNo),
                                    SizedBox(height: 5),
                                    Text(_note.rnNo)
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      for (String key in _item.orderData.machineList.keys)
                        MachineTableInvoice(
                            machineData: _item.orderData.machineList[key]!),
                      const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'PPN 10%',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(cur.format(_total)),
                              SizedBox(height: 10),
                              Text(cur.format(_total * 0.1)),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                              width: 200,
                              child: Divider(
                                  color: Color.fromRGBO(160, 152, 128, 1))),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'BALANCE DUE',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(width: 20),
                          Text(
                            cur.format((_total * 0.1) + _total),
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                      SizedBox(height: 15),
                      Text('Remarks,',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 600,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: 100,
                                          fit: BoxFit.contain,
                                          imageUrl: _director.signature,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(15),
                                          width: 150,
                                          height: 2,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          _director.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        CachedNetworkImage(
                                          height: 100,
                                          fit: BoxFit.contain,
                                          imageUrl: _salesManager.signature,
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                        Container(
                                          margin: EdgeInsets.all(15),
                                          width: 150,
                                          height: 2,
                                          color: Colors.black,
                                        ),
                                        Text(
                                          _salesManager.name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Text('KHS Packaging Machinery Indonesia')
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'To be paid to',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                'PT KHS Packaging Machinery Indonesia',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                'DEUTSCHE BANK AG, Jakarta Branch',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                'IDR Account No: 0024869.00.0',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                'EUR Account No: 0024869.01.0',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                'USD Account No: 0024869.05.0',
                                style: TextStyle(color: Colors.blue),
                              ),
                              Text(
                                'Swift code: DEUTIDJA',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () => Get.toNamed(RouteConstant.payment,
                                  arguments: {
                                    'item': _item.toMap(),
                                    'note': _note
                                  }),
                              child: Text(
                                'Upload Payment Proof',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            SizedBox(width: 20),
                            InkWell(
                              onTap: _downloadInvoice,
                              child: Text(
                                'Download',
                                style: TextStyle(
                                    color: Colors.grey,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 50),
                    ],
                  ),
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
