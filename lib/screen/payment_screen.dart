import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:screenshot/screenshot.dart';
import 'dart:html' as html; //ignore: avoid_web_libraries_in_flutter
import 'dart:js' as js; // ignore: avoid_web_libraries_in_flutter

class PaymentScreen extends StatefulWidget {
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final Item _item = Item.fromMap(Get.arguments);

  Uint8List imageFile = Uint8List(0);
  ScreenshotController screenshotController = ScreenshotController();

  _uploadPaymenProof() {
    ImagePickerWeb.getImage(outputType: ImageType.bytes).then((value) {
      if (value != null) imageFile = value as Uint8List;
      setState(() {});
    });
  }

  _downloadProofForm() async {
    await screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((image) async {
      if (image != null) {
        js.context.callMethod("saveAs", [
          html.Blob([image]),
          'payment-proof-form${_item.orderId}.png'
        ]);
      }
    });
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
                              'Delivery Note ',
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Order: id',
                              style: TextStyle(fontSize: 30),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text('PT Coca-Cola Bottling Indonesia'),
                        Text('South Quarter Tower C Lantai 22 (PH)'),
                        Text('Jl. RA Kartini Kav. 8'),
                        Text('Jakarta Utara'),
                        Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('fwaefe'),
                                    SizedBox(height: 5),
                                    Text('21/129'),
                                    SizedBox(height: 5),
                                    Text('2')
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          'Total',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(height: 10),
                                        Text(
                                          'PPN 10%',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 20),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('18,000,000'),
                                        SizedBox(height: 10),
                                        Text('1,800,000'),
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                    width: 200,
                                    child: Divider(
                                        color:
                                            Color.fromRGBO(160, 152, 128, 1))),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'BALANCE DUE',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 20),
                                    Text(
                                      '19,800,000',
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
                            onTap: _uploadPaymenProof,
                            child: imageFile.isNotEmpty
                                ? Image.memory(
                                    imageFile,
                                    fit: BoxFit.cover,
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.upload_file),
                                      Text(
                                        'upload payment proof',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                        SizedBox(height: 50),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 300,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text('Date of Payment'),
                                      SizedBox(width: 10),
                                      Flexible(
                                        child: TextField(
                                          decoration: InputDecoration(
                                            focusedBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      117, 111, 99, 1),
                                                  width: 1),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Color.fromRGBO(
                                                      117, 111, 99, 1),
                                                  width: 1),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: const Color.fromRGBO(
                                            160, 152, 128, 1),
                                      ),
                                      onPressed: () {},
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
                  '©2022 by Samantha Tiara W. Master\'s Thesis Project - EM.',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ));
  }
}