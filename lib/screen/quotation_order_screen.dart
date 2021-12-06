import 'package:flutter/material.dart';

class QuotationOrderScreen extends StatefulWidget {
  const QuotationOrderScreen({Key? key}) : super(key: key);

  @override
  State<QuotationOrderScreen> createState() => _QuotationOrderScreenState();
}

class _QuotationOrderScreenState extends State<QuotationOrderScreen> {
  //final Item _item = Item.fromMap(Get.arguments);
  final bool i = false;
  final TextEditingController approverController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;

    Widget _getOrderItem() {
      return SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              width: double.infinity,
              color: const Color.fromRGBO(160, 152, 128, 0.16),
              child: Column(
                children: [
                  //TODO here
                  Text(
                    'Machine Type: LUBRICATION L7/SBY',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(117, 111, 99, 1),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 3,
                    width: 500,
                    color: Colors.white,
                  )
                ],
              ),
            ),
            DataTable(columns: [
              DataColumn(
                label: Text(
                  'Item',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Part Number',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'QTY',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Contract Discount %',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Unit Price\nTotal Tax Amount\nTotal Extra Charges',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
              DataColumn(
                label: Text(
                  'Total',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ], rows: [
              DataRow(
                cells: <DataCell>[
                  DataCell(Text('Curved roller')),
                  DataCell(Text('98u987')),
                  DataCell(Text('2')),
                  DataCell(Text('0.00')),
                  DataCell(Text('')),
                  DataCell(Text('')),
                ],
              ),
            ]),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: AppBar(
          backgroundColor: const Color.fromRGBO(46, 45, 42, 1),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
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
            height: double.infinity,
            width: _width * 0.75,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //title
                    Row(
                      children: [
                        Text(
                          'Quotation ',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Order id ',
                          style: TextStyle(fontSize: 30),
                        ),
                        !i
                            ? Text(
                                '(waiting for confirmation)',
                                style:
                                    TextStyle(fontSize: 20, color: Colors.grey),
                              )
                            : Container()
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text('PO Title: hehe'),
                    ),
                    //section 1
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(160, 152, 128, 1))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Purchase Order',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: double.infinity,
                      color: const Color.fromRGBO(160, 152, 128, 0.16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Invoice Bill To',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(width: 100),
                          SizedBox(
                            width: 300,
                            child: Text(
                              'PT Coca-Cola Bottling Indonesia South Quarter Tower C Lantai 22(PH), Jalan RA Kartini Kav 8, RT.010 RW.004, Cilandak Barat, Cilandak, Jakarta Selatan, DKI Jakarta 12430',
                              style: TextStyle(height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(150),
                            1: FixedColumnWidth(300),
                          },
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Buyer',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('DESRIYADI'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Order Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('2021-10-23 15:26:43.756'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Delivery Date',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('2021-10-23 15:26:43.756'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Goods Ship To',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'PT CCBI - East Java Plant, Jalan Raya Surabaya - Malang KM 43 Pandaan-Pasuruan, Surabaya, Indonesia'),
                              )
                            ]),
                          ],
                        ),
                        Table(
                          columnWidths: const <int, TableColumnWidth>{
                            0: FixedColumnWidth(150),
                            1: FixedColumnWidth(300),
                          },
                          children: [
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Supplier',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'KHS PACKAGING MACHINERY INDONESIA, PT'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Address',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'JL YOS SUDARSO KAV 30 SUNTER THE PRIME - OFFICE'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Telephone',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('0210000'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Fax No.',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('0210000'),
                              )
                            ]),
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Invoice Sent To',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                    'Pt. Coca-Cola Bottling Indonesia, Jl. Teuku Umar Km 46, Desa Sukadanau, Cibitung - Bekasi, Jawa Barat 17520'),
                              )
                            ]),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: const Color.fromRGBO(160, 152, 128, 1))),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        child: Text(
                          'Part Line Items',
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    _getOrderItem(),
                    const Divider(color: Color.fromRGBO(160, 152, 128, 1)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 300,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Currency',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('Indonesia Rupiah (IDR)'),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text('36000000'),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: 450,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Approver*',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 300,
                                  child: TextField(
                                    controller: approverController,
                                    decoration: InputDecoration(
                                      focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(117, 111, 99, 1),
                                            width: 1),
                                      ),
                                      enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color:
                                                Color.fromRGBO(117, 111, 99, 1),
                                            width: 1),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Payment Terms',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('YI45'),
                                  ],
                                ),
                                const Divider(
                                    color: Color.fromRGBO(160, 152, 128, 1)),
                                Text('45 days from Invoice Receipt'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(160, 152, 128, 1),
                          ),
                          onPressed: i ? () {} : null,
                          child: const Text('Approve'),
                        ),
                        const SizedBox(width: 30),
                        OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              primary: const Color.fromRGBO(160, 152, 128, 1)),
                          onPressed: () {},
                          child: const Text('Cancel Order'),
                        )
                      ],
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
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
        ],
      ),
    );
  }
}
