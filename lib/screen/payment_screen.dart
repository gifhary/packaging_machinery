import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:intl/intl.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/constant/storage_constant.dart';
import 'package:packaging_machinery/model/address.dart';
import 'package:packaging_machinery/model/delivery_note.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/payment_proof.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:html' as html; //ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js; // ignore: avoid_web_libraries_in_flutter

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final db = FirebaseDatabase.instance.reference();

  final Item _item = Item.fromMap(Get.arguments['item']);
  final DeliveryNote _note = Get.arguments['note'] as DeliveryNote;

  final TextEditingController _paymentDate = TextEditingController();

  Uint8List imageFile = Uint8List(0);
  ScreenshotController screenshotController = ScreenshotController();
  late User _user;

  PaymentProof? _proof;

  bool _loading = true;

  final cur = NumberFormat("#,##0.00", "en_US");
  double _total = 0;

  @override
  void initState() {
    _getLocalUserData();
    if (_item.orderData.confirmedBySales) _calculateTotal();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _getPaymentProofStatus());
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

  _getPaymentProofStatus() {
    final paymentProof = db.child(DbConstant.paymentProof);
    paymentProof
        .child(getMd5(_user.email) + '/' + _item.orderId)
        .get()
        .then((value) {
      if (value.exists) {
        _proof = PaymentProof.fromMap(value.value);
        debugPrint(value.value.toString());
      }
      _loading = false;
      setState(() {});
    });
  }

  _getLocalUserData() {
    GetStorage box = GetStorage();
    var data = box.read('user');
    if (data == null) return;
    _user = User.fromJson(data);
  }

  _getPaymentProof() {
    ImagePickerWeb.getImage(outputType: ImageType.bytes).then((value) {
      if (value != null) imageFile = value as Uint8List;
      setState(() {});
    });
  }

  _uploadPaymentProof() async {
    final storage = FirebaseStorage.instance.ref(
        '${StorageConstant.paymentProof}${_paymentDate.text}${_item.orderId}.png');

    TaskSnapshot uploadTask = await storage.putData(
        imageFile, SettableMetadata(contentType: 'image/png'));

    uploadTask.ref
        .getDownloadURL()
        .then((url) => _savePaymentProof(url, _paymentDate.text));
  }

  _savePaymentProof(String imgUrl, date) {
    final paymentProof = db.child(DbConstant.paymentProof);
    paymentProof.child(getMd5(_user.email)).update({
      _item.orderId: PaymentProof(imgUrl: imgUrl, paymentDate: date).toMap()
    }).then((value) {
      Get.defaultDialog(
          titleStyle: const TextStyle(color: Color.fromRGBO(117, 111, 99, 1)),
          title: "Success",
          middleText: "Payment proof has been uploaded!",
          onConfirm: Get.back,
          buttonColor: const Color.fromRGBO(117, 111, 99, 1),
          confirmTextColor: Colors.white,
          textConfirm: 'OK');
      setState(() {
        _proof = PaymentProof(imgUrl: imgUrl, paymentDate: date);
      });
    });
  }

  _downloadProofForm() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        js.context.callMethod("saveAs", [
          html.Blob([image]),
          'payment${_item.orderId}.png'
        ]);
      }
    });
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
              child: _loading
                  ? Container(
                      color: Colors.white,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  : SingleChildScrollView(
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
                                    'Payment ',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'Order: PP${_item.orderId}',
                                    style: TextStyle(fontSize: 30),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20),
                              Text(_user.userDetail!.company ?? ''),
                              SizedBox(
                                  width: 250,
                                  child: Text(
                                      _getAddress(_user.userDetail!.address))),
                              Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
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
                                      SizedBox(width: 20),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(getMd5(_user.email)),
                                          SizedBox(height: 5),
                                          Text(_note.refNo),
                                          SizedBox(height: 5),
                                          Text(_note.rnNo)
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                'Total',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                'PPN 10%',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 20),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(cur.format(_total)),
                                              SizedBox(height: 10),
                                              Text(cur.format(_total * 0.1)),
                                            ],
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                          width: 200,
                                          child: Divider(
                                              color: Color.fromRGBO(
                                                  160, 152, 128, 1))),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            'BALANCE DUE',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(width: 20),
                                          Text(
                                            cur.format((_total * 0.1) + _total),
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 50),
                              Container(
                                height: 300,
                                width: double.infinity,
                                color: Colors.grey.withOpacity(0.5),
                                child: InkWell(
                                  onTap:
                                      _proof == null ? _getPaymentProof : null,
                                  child: imageFile.isNotEmpty
                                      ? Image.memory(
                                          imageFile,
                                          fit: BoxFit.cover,
                                        )
                                      : _proof?.imgUrl.isNotEmpty ?? false
                                          ? Image.network(
                                              _proof!.imgUrl,
                                              fit: BoxFit.cover,
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.upload_file),
                                                Text(
                                                  'upload payment proof',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                ),
                              ),
                              SizedBox(height: 50),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('Date of Payment: '),
                                            SizedBox(width: 10),
                                            _proof != null
                                                ? Text(
                                                    '${_proof!.paymentDate}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  )
                                                : Flexible(
                                                    child: TextField(
                                                      onChanged: (value) {
                                                        setState(() {});
                                                      },
                                                      controller: _paymentDate,
                                                      decoration:
                                                          InputDecoration(
                                                        focusedBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          117,
                                                                          111,
                                                                          99,
                                                                          1),
                                                                  width: 1),
                                                        ),
                                                        enabledBorder:
                                                            const OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Color
                                                                      .fromRGBO(
                                                                          117,
                                                                          111,
                                                                          99,
                                                                          1),
                                                                  width: 1),
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                        SizedBox(height: 20),
                                        _proof != null
                                            ? Container()
                                            : SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary:
                                                        const Color.fromRGBO(
                                                            160, 152, 128, 1),
                                                  ),
                                                  onPressed: _paymentDate.text
                                                              .isNotEmpty &&
                                                          imageFile.isNotEmpty
                                                      ? _uploadPaymentProof
                                                      : null,
                                                  child: const Text('Submit'),
                                                ),
                                              ),
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
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: _downloadProofForm,
                                    child: Text(
                                      'Download',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 50)
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
                  '??2022 by Samantha Tiara W. Master\'s Thesis Project - EM.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}
