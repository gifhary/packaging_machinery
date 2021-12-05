import 'package:flutter/material.dart';

class OrderRequest {
  final TextEditingController orderTitle;
  final Map<String, MachineRequest> machineList;

  OrderRequest({required this.orderTitle, required this.machineList});
}

class MachineRequest {
  final TextEditingController machineType;
  final Map<String, PartRequest> partRequest;

  MachineRequest({required this.machineType, required this.partRequest});
}

class PartRequest {
  final TextEditingController partNumber;
  final TextEditingController itemName;
  final TextEditingController quantity;

  PartRequest(
      {required this.quantity,
      required this.partNumber,
      required this.itemName});
}
