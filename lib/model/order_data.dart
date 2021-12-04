import 'dart:convert';

class OrderData {
  String orderTitle;
  bool approvedByCompany;
  bool approvedByCustomer;
  String time;
  Map<String, MachineData> machineList;

  OrderData({
    required this.orderTitle,
    required this.approvedByCompany,
    required this.approvedByCustomer,
    required this.time,
    required this.machineList,
  });

  factory OrderData.fromMap(Map<String, dynamic> json) => OrderData(
          approvedByCompany: json['approvedByCompany'],
          approvedByCustomer: json['approvedByCustomer'],
          orderTitle: json['orderTitle'],
          time: json['time'],
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
                    )
                },
              )
          });

  Map<String, dynamic> toMap() => {
        "orderTitle": orderTitle,
        'approvedByCompany': approvedByCompany,
        'approvedByCustomer': approvedByCustomer,
        "time": time,
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
                        machineList[machineKey]!.partRequest[partKey]!.itemName
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

  PartData({required this.partNumber, required this.itemName});
}
