import 'dart:convert';

class OrderData {
  String orderTitle;
  bool approvedByCompany;
  bool approvedByCustomer;
  bool confirmedBySales;
  String orderTime;
  String? deliveryNoteConfirmedDate;
  Map<String, MachineData> machineList;

  OrderData({
    required this.confirmedBySales,
    this.deliveryNoteConfirmedDate,
    required this.orderTitle,
    required this.approvedByCompany,
    required this.approvedByCustomer,
    required this.orderTime,
    required this.machineList,
  });

  factory OrderData.fromMap(Map<String, dynamic> json) => OrderData(
          approvedByCompany: json['approvedByCompany'],
          approvedByCustomer: json['approvedByCustomer'],
          orderTitle: json['orderTitle'],
          confirmedBySales: json['confirmedBySales'],
          orderTime: json['orderTime'],
          deliveryNoteConfirmedDate: json['deliveryNoteConfirmedDate'],
          machineList: {
            for (String machineKey in json['machineList'].keys)
              machineKey: MachineData(
                machineType: json['machineList'][machineKey]['machineType'],
                partRequest: {
                  for (String key
                      in json['machineList'][machineKey]['partRequest'].keys)
                    key: PartData(
                      partNumber: json['machineList'][machineKey]['partRequest']
                          [key]['partNumber'],
                      itemName: json['machineList'][machineKey]['partRequest']
                          [key]['itemName'],
                      quantity: json['machineList'][machineKey]['partRequest']
                          [key]['quantity'],
                    )
                },
              )
          });

  Map<String, dynamic> toMap() => {
        "orderTitle": orderTitle,
        'approvedByCompany': approvedByCompany,
        'approvedByCustomer': approvedByCustomer,
        "orderTime": orderTime,
        'confirmedBySales': confirmedBySales,
        'deliveryNoteConfirmedDate': deliveryNoteConfirmedDate,
        "machineList": {
          for (String machineKey in machineList.keys)
            machineKey: {
              'machineType': machineList[machineKey]!.machineType,
              'partRequest': {
                for (String partKey
                    in machineList[machineKey]!.partRequest.keys)
                  partKey: {
                    'partNumber': machineList[machineKey]!
                        .partRequest[partKey]!
                        .partNumber,
                    'itemName':
                        machineList[machineKey]!.partRequest[partKey]!.itemName,
                    'quantity':
                        machineList[machineKey]!.partRequest[partKey]!.quantity
                  }
              }
            },
        },
      };

  String toJson() => json.encode(toMap());
}

class MachineData {
  String machineType;
  Map<String, PartData> partRequest;

  MachineData({required this.machineType, required this.partRequest});
}

class PartData {
  String partNumber;
  String itemName;
  int quantity;

  PartData({
    required this.partNumber,
    required this.itemName,
    required this.quantity,
  });
}
