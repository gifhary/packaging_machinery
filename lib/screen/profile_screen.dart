import 'package:flutter/material.dart';
import 'package:packaging_machinery/widget/app_bar.dart';
import 'package:packaging_machinery/widget/profile/my_account_tab.dart';
import 'package:packaging_machinery/widget/profile/my_archive_tab.dart';
import 'package:packaging_machinery/widget/profile/my_booking_tab.dart';

enum ProfilePage { wallet, booking, archive, account }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return DefaultTabController(
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
          alignment: AlignmentDirectional.center,
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
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: _width * 0.8,
                    child: Column(
                      children: [
                        Container(
                          color: const Color.fromRGBO(117, 111, 99, 1),
                          height: 150,
                        ),
                        const ColoredBox(
                          color: Colors.white,
                          child: TabBar(
                            labelColor: Colors.black,
                            indicatorColor: Color.fromRGBO(117, 111, 99, 1),
                            tabs: [
                              Tab(child: Text('My Bookings')),
                              Tab(child: Text('My Archive')),
                              Tab(child: Text('My Account')),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: _height,
                          child: const TabBarView(
                            children: [
                              MyBookingTab(),
                              MyArchiveTab(),
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
          ],
        ),
      ),
    );
  }
}
