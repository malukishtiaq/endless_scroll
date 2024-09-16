import 'package:car_dealership/feature/home/domain/entities/base_entity.dart';

abstract class DataSource {
  String get baseUrl => 'http://10.0.2.2:8080/';
  Future<List<T>> getCars<T extends BaseEntity>(
      String endpoint, T Function(Map<String, dynamic>) fromMap);
}
