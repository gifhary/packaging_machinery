import 'package:flutter/material.dart';
import 'package:packaging_machinery/utils/texts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //navigation bar
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: const Text('HOME'),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text('BOOK ONLINE'),
                ),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: const Text('CONTACT US'),
                ),
              ],
            ),
            InkWell(
              onTap: () {},
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/img/blank_profile.png'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text('Log In'),
                ],
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        //section 1
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
                Column(
                  children: [
                    const Text(
                      "- PACKAGING MACHINERY -",
                      style: TextStyle(color: Colors.white),
                    ),
                    const Text(
                      "Spare Parts",
                      style: TextStyle(fontSize: 100, color: Colors.white),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          '           &     ',
                          style: TextStyle(fontSize: 50, color: Colors.white),
                        ),
                        Text(
                          "Materials",
                          style: TextStyle(fontSize: 100, color: Colors.white),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () {},
                      child: const Text(
                        'BOOK ONLINE',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            //section 2
            Padding(
              padding: const EdgeInsets.all(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/img/banner_2.png'),
                  Column(
                    children: [
                      const Text(
                        'Your Reliable Partner',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(117, 111, 99, 1)),
                      ),
                      const Text(
                        'PROOF FILLINGS & PACKAGING SYSTEMS',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(117, 111, 99, 1)),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: const Color.fromRGBO(117, 111, 99, 1),
                        width: 125,
                        height: 1,
                      ),
                      const SizedBox(height: 45),
                      SizedBox(
                        width: 400,
                        child: Text(
                          Texts.reliable,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromRGBO(117, 111, 99, 1),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //section 3
            Image.asset(
              'assets/img/banner_3.png',
              height: 450,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            //section 4
            Padding(
              padding: const EdgeInsets.all(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        'Mission Statement',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(117, 111, 99, 1)),
                      ),
                      const Text(
                        'SUSTAINABLE TURNKEY SYSTEMS',
                        style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(117, 111, 99, 1)),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        color: const Color.fromRGBO(117, 111, 99, 1),
                        width: 125,
                        height: 1,
                      ),
                      const SizedBox(height: 45),
                      SizedBox(
                        width: 400,
                        child: Text(
                          Texts.mission,
                          maxLines: null,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color.fromRGBO(117, 111, 99, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/img/banner_4_1.png'),
                          const SizedBox(width: 15),
                          Image.asset('assets/img/banner_4_2.png'),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Image.asset('assets/img/banner_4_3.png'),
                          const SizedBox(width: 15),
                          Image.asset('assets/img/banner_4_4.png'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            //section 5
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  'assets/img/banner_5.png',
                  height: 600,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 600,
                  width: double.infinity,
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 700,
                      child: Text(
                        Texts.quotes,
                        textAlign: TextAlign.center,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 32),
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text(
                      '- Chief Executive Officer -',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
            //section 6
          ],
        ),
      ),
    );
  }
}
