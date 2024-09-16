import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'base_entity.dart';

class NewCarEntity extends BaseEntity {
  final String name;
  final String cover;
  final List<String> itemNames;
  final int price;
  final int mainPrice;

  NewCarEntity({
    required this.name,
    required this.cover,
    required this.itemNames,
    required this.price,
    required this.mainPrice,
  });

  @override
  String toString() {
    return 'NewCarEntity(name: $name, cover: $cover, itemNames: $itemNames, price: $price, mainPrice: $mainPrice)';
  }

  NewCarEntity copyWith({
    String? name,
    String? cover,
    List<String>? itemNames,
    int? price,
    int? mainPrice,
  }) {
    return NewCarEntity(
      name: name ?? this.name,
      cover: cover ?? this.cover,
      itemNames: itemNames ?? this.itemNames,
      price: price ?? this.price,
      mainPrice: mainPrice ?? this.mainPrice,
    );
  }

  @override
  bool operator ==(covariant NewCarEntity other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.cover == cover &&
        listEquals(other.itemNames, itemNames) &&
        other.price == price &&
        other.mainPrice == mainPrice;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        cover.hashCode ^
        itemNames.hashCode ^
        price.hashCode ^
        mainPrice.hashCode;
  }

  @override
  List<Object?> get props => [
        name,
        cover,
        itemNames,
        price,
        mainPrice,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'cover': cover,
      'itemNames': itemNames,
      'price': price,
      'mainPrice': mainPrice,
    };
  }

  factory NewCarEntity.fromMap(Map<String, dynamic> map) {
    return NewCarEntity(
      name: map['name'] as String,
      cover: map['cover'] as String,
      itemNames: List<String>.from(map['itemNames'] as List<dynamic>),
      price: map['price'] as int,
      mainPrice: int.parse(map['mainPrice']),
    );
  }

  String toJson() => json.encode(toMap());

  factory NewCarEntity.fromJson(String source) =>
      NewCarEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
