// data_fetch_isolate.dart

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:http/http.dart' as http;

import '../../feature/home/domain/entities/used_car_entity.dart';

Future<List<UsedCarEntity>> fetchMoreRecords(int page, int limit) async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:8080/used-cars?page=$page&limit=$limit'),
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body) as List<dynamic>;
    return jsonData.map((carJson) => UsedCarEntity.fromMap(carJson)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

void fetchInBackground(SendPort sendPort) async {
  final List<UsedCarEntity> records = await fetchMoreRecords(2, 50);
  sendPort.send(records);
}
