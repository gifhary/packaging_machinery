import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/model/delivery_note.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/staff.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/route/route_constant.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderItem extends StatefulWidget {
  final Item item;
  final Function(Item) onTap;

  const OrderItem({Key? key, required this.item, required this.onTap})
      : super(key: key);

  @override
  State<OrderItem> createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _deliveryNoteSubmitted = false;

  final db = FirebaseDatabase.instance.reference();

  late User _user;
  String _status = '';

  late Staff _director, _salesAdmin, _salesManager;

  late DeliveryNote _note;

  @override
  void initState() {
    _getStatus();
    _getLocalUserData();
    _getStaff();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _getDeliveryNoteStatus());
    super.initState();
  }

  _getDeliveryNoteStatus() {
    final deliveryNote = db.child(DbConstant.deliveryNote);
    deliveryNote
        .child(getMd5(_user.email) + '/' + widget.item.orderId)
        .get()
        .then((value) {
      if (value.exists) {
        _note = DeliveryNote.fromMap(value.value);
        setState(() {
          _deliveryNoteSubmitted = true;
        });
        _getPaymentProofStatus();
      }
    });
  }

  _getStaff() {
    final staff = db.child(DbConstant.staff);
    staff.get().then((value) {
      if (value.exists) {
        debugPrint('staff: ' + value.value.toString());

        _director = Staff.fromMap(value.value['director']);
        _salesAdmin = Staff.fromMap(value.value['salesAdmin']);
        _salesManager = Staff.fromMap(value.value['salesManager']);
      }
    });
  }

  _getPaymentProofStatus() {
    final paymentProof = db.child(DbConstant.paymentProof);
    paymentProof
        .child(getMd5(_user.email) + '/' + widget.item.orderId)
        .get()
        .then((value) {
      if (value.exists) {
        setState(() {
          //order complete when delivery note and payment proof submitted
          _status = 'Completed';
        });
      }
    });
  }

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  _getLocalUserData() {
    GetStorage box = GetStorage();
    var data = box.read('user');
    if (data == null) return;
    _user = User.fromJson(data);
  }

  _getStatus() {
    if (!widget.item.orderData.delivered) {
      if (widget.item.orderData.confirmedBySales &&
          widget.item.orderData.approvedByCustomer) {
        _status = 'Waiting for delivery';
      } else if (widget.item.orderData.confirmedBySales &&
          !widget.item.orderData.approvedByCustomer) {
        _status = 'Waiting for approval';
      } else if (!widget.item.orderData.confirmedBySales &&
          !widget.item.orderData.approvedByCustomer) {
        _status = 'On process';
      }
    } else {
      _status = 'Delivered';
    }
  }

  int daysBetween() {
    DateTime from =
        DateTime.parse(widget.item.orderData.deliveryNoteConfirmedDate!);
    DateTime to = DateTime.now();

    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  _onTap() {
    widget.onTap(widget.item);
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        InkWell(
          onTap: _onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: _width * 0.5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: _width * 0.25,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.item.orderData.orderTitle,
                              style: const TextStyle(
                                  fontSize: 25,
                                  color: Color.fromRGBO(117, 111, 99, 1)),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              widget.item.orderData.approvedByCustomer &&
                                      widget.item.orderData.confirmedBySales
                                  ? 'Order: KHS${widget.item.orderId}'
                                  : 'Order: QO${widget.item.orderId}',
                            ),
                            Text('Status: $_status'),
                            Visibility(
                                visible: widget.item.orderData.trackingNumber !=
                                    null,
                                child: Row(
                                  children: [
                                    Text('Tracking number: '),
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color.fromRGBO(
                                                  222, 222, 222, 1))),
                                      child: Text(widget
                                              .item.orderData.trackingNumber ??
                                          ''),
                                    )
                                  ],
                                )),
                            Visibility(
                                visible:
                                    widget.item.orderData.trackingUrl != null,
                                child: Row(
                                  children: [
                                    Text('Tracking website: '),
                                    InkWell(
                                      onTap: () async {
                                        if (!await launch(
                                            widget.item.orderData.trackingUrl ??
                                                '')) {
                                          Fluttertoast.showToast(
                                              msg:
                                                  "Error: could not launch ${widget.item.orderData.trackingUrl}",
                                              toastLength: Toast.LENGTH_LONG,
                                              gravity: ToastGravity.CENTER,
                                              timeInSecForIosWeb: 3,
                                              backgroundColor: Colors.grey,
                                              textColor: Colors.white,
                                              fontSize: 16.0);
                                        }
                                      },
                                      child: Text(
                                        widget.item.orderData.trackingUrl ?? '',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    )
                                  ],
                                )),
                            widget.item.orderData.deliveryNoteConfirmedDate ==
                                    null
                                ? Container()
                                : Text(
                                    'Due payment in ${45 - daysBetween()} days',
                                    style: TextStyle(
                                        color: 45 - daysBetween() < 3
                                            ? Colors.red
                                            : Colors.black),
                                  ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: widget.item.orderData.delivered,
                        child: Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary:
                                      const Color.fromRGBO(160, 152, 128, 1),
                                ),
                                onPressed: !_deliveryNoteSubmitted
                                    ? null
                                    : () => Get.toNamed(RouteConstant.invoice,
                                            arguments: {
                                              'item': widget.item.toMap(),
                                              'director': _director,
                                              'salesManager': _salesManager,
                                              'note': _note
                                            }),
                                child: const Text('Invoice'),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(160, 152, 128, 1)),
                                onPressed: () => Get.toNamed(
                                    RouteConstant.deliveryNote,
                                    arguments: {
                                      'item': widget.item.toMap(),
                                      'salesAdmin': _salesAdmin,
                                    }),
                                child: const Text('Delivery Note'),
                              ),
                              OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(160, 152, 128, 1)),
                                onPressed: !_deliveryNoteSubmitted
                                    ? null
                                    : () => Get.toNamed(RouteConstant.payment,
                                            arguments: {
                                              'item': widget.item.toMap(),
                                              'note': _note
                                            }),
                                child: const Text('Payment'),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Text('Date created: ${widget.item.orderData.orderTime}'),
              ],
            ),
          ),
        ),
        Container(
          height: 0.5,
          width: double.infinity,
          color: const Color.fromRGBO(117, 111, 99, 0.5),
        ),
      ],
    );
  }
}
