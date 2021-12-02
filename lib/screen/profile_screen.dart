import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/order_data.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/widget/app_bar.dart';
import 'package:packaging_machinery/widget/profile/my_account_tab.dart';
import 'package:packaging_machinery/widget/profile/my_booking_tab.dart';
import 'package:packaging_machinery/widget/profile/my_order_tab.dart';

enum ProfilePage { wallet, booking, archive, account }

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final db = FirebaseDatabase.instance.reference();
  late DatabaseReference booking;
  late DatabaseReference order;

  GetStorage box = GetStorage();
  late String _data;
  late User _user;

  List<Item> _bookingItem = [];
  List<Item> _orderItem = [];

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  void initState() {
    _data = box.read('user');
    _user = User.fromJson(_data);

    booking = db.child(DbConstant.booking);
    order = db.child(DbConstant.order);

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _getBookingList();
      _getOrderList();
    });
    super.initState();
  }

  _getBookingList() {
    booking.child(getMd5(_user.email)).get().then((value) {
      value.value.forEach((key, val) => _bookingItem
          .add(Item(orderId: key, orderData: OrderData.fromMap(val))));
      setState(() {});
    });
  }

  _getOrderList() {
    order.child(getMd5(_user.email)).get().then((value) {
      value.value.forEach((key, val) => _orderItem
          .add(Item(orderId: key, orderData: OrderData.fromMap(val))));
      setState(() {});
    });
  }

  _submitBookingToOrder(String bookingId, OrderData data) {
    order
        .child('${getMd5(_user.email)}/$bookingId')
        .set(data.toMap())
        .then((value) {
      _deleteBooking(bookingId);
    });
  }

  _deleteBooking(String bookingId) {
    booking.child('${getMd5(_user.email)}/$bookingId').remove().then((value) {
      setState(() {
        _orderItem.add(_bookingItem
            .where((element) => element.orderId == bookingId)
            .first);
        _bookingItem.removeWhere((element) => element.orderId == bookingId);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    int tab = Get.arguments ?? 0;

    return DefaultTabController(
      initialIndex: tab,
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
            title: const AppBarWidget(),
          ),
        ),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Image.asset(
              'assets/img/banner_1.png',
              height: _height,
              fit: BoxFit.cover,
            ),
            Container(
              height: _height,
              width: double.infinity,
              color: const Color.fromRGBO(0, 0, 0, 0.6),
            ),
            SizedBox(
              width: _width * 0.8,
              height: _height,
              child: Column(
                children: [
                  Container(
                    color: const Color.fromRGBO(117, 111, 99, 1),
                    height: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/img/logo.png',
                                height: 100,
                                width: 204,
                                fit: BoxFit.cover,
                              ),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'User Name',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    'Customer/Admin',
                                    style: TextStyle(color: Colors.white),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const ColoredBox(
                    color: Colors.white,
                    child: TabBar(
                      labelColor: Colors.black,
                      indicatorColor: Color.fromRGBO(117, 111, 99, 1),
                      tabs: [
                        Tab(child: Text('My Order')),
                        Tab(child: Text('My Booking')),
                        Tab(child: Text('My Account')),
                      ],
                    ),
                  ),
                  Container(
                    height: 0.5,
                    width: double.infinity,
                    color: const Color.fromRGBO(117, 111, 99, 0.5),
                  ),
                  Flexible(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        MyOrderTab(item: _orderItem),
                        MyBookingTab(
                          item: _bookingItem,
                          onSubmit: _submitBookingToOrder,
                          onDelete: _deleteBooking,
                          onTap: (s) {},
                        ),
                        const MyAccountTab(),
                      ],
                    ),
                  )
                ],
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
      ),
    );
  }
}
