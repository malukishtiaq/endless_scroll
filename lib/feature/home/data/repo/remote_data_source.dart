import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:car_dealership/feature/home/domain/entities/base_entity.dart';
import 'package:injectable/injectable.dart';
import 'data_source.dart';

@Injectable(as: DataSource, env: [Environment.dev])
class RemoteDataSource extends DataSource {
  final http.Client client;

  RemoteDataSource(this.client);

  @override
  Future<List<T>> getCars<T extends BaseEntity>(
      String endpoint, T Function(Map<String, dynamic> p1) fromMap) async {
    try {
      final uri = Uri.parse(baseUrl + endpoint);

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body) as List<dynamic>;

        return jsonData
            .map((carJson) => fromMap(carJson as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching cars: $e');
    }
  }
}
