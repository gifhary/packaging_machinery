import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packaging_machinery/widget/app_bar.dart';
import 'package:packaging_machinery/widget/profile/my_account_tab.dart';
import 'package:packaging_machinery/widget/profile/my_booking_tab.dart';
import 'package:packaging_machinery/widget/profile/my_order_tab.dart';

enum ProfilePage { wallet, booking, archive, account }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
                  const Flexible(
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        MyOrderTab(),
                        MyBookingTab(),
                        MyAccountTab(),
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
