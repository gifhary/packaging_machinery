import 'package:packaging_machinery/model/order_data.dart';

class QuotationOrder {
  String orderId;
  String invoiceBillTo;
  String buyer;
  String deliveryAddress;
  OrderData orderData;
  bool approvedByCompany;
  bool approvedByCustomer;
  QuotationOrder({
    required this.orderId,
    required this.invoiceBillTo,
    required this.buyer,
    required this.deliveryAddress,
    required this.orderData,
    required this.approvedByCompany,
    required this.approvedByCustomer,
  });

  factory QuotationOrder.fromMap(Map<String, dynamic> json) => QuotationOrder(
        orderId: json['orderId'],
        invoiceBillTo: json[''],
        buyer: json['buyer'],
        deliveryAddress: json['deliveryAddress'],
        orderData: OrderData.fromMap(json['orderData']),
        approvedByCompany: json['approvedByCompany'],
        approvedByCustomer: json['approvedByCustomer'],
      );
  Map<String, dynamic> toMap() => {
        'orderId': orderId,
        'invoiceBillTo': invoiceBillTo,
        'buyer': buyer,
        'deliveryAddress': deliveryAddress,
        'orderData': orderData.toMap(),
        'approvedByCompany': approvedByCompany,
        'approvedByCustomer': approvedByCustomer,
      };
}
