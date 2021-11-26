import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:packaging_machinery/route/route_constant.dart';

class AppBarWidget extends StatelessWidget {
  final bool loggedIn;
  AppBarWidget({Key? key, required this.loggedIn}) : super(key: key);

  final List<String> _popupMenu = [
    'My Wallet',
    'My Bookings',
    'My Archive',
    'My Account',
    'Log Out'
  ];

  final GlobalKey _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    Future<void> _popUp() async {
      RenderBox _box = _key.currentContext!.findRenderObject() as RenderBox;
      Offset offset = _box.localToGlobal(Offset.zero);

      await showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
              offset.dx + _box.size.width,
              offset.dy + _box.size.height + 10,
              _width - 50 - (offset.dx + _box.size.width),
              _height - (offset.dy + _box.size.height)),
          items: _popupMenu
              .map((e) => PopupMenuItem<String>(
                    child: Text(e),
                  ))
              .toList());
    }

    return Row(
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
          key: _key,
          onTap: () {
            if (!loggedIn) {
              Get.toNamed(RouteConstant.login);
            } else {
              _popUp();
            }
          },
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
    );
  }
}
