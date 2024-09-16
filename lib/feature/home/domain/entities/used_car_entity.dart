import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'base_entity.dart';

class UsedCarEntity extends BaseEntity {
  final String name;
  final String weight;
  final String cover;
  final List<String> images;
  final double price;
  final double mainPrice;
  UsedCarEntity({
    required this.name,
    required this.weight,
    required this.cover,
    required this.images,
    required this.price,
    required this.mainPrice,
  });

  @override
  bool operator ==(covariant UsedCarEntity other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.weight == weight &&
        other.cover == cover &&
        listEquals(other.images, images) &&
        other.price == price &&
        other.mainPrice == mainPrice;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        weight.hashCode ^
        cover.hashCode ^
        images.hashCode ^
        price.hashCode ^
        mainPrice.hashCode;
  }

  @override
  String toString() {
    return 'UsedCarEntity(name: $name, weight: $weight, cover: $cover, images: $images, price: $price, mainPrice: $mainPrice)';
  }

  UsedCarEntity copyWith({
    String? name,
    String? weight,
    String? cover,
    List<String>? images,
    double? price,
    double? mainPrice,
  }) {
    return UsedCarEntity(
      name: name ?? this.name,
      weight: weight ?? this.weight,
      cover: cover ?? this.cover,
      images: images ?? this.images,
      price: price ?? this.price,
      mainPrice: mainPrice ?? this.mainPrice,
    );
  }

  @override
  List<Object?> get props => [
        name,
        weight,
        cover,
        images,
        price,
        mainPrice,
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'weight': weight,
      'cover': cover,
      'images': images,
      'price': price,
      'mainPrice': mainPrice,
    };
  }

  factory UsedCarEntity.fromMap(Map<String, dynamic> map) {
    return UsedCarEntity(
      name: map['name'] as String,
      weight: map['weight'].toString(),
      cover: map['cover'] as String,
      images: List<String>.from(map['images'] as List<dynamic>),
      price: (map['price'] as num).toDouble(),
      mainPrice: parseMainPrice(map['mainPrice'] as String),
    );
  }

  static double parseMainPrice(String mainPrice) {
    // Extract numeric part if needed, or handle as a string
    final numericPrice =
        double.tryParse(mainPrice.replaceAll(RegExp(r'[^\d.]'), ''));
    return numericPrice ?? 0.0; // Return 0.0 if parsing fails
  }

  String toJson() => json.encode(toMap());

  factory UsedCarEntity.fromJson(String source) =>
      UsedCarEntity.fromMap(json.decode(source) as Map<String, dynamic>);
}
