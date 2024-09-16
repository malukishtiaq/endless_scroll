import 'dart:convert';
import 'dart:io';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

// These will hold the car data once loaded from the files
List<Map<String, dynamic>> usedCars = [];
List<Map<String, dynamic>> newCars = [];

// Load the JSON files
Future<void> loadCarsData() async {
  // Load cars.json
  final carsFile = File('assets/data/used_cars.json');
  final carsContent = await carsFile.readAsString();
  final List<dynamic> carsJson = jsonDecode(carsContent);
  usedCars = List<Map<String, dynamic>>.from(carsJson);

  // Load new_cars.json
  final newCarsFile = File('assets/data/new_cars.json');
  final newCarsContent = await newCarsFile.readAsString();
  final List<dynamic> newCarsJson = jsonDecode(newCarsContent);
  newCars = List<Map<String, dynamic>>.from(newCarsJson);
}

// Handler for paginated cars.json data
Response _carsHandler(Request request) {
  final page = int.tryParse(request.url.queryParameters['page'] ?? '1') ?? 1;
  final limit =
      int.tryParse(request.url.queryParameters['limit'] ?? '20') ?? 20;
  final start = (page - 1) * limit;
  final end =
      (start + limit) > usedCars.length ? usedCars.length : (start + limit);

  final paginatedCars = usedCars.sublist(start, end);
  final jsonCars = jsonEncode(paginatedCars);
  return Response.ok(jsonCars, headers: {'Content-Type': 'application/json'});
}

// Handler for new_cars.json data (pagination optional)
Response _newCarsHandler(Request request) {
  final page = int.tryParse(request.url.queryParameters['page'] ?? '1') ?? 1;
  final limit =
      int.tryParse(request.url.queryParameters['limit'] ?? '20') ?? 20;
  final start = (page - 1) * limit;
  final end =
      (start + limit) > newCars.length ? newCars.length : (start + limit);

  final paginatedNewCars = newCars.sublist(start, end);
  final jsonNewCars = jsonEncode(paginatedNewCars);
  return Response.ok(jsonNewCars,
      headers: {'Content-Type': 'application/json'});
}

void main() async {
  // Load data from both JSON files
  await loadCarsData();

  final router = Router();

  // Route to handle paginated used_cars.json
  router.get('/used-cars', _carsHandler);

  // Route to handle paginated new_cars.json
  router.get('/new-cars', _newCarsHandler);

  final handler = Pipeline().addMiddleware(logRequests()).addHandler(router);

  // Bind server to all network interfaces
  final server = await shelf_io.serve(handler, '0.0.0.0', 8080);

  print('Listening on http://${server.address.address}:${server.port}');
}
