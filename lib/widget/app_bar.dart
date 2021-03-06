import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/model/popup_item.dart';
import 'package:packaging_machinery/route/route_constant.dart';

class AppBarWidget extends StatefulWidget {
  final VoidCallback? onContactUs;
  const AppBarWidget({Key? key, this.onContactUs}) : super(key: key);

  @override
  State<AppBarWidget> createState() => _AppBarWidgetState();
}

class _AppBarWidgetState extends State<AppBarWidget> {
  final List<PopupItem> _popupMenu = [
    PopupItem(
        'My Order', () => Get.offNamed(RouteConstant.profile, arguments: 0)),
    PopupItem(
        'My Booking', () => Get.offNamed(RouteConstant.profile, arguments: 1)),
    PopupItem(
        'My Account', () => Get.offNamed(RouteConstant.profile, arguments: 2)),
    PopupItem('Log Out', () {
      GetStorage box = GetStorage();
      box.erase();
      Get.offAllNamed(RouteConstant.home);
    }),
  ];

  final GlobalKey _key = GlobalKey();

  User? _user;

  @override
  void initState() {
    _checkLoginStatus();
    super.initState();
  }

  _checkLoginStatus() {
    GetStorage box = GetStorage();
    var data = box.read('user');
    if (data == null) return;
    _user = User.fromJson(data);
  }

  _contactUs() {
    String currentRoute = Get.currentRoute;
    if (currentRoute == RouteConstant.home) {
      widget.onContactUs!();
    } else {
      Get.offNamed(RouteConstant.home, arguments: {'contactUs': true});
    }
  }

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
            offset.dx,
            offset.dy + _box.size.height + 10,
            _width - 50 - (offset.dx + _box.size.width),
            _height - (offset.dy + _box.size.height)),
        items: _popupMenu
            .map((e) => PopupMenuItem<int>(
                  child: Text(e.name),
                  value: _popupMenu.indexOf(e),
                ))
            .toList(),
      ).then<void>((item) {
        _popupMenu[item!].onTap();
      });
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            InkWell(
              onTap: () => Get.offNamed(RouteConstant.home),
              child: const Text('HOME'),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                if (_user == null) {
                  Get.toNamed(RouteConstant.login);
                } else {
                  if (_user?.userDetail?.company == null) {
                    Get.offNamed(RouteConstant.profile, arguments: 2);
                    Fluttertoast.showToast(
                        msg: "Complete your personal data first!",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 3,
                        backgroundColor: Colors.grey,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    Get.offNamed(RouteConstant.bookOnline);
                  }
                }
              },
              child: const Text('BOOK ONLINE'),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: _contactUs,
              child: const Text('CONTACT US'),
            ),
          ],
        ),
        InkWell(
          key: _key,
          onTap: () {
            if (_user == null) {
              Get.toNamed(RouteConstant.login);
            } else {
              _popUp();
            }
          },
          child: Row(
            children: [
              const CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage('assets/img/blank_profile.png'),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(_user == null ? 'Log In' : _user!.email),
            ],
          ),
        ),
      ],
    );
  }
}
