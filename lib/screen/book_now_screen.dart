import 'package:flutter/material.dart';
import 'package:packaging_machinery/widget/app_bar.dart';

class BookNowScreen extends StatelessWidget {
  const BookNowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
        title: const AppBarWidget(),
      ),
      body: Row(
        children: [
          Container(
            width: _width * 0.35,
            color: Colors.white,
          ),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(160, 152, 128, 0.16),
            ),
          )
        ],
      ),
    );
  }
}
