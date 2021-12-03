import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/widget/ini_text_field.dart';

class MyAccountTab extends StatefulWidget {
  const MyAccountTab({Key? key}) : super(key: key);

  @override
  State<MyAccountTab> createState() => _MyAccountTabState();
}

class _MyAccountTabState extends State<MyAccountTab> {
  final db = FirebaseDatabase.instance.reference();
  late DatabaseReference usersDb;
  late User _user;

  final TextEditingController _nameCtr = TextEditingController();
  final TextEditingController _titleCtr = TextEditingController();

  final TextEditingController _firstNameCtr = TextEditingController();
  final TextEditingController _lastNameCtr = TextEditingController();
  final TextEditingController _phoneCtr = TextEditingController();
  final TextEditingController _additionalEmailCtr = TextEditingController();
  final TextEditingController _companyCtr = TextEditingController();
  final TextEditingController _positionCtr = TextEditingController();

  final TextEditingController _address1Ctr = TextEditingController();
  final TextEditingController _address2Ctr = TextEditingController();
  final TextEditingController _streetCtr = TextEditingController();
  final TextEditingController _cityCtr = TextEditingController();
  final TextEditingController _zipCodeCtr = TextEditingController();
  final TextEditingController _countryCtr = TextEditingController();

  final TextEditingController _deliveryAddress1Ctr = TextEditingController();
  final TextEditingController _deliveryAddress2Ctr = TextEditingController();
  final TextEditingController _deliveryStreetCtr = TextEditingController();
  final TextEditingController _deliveryCityCtr = TextEditingController();
  final TextEditingController _deliveryZipCodeCtr = TextEditingController();
  final TextEditingController _deliveryCountryCtr = TextEditingController();

  final TextEditingController _billAddress1Ctr = TextEditingController();
  final TextEditingController _billAddress2Ctr = TextEditingController();
  final TextEditingController _billStreetCtr = TextEditingController();
  final TextEditingController _billCityCtr = TextEditingController();
  final TextEditingController _billZipCodeCtr = TextEditingController();
  final TextEditingController _billCountryCtr = TextEditingController();

  final TextEditingController _settlementAddress1Ctr = TextEditingController();
  final TextEditingController _settlementAddress2Ctr = TextEditingController();
  final TextEditingController _settlementStreetCtr = TextEditingController();
  final TextEditingController _settlementCityCtr = TextEditingController();
  final TextEditingController _settlementZipCodeCtr = TextEditingController();
  final TextEditingController _settlementCountryCtr = TextEditingController();

  @override
  initState() {
    usersDb = db.child(DbConstant.user);

    _checkLoginStatus();

    if (_user.userDetail == null) {
      _getFormDataFromDB();
    } else {
      _fillFormWithExistingData();
    }
    super.initState();
  }

  _getFormDataFromDB() {
    usersDb.child(getMd5(_user.email)).get().then((value) {
      _user = User.fromMap(value.value);
      if (_user.userDetail != null) {
        //fill data
        _fillFormWithExistingData();
      } else {
        debugPrint('user detail doesnt exists');
      }
    }).onError((error, stackTrace) {
      debugPrint('error getting form data');
    });
  }

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  _checkLoginStatus() {
    GetStorage box = GetStorage();
    var data = box.read('user');
    if (data == null) return;
    _user = User.fromJson(data);
  }

  _postUserDetail() {}

