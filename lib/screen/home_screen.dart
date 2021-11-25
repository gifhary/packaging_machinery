import 'package:flutter/material.dart';
import 'package:packaging_machinery/utils/texts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
            Padding(
              padding: const EdgeInsets.all(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/img/banner_6.png'),
                  Column(
                    children: [
                      const Text(
                        'Sustainable',
                        style: TextStyle(
                            fontSize: 40,
                            color: Color.fromRGBO(117, 111, 99, 1)),
                      ),
                      const Text(
                        'BIODEGRADABLE PET & GLASS CONTAINER',
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
                          Texts.sustainable,
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
            //contact me
            Container(
              padding: const EdgeInsets.all(50),
              width: double.infinity,
              color: const Color.fromRGBO(244, 243, 242, 1),
              child: Column(
                children: [
                  const Text('Contact Me',
                      style: TextStyle(
                          fontSize: 40,
                          color: Color.fromRGBO(117, 111, 99, 1))),
                  const SizedBox(height: 30),
                  const Text(
                    'PHONE: +49 40 67907 0 / FAX: +49 40 67907 270',
                    style: TextStyle(
                        fontSize: 15, color: Color.fromRGBO(117, 111, 99, 1)),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    color: const Color.fromRGBO(117, 111, 99, 1),
                    width: 125,
                    height: 1,
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'KHS GmbH - Site Hamburg',
                    style: TextStyle(
                      color: Color.fromRGBO(117, 111, 99, 1),
                    ),
                  ),
                  const Text(
                    'Meiendorfer Strasse 203',
                    style: TextStyle(
                      color: Color.fromRGBO(117, 111, 99, 1),
                    ),
                  ),
                  const Text(
                    '22145 Hamburg',
                    style: TextStyle(
                      color: Color.fromRGBO(117, 111, 99, 1),
                    ),
                  ),
                  const Text(
                    'Germany',
                    style: TextStyle(
                      color: Color.fromRGBO(117, 111, 99, 1),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 9),
                              child: Text('Enter Your Name*'),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                hintText: 'Name',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 9),
                              child: Text('Enter Your Email*'),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                hintText: 'Email',
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 9),
                              child: Text('Enter Your Subject*'),
                            ),
                            TextField(
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                hintText: 'Subject',
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 20),
                      SizedBox(
                        width: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Text('Enter Your Message*'),
                            ),
                            TextField(
                              maxLines: 10,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Color.fromRGBO(117, 111, 99, 1),
                                      width: 1),
                                ),
                                hintText: 'Message',
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
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
