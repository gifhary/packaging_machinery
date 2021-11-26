import 'package:flutter/material.dart';
import 'package:packaging_machinery/utils/texts.dart';
import 'package:packaging_machinery/widget/app_bar.dart';

class BookOnlineScreen extends StatelessWidget {
  const BookOnlineScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
          title: const AppBarWidget()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  'assets/img/banner_1.png',
                  height: 400,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 400,
                  width: double.infinity,
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
                Container(
                  color: Colors.white,
                  width: _width * 0.7,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50, bottom: 30),
                        child: Text(
                          "Our Services",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: const Color.fromRGBO(222, 222, 222, 1))),
                        child: Column(
                          children: [
                            const Text('Spare Parts Order',
                                style: TextStyle(fontSize: 23)),
                            const Divider(
                                color: Color.fromRGBO(222, 222, 222, 1)),
                            Text(Texts.sparePartsOrder),
                            const SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(160, 152, 128, 1),
                                  ),
                                  onPressed: () {},
                                  child: const Text('BOOK NOW'),
                                ),
                                const SizedBox(width: 30),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      primary: const Color.fromRGBO(
                                          160, 152, 128, 1)),
                                  onPressed: () {},
                                  child: const Text('ORDER NOW'),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 50),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(222, 222, 222, 1))),
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Column(
                children: [
                  const Text(
                    'Maintenance Schedule',
                    style: TextStyle(fontSize: 30),
                  ),
                  Image.asset('assets/img/date.png'),
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
            )
          ],
        ),
      ),
    );
  }
}
