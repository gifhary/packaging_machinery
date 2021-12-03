import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:packaging_machinery/widget/ini_text_field.dart';

class MyAccountTab extends StatefulWidget {
  const MyAccountTab({Key? key}) : super(key: key);

  @override
  State<MyAccountTab> createState() => _MyAccountTabState();
}

class _MyAccountTabState extends State<MyAccountTab> {
  TextEditingController _nameCtr = TextEditingController();
  TextEditingController _titleCtr = TextEditingController();

  TextEditingController _firstNameCtr = TextEditingController();
  TextEditingController _lastNameCtr = TextEditingController();
  TextEditingController _phoneCtr = TextEditingController();
  TextEditingController _additionalEmailCtr = TextEditingController();
  TextEditingController _companyCtr = TextEditingController();
  TextEditingController _positionCtr = TextEditingController();

  TextEditingController _address1Ctr = TextEditingController();
  TextEditingController _address2Ctr = TextEditingController();
  TextEditingController _streetCtr = TextEditingController();
  TextEditingController _cityCtr = TextEditingController();
  TextEditingController _zipCodeCtr = TextEditingController();
  TextEditingController _countryCtr = TextEditingController();

  TextEditingController _deliveryAddress1Ctr = TextEditingController();
  TextEditingController _deliveryAddress2Ctr = TextEditingController();
  TextEditingController _deliveryStreetCtr = TextEditingController();
  TextEditingController _deliveryCityCtr = TextEditingController();
  TextEditingController _deliveryZipCodeCtr = TextEditingController();
  TextEditingController _deliveryCountryCtr = TextEditingController();

  TextEditingController _billAddress1Ctr = TextEditingController();
  TextEditingController _billAddress2Ctr = TextEditingController();
  TextEditingController _billStreetCtr = TextEditingController();
  TextEditingController _billCityCtr = TextEditingController();
  TextEditingController _billZipCodeCtr = TextEditingController();
  TextEditingController _billCountryCtr = TextEditingController();

  TextEditingController _settlementAddress1Ctr = TextEditingController();
  TextEditingController _settlementAddress2Ctr = TextEditingController();
  TextEditingController _settlementStreetCtr = TextEditingController();
  TextEditingController _settlementCityCtr = TextEditingController();
  TextEditingController _settlementZipCodeCtr = TextEditingController();
  TextEditingController _settlementCountryCtr = TextEditingController();

  @override
  initState() {
    super.initState();
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
                  children: const [
                    IniTextField(
                      label: 'Buyer Name*',
                    ),
                    SizedBox(width: 50),
                    IniTextField(
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
                children: const [
                  IniTextField(
                    label: 'First Name',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'Last Name',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Phone',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'Email',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Company',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
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
                children: const [
                  IniTextField(
                    label: 'Address 1*',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Address 2',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Street',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
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
                children: const [
                  IniTextField(
                    label: 'Address 1*',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Address 2',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Street',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
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
                children: const [
                  IniTextField(
                    label: 'Address 1*',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Address 2',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Street',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
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
                children: const [
                  IniTextField(
                    label: 'Address 1*',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'City*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Address 2',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
                    label: 'Zipcode*',
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: const [
                  IniTextField(
                    label: 'Street',
                  ),
                  SizedBox(width: 50),
                  IniTextField(
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
