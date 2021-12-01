class OrderData {
  String orderTitle;
  Map<String, MachineData> machineList;

  OrderData({required this.orderTitle, required this.machineList});

  Map<String, dynamic> toMap() => {
        "orderTitle": orderTitle,
        "machineList": machineList,
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
