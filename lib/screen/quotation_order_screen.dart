import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packaging_machinery/model/item.dart';

class QuotationOrderScreen extends StatefulWidget {
  const QuotationOrderScreen({Key? key}) : super(key: key);

  @override
  State<QuotationOrderScreen> createState() => _QuotationOrderScreenState();
}

class _QuotationOrderScreenState extends State<QuotationOrderScreen> {
  //final Item _item = Item.fromMap(Get.arguments);
  final bool i = true;

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
            child: i
                ? const Center(
                    child: Text(
                        'Your order is still being processed, come back later ;)'))
                : SingleChildScrollView(
                    child: Column(
                      children: [],
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
