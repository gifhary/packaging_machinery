import 'dart:convert';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto/crypto.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'package:packaging_machinery/constant/db_constant.dart';
import 'package:packaging_machinery/constant/storage_constant.dart';
import 'package:packaging_machinery/model/address.dart';
import 'package:packaging_machinery/model/delivery_note.dart';
import 'package:packaging_machinery/model/item.dart';
import 'package:packaging_machinery/model/staff.dart';
import 'package:packaging_machinery/model/user.dart';
import 'package:packaging_machinery/widget/machine_table_note.dart';

class DeliveryNoteScreen extends StatefulWidget {
  @override
  State<DeliveryNoteScreen> createState() => _DeliveryNoteScreenState();
}

class _DeliveryNoteScreenState extends State<DeliveryNoteScreen> {
  final db = FirebaseDatabase.instance.reference();
  final Item _item = Item.fromMap(Get.arguments['item']);
  final Staff _salesAdmin = Get.arguments['salesAdmin'] as Staff;

  late User _user;
  Uint8List imageFile = Uint8List(0);

  final TextEditingController _refNo = TextEditingController();
  final TextEditingController _rnNo = TextEditingController();

  DeliveryNote? _note;
  bool _loading = true;

  @override
  void initState() {
    _getLocalUserData();
    WidgetsBinding.instance!
        .addPostFrameCallback((_) => _getDeliveryNoteStatus());
    super.initState();
  }

  _getDeliveryNoteStatus() {
    final deliveryNote = db.child(DbConstant.deliveryNote);
    deliveryNote
        .child(getMd5(_user.email) + '/' + _item.orderId)
        .get()
        .then((value) {
      if (value.exists) {
        _note = DeliveryNote.fromMap(value.value);
        debugPrint(value.value.toString());
      }
      _loading = false;
      setState(() {});
    });
  }

  _getLocalUserData() {
    GetStorage box = GetStorage();
    var data = box.read('user');
    if (data == null) return;
    _user = User.fromJson(data);
  }

  String _getAddress(Address address) {
    String str = '';
    debugPrint(address.toString());

    if (address.address1.isNotEmpty) {
      str += address.address1 + ', ';
    }
    if (address.address2?.isNotEmpty ?? false) {
      str += address.address2! + ', ';
    }
    if (address.street?.isNotEmpty ?? false) {
      str += address.street! + ', ';
    }
    if (address.city.isNotEmpty) {
      str += address.city + ', ';
    }
    if (address.zipcode.isNotEmpty) {
      str += address.zipcode + ', ';
    }
    if (address.country.isNotEmpty) {
      str += address.country + '.';
    }
    return str;
  }

  String getMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  _getCustomerSignature() {
    ImagePickerWeb.getImage(outputType: ImageType.bytes).then((value) {
      if (value != null) imageFile = value as Uint8List;
      setState(() {});
    });
  }

  _submitDeliveryNote() async {
    final storage = FirebaseStorage.instance.ref(
        '${StorageConstant.deliveryNote}signature-${DateTime.now().toString().split(' ')[0]}${_item.orderId}.png');

    TaskSnapshot uploadTask = await storage.putData(
        imageFile, SettableMetadata(contentType: 'image/png'));

    uploadTask.ref.getDownloadURL().then((url) =>
        _saveDeliveryNote(url, DateTime.now().toString().split(' ')[0]));
  }

