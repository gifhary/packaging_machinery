import 'dart:convert';

class ItemList {
  String item;
  String partNumber;
  String type;
  ItemList({
    required this.item,
    required this.partNumber,
    required this.type,
  });

  ItemList copyWith({
    String? item,
    String? partNumber,
    String? type,
  }) {
    return ItemList(
      item: item ?? this.item,
      partNumber: partNumber ?? this.partNumber,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'item': item,
      'partNumber': partNumber,
      'type': type,
    };
  }

  factory ItemList.fromMap(Map<String, dynamic> map) {
    return ItemList(
      item: map['item'] ?? '',
      partNumber: map['partNumber'] ?? '',
      type: map['type'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ItemList.fromJson(String source) =>
      ItemList.fromMap(json.decode(source));

  @override
  String toString() =>
      'ItemList(item: $item, partNumber: $partNumber, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ItemList &&
        other.item == item &&
        other.partNumber == partNumber &&
        other.type == type;
  }

  @override
  int get hashCode => item.hashCode ^ partNumber.hashCode ^ type.hashCode;
}