  _fillFormWithExistingData() {
    setState(() {
      _nameCtr.text = _user.userDetail!.name;
      _titleCtr.text = _user.userDetail!.title!;

      _firstNameCtr.text = _user.userDetail!.firstName!;
      _lastNameCtr.text = _user.userDetail!.lastName!;
      _phoneCtr.text = _user.userDetail!.phone!;
      _additionalEmailCtr.text = _user.userDetail!.additionalEmail!;
      _companyCtr.text = _user.userDetail!.company!;
      _positionCtr.text = _user.userDetail!.position!;

      _address1Ctr.text = _user.userDetail!.address.address1;
      _address2Ctr.text = _user.userDetail!.address.address2!;
      _streetCtr.text = _user.userDetail!.address.street!;
      _cityCtr.text = _user.userDetail!.address.city;
      _zipCodeCtr.text = _user.userDetail!.address.zipcode;
      _countryCtr.text = _user.userDetail!.address.country;

      _deliveryAddress1Ctr.text = _user.userDetail!.deliveryAddress.address1;
      _deliveryAddress2Ctr.text = _user.userDetail!.deliveryAddress.address2!;
      _deliveryStreetCtr.text = _user.userDetail!.deliveryAddress.street!;
      _deliveryCityCtr.text = _user.userDetail!.deliveryAddress.city;
      _deliveryZipCodeCtr.text = _user.userDetail!.deliveryAddress.city;
      _deliveryCountryCtr.text = _user.userDetail!.deliveryAddress.country;

      _billAddress1Ctr.text = _user.userDetail!.invoiceBillAddress!.address1;
      _billAddress2Ctr.text = _user.userDetail!.invoiceBillAddress!.address2!;
      _billStreetCtr.text = _user.userDetail!.invoiceBillAddress!.street!;
      _billCityCtr.text = _user.userDetail!.invoiceBillAddress!.city;
      _billZipCodeCtr.text = _user.userDetail!.invoiceBillAddress!.zipcode;
      _billCountryCtr.text = _user.userDetail!.invoiceBillAddress!.city;

      _settlementAddress1Ctr.text =
          _user.userDetail!.invoiceBillingSettlementAddress!.address1;
      _settlementAddress2Ctr.text =
          _user.userDetail!.invoiceBillingSettlementAddress!.address2!;
      _settlementStreetCtr.text =
          _user.userDetail!.invoiceBillingSettlementAddress!.street!;
      _settlementCityCtr.text =
          _user.userDetail!.invoiceBillingSettlementAddress!.city;
      _settlementZipCodeCtr.text =
          _user.userDetail!.invoiceBillingSettlementAddress!.zipcode;
      _settlementCountryCtr.text =
          _user.userDetail!.invoiceBillingSettlementAddress!.country;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 0, 50, 50),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Text(
                      'My Account',
                      style: TextStyle(fontSize: 30),
                    ),
                  ),
                  Row(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            primary: const Color.fromRGBO(160, 152, 128, 1)),
                        onPressed: () {},
                        child: const Text('Discard'),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: const Color.fromRGBO(160, 152, 128, 1),
                        ),
                        onPressed: () {},
                        child: const Text('Update info'),
                      ),
                    ],
                  ),
                ],
              ),
              const Text('View and edit your personal info below.'),
              const Divider(color: Color.fromRGBO(117, 111, 99, 1)),
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  'Display Info',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const Text('View and edit your personal info below.'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    IniTextField(
                      controller: _nameCtr,
                      label: 'Buyer Name*',
                    ),
                    const SizedBox(width: 50),
                    IniTextField(
                      controller: _titleCtr,
                      label: 'Title',
                    ),
                  ],
                ),
              ),
              const Divider(color: Color.fromRGBO(117, 111, 99, 1)),
              const Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text(
                  'Account',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              const Text(
                  'Update & Edit the information you share with the comunity'),
              const SizedBox(height: 20),
              const Text('Login Email:'),
              const Text('luisa.samantha@gmail.com'),
              const Text(
                'Your Login email can\'t be changed',
                style: TextStyle(color: Color.fromRGBO(117, 111, 99, 0.5)),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  IniTextField(
                    controller: _firstNameCtr,
                    label: 'First Name',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _lastNameCtr,
                    label: 'Last Name',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _phoneCtr,
                    label: 'Phone',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _additionalEmailCtr,
                    label: 'Email',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _companyCtr,
                    label: 'Company',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _positionCtr,
                    label: 'Position',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                children: [
                  IniTextField(
                    controller: _address1Ctr,
                    label: 'Address 1*',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _cityCtr,
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _address2Ctr,
                    label: 'Address 2',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _zipCodeCtr,
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _streetCtr,
                    label: 'Street',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _countryCtr,
                    label: 'Country*',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Delivery Address*',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                children: [
                  IniTextField(
                    controller: _deliveryAddress1Ctr,
                    label: 'Address 1*',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _deliveryCityCtr,
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _deliveryAddress2Ctr,
                    label: 'Address 2',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _deliveryZipCodeCtr,
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _deliveryStreetCtr,
                    label: 'Street',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _deliveryCountryCtr,
                    label: 'Country*',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Invoice Bill Address',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                children: [
                  IniTextField(
                    controller: _billAddress1Ctr,
                    label: 'Address 1*',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _billCityCtr,
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _billAddress2Ctr,
                    label: 'Address 2',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _billZipCodeCtr,
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _billStreetCtr,
                    label: 'Street',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _billCountryCtr,
                    label: 'Country*',
                  ),
                ],
              ),
              const SizedBox(height: 15),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  'Invoice Billing Settlement Address',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Row(
                children: [
                  IniTextField(
                    controller: _settlementAddress1Ctr,
                    label: 'Address 1*',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _settlementCityCtr,
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _settlementAddress2Ctr,
                    label: 'Address 2',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _settlementZipCodeCtr,
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  IniTextField(
                    controller: _settlementStreetCtr,
                    label: 'Street',
                  ),
                  const SizedBox(width: 50),
                  IniTextField(
                    controller: _settlementCountryCtr,
                    label: 'Country*',
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        primary: const Color.fromRGBO(160, 152, 128, 1)),
                    onPressed: () {},
                    child: const Text('Discard'),
                  ),
                  const SizedBox(width: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(160, 152, 128, 1),
                    ),
                    onPressed: () {},
                    child: const Text('Update info'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