  _saveDeliveryNote(String imgUrl, date) {
    final deliveryNote = db.child(DbConstant.deliveryNote);
    deliveryNote.child(getMd5(_user.email)).set({
      _item.orderId: DeliveryNote(
        date: date,
        imgUrl: imgUrl,
        refNo: _refNo.text,
        rnNo: _rnNo.text,
      ).toMap()
    }).then((value) {
      Get.defaultDialog(
          titleStyle: const TextStyle(color: Color.fromRGBO(117, 111, 99, 1)),
          title: "Success",
          middleText: "Delivery note has been submitted!",
          onConfirm: Get.back,
          buttonColor: const Color.fromRGBO(117, 111, 99, 1),
          confirmTextColor: Colors.white,
          textConfirm: 'OK');
      setState(() {
        _note = DeliveryNote(
            refNo: _refNo.text, rnNo: _rnNo.text, date: date, imgUrl: imgUrl);
      });
    });
  }

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
      body: Stack(alignment: AlignmentDirectional.bottomCenter, children: [
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
          padding: EdgeInsets.all(30),
          height: double.infinity,
          width: _width * 0.75,
          color: Colors.white,
          child: _loading
              ? Container(
                  color: Colors.white,
                  child: Center(child: CircularProgressIndicator()),
                )
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Delivery Note ',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'Order: DN${_item.orderId}',
                            style: TextStyle(fontSize: 30),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('PT KHS PACKAGING MACHINERY INDONESIA'),
                              Text('THE PRIME - Office Sunter, 3rd floor'),
                              Text('Jl. Yos Sudarso Kav. 30 Sunter Agun'),
                              Text('Jakarta Utara'),
                            ],
                          ),
                          Image.asset(
                            'assets/img/khs_logo.png',
                            width: 234,
                            height: 72,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                      const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 250,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _user.userDetail!.company ?? '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  _getAddress(
                                      _user.userDetail!.deliveryAddress),
                                  style: TextStyle(height: 1.5),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  children: [
                                    Text('ATTENTION: '),
                                    Text(
                                      'SPAREPART DEPARTMENT',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 350,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Date',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: 5),
                                    Text('Customer Id',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: _note != null ? 5 : 20),
                                    Text('Ref No.',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(height: _note != null ? 5 : 40),
                                    Text('Rn No',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _note != null
                                        ? Text('${_note!.date}')
                                        : Text(DateTime.now()
                                            .toString()
                                            .split(' ')[0]),
                                    SizedBox(height: 5),
                                    Text(getMd5(_user.email)),
                                    SizedBox(height: 5),
                                    _note != null
                                        ? Text('${_note!.refNo}')
                                        : SizedBox(
                                            width: 150,
                                            child: TextField(
                                              onChanged: (s) => setState(() {}),
                                              controller: _refNo,
                                              decoration: InputDecoration(
                                                hintText: "Enter Ref no",
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          117, 111, 99, 1),
                                                      width: 1),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                    SizedBox(height: 5),
                                    _note != null
                                        ? Text('${_note!.rnNo}')
                                        : SizedBox(
                                            width: 150,
                                            child: TextField(
                                              onChanged: (s) => setState(() {}),
                                              controller: _rnNo,
                                              decoration: InputDecoration(
                                                hintText: "Enter RN no",
                                                focusedBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Color.fromRGBO(
                                                          117, 111, 99, 1),
                                                      width: 1),
                                                ),
                                                enabledBorder:
                                                    const OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.red,
                                                      width: 1),
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 20),
                      for (String key in _item.orderData.machineList.keys)
                        MachineTableNote(
                            machineData: _item.orderData.machineList[key]!),
                      const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                      SizedBox(height: 15),
                      Text('Remarks,',
                          style: TextStyle(fontStyle: FontStyle.italic)),
                      SizedBox(height: 100),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              CachedNetworkImage(
                                fit: BoxFit.contain,
                                imageUrl: _salesAdmin.signature,
                                height: 100,
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                width: 150,
                                height: 2,
                                color: Colors.black,
                              ),
                              Text(
                                _salesAdmin.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 10),
                              Text('KHS Packaging Machinery Indonesia')
                            ],
                          ),
                          Column(
                            children: [
                              Container(
                                height: 100,
                                color: _note?.imgUrl.isNotEmpty ?? false
                                    ? Colors.transparent
                                    : Colors.grey.withOpacity(0.5),
                                child: InkWell(
                                  onTap: _note == null
                                      ? _getCustomerSignature
                                      : null,
                                  child: imageFile.isNotEmpty
                                      ? Image.memory(
                                          imageFile,
                                          fit: BoxFit.contain,
                                        )
                                      : _note?.imgUrl.isNotEmpty ?? false
                                          ? CachedNetworkImage(
                                              fit: BoxFit.contain,
                                              imageUrl: _note!.imgUrl,
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            )
                                          : Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.upload_file),
                                                Text(
                                                  'upload stamp and signature',
                                                  style: TextStyle(
                                                      color: Colors.grey),
                                                )
                                              ],
                                            ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.all(15),
                                width: 150,
                                height: 2,
                                color: Colors.black,
                              ),
                              Text(
                                _user.userDetail?.name ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      _note != null
                          ? Container()
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary:
                                        const Color.fromRGBO(160, 152, 128, 1),
                                  ),
                                  onPressed: _refNo.text.isNotEmpty &&
                                          _rnNo.text.isNotEmpty &&
                                          imageFile.isNotEmpty
                                      ? _submitDeliveryNote
                                      : null,
                                  child: const Text('Submit'),
                                ),
                              ],
                            ),
                      const SizedBox(height: 50),
                    ],
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
      ]),
    );
  }
}
