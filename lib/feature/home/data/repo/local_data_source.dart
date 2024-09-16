// import 'dart:convert';
// import 'package:car_dealership/feature/domain/entities/base_entity.dart';
// import 'package:injectable/injectable.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// 
// import 'data_source.dart';
// 
// @Injectable(as: DataSource, env: [Environment.test])
// class LocalDataSource extends DataSource {
//   @override
//   Future<List<T>> getCars<T extends BaseEntity>(
//       String endpoint, T Function(Map<String, dynamic> p1) fromMap) async {
//     final prefs = await SharedPreferences.getInstance();
//     final carsJson = prefs.getString(endpoint);
// 
//     if (carsJson == null) {
//       return [];
//     }
// 
//     final carsList = List<Map<String, dynamic>>.from(jsonDecode(carsJson));
//     return carsList
//         .map((carJson) => fromMap(Map<String, dynamic>.from(carJson)))
//         .toList();
//   }
// }
