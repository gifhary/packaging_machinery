class OrderData {
  String orderTitle;
  Map<String, MachineData> machineList;

  OrderData({required this.orderTitle, required this.machineList});

  Map<String, dynamic> toMap() => {
        "orderTitle": orderTitle,
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
