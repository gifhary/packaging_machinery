import 'package:flutter/material.dart';
import 'package:packaging_machinery/widget/app_bar.dart';

class BookOnlineScreen extends StatelessWidget {
  const BookOnlineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
          title: const AppBarWidget()),
    );
  }
}
