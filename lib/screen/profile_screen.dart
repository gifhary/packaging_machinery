import 'package:flutter/material.dart';
import 'package:packaging_machinery/widget/app_bar.dart';

enum ProfilePage { wallet, booking, archive, account }

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
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
                  height: _height,
                  width: _width * 0.8,
                  child: Column(
                    children: [
                      Container(
                        color: const Color.fromRGBO(117, 111, 99, 1),
                        height: 150,
                      ),
                      Expanded(
                          child: Container(
                        color: Colors.white,
                      )),
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
    );
  }
}
