import 'dart:convert';

import 'package:packaging_machinery/model/address.dart';

class UserDetail {
  String name, title, firstName, lastName, additionalEmail, company, position;
  Address address,
      deliveryAddress,
      invoiceBillAddress,
      invoiceBillingSettlementAddress;
  UserDetail({
    required this.name,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.additionalEmail,
    required this.company,
    required this.position,
    required this.address,
    required this.deliveryAddress,
    required this.invoiceBillAddress,
    required this.invoiceBillingSettlementAddress,
  });

  UserDetail copyWith({
    String? name,
    String? title,
    String? firstName,
    String? lastName,
    String? additionalEmail,
    String? company,
    String? position,
    Address? address,
    Address? deliveryAddress,
    Address? invoiceBillAddress,
    Address? invoiceBillingSettlementAddress,
  }) {
    return UserDetail(
      name: name ?? this.name,
      title: title ?? this.title,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      additionalEmail: additionalEmail ?? this.additionalEmail,
      company: company ?? this.company,
      position: position ?? this.position,
      address: address ?? this.address,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      invoiceBillAddress: invoiceBillAddress ?? this.invoiceBillAddress,
      invoiceBillingSettlementAddress: invoiceBillingSettlementAddress ??
          this.invoiceBillingSettlementAddress,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'title': title,
      'firstName': firstName,
      'lastName': lastName,
      'additionalEmail': additionalEmail,
      'company': company,
      'position': position,
      'address': address.toMap(),
      'deliveryAddress': deliveryAddress.toMap(),
      'invoiceBillAddress': invoiceBillAddress.toMap(),
      'invoiceBillingSettlementAddress':
          invoiceBillingSettlementAddress.toMap(),
    };
  }

  factory UserDetail.fromMap(Map<String, dynamic> map) {
    return UserDetail(
      name: map['name'],
      title: map['title'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      additionalEmail: map['additionalEmail'],
      company: map['company'],
      position: map['position'],
      address: Address.fromMap(map['address']),
      deliveryAddress: Address.fromMap(map['deliveryAddress']),
      invoiceBillAddress: Address.fromMap(map['invoiceBillAddress']),
      invoiceBillingSettlementAddress:
          Address.fromMap(map['invoiceBillingSettlementAddress']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetail.fromJson(String source) =>
      UserDetail.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDetail(name: $name, title: $title, firstName: $firstName, lastName: $lastName, additionalEmail: $additionalEmail, company: $company, position: $position, address: $address, deliveryAddress: $deliveryAddress, invoiceBillAddress: $invoiceBillAddress, invoiceBillingSettlementAddress: $invoiceBillingSettlementAddress)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetail &&
        other.name == name &&
        other.title == title &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.additionalEmail == additionalEmail &&
        other.company == company &&
        other.position == position &&
        other.address == address &&
        other.deliveryAddress == deliveryAddress &&
        other.invoiceBillAddress == invoiceBillAddress &&
        other.invoiceBillingSettlementAddress ==
            invoiceBillingSettlementAddress;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        title.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        additionalEmail.hashCode ^
        company.hashCode ^
        position.hashCode ^
        address.hashCode ^
        deliveryAddress.hashCode ^
        invoiceBillAddress.hashCode ^
        invoiceBillingSettlementAddress.hashCode;
  }
}
