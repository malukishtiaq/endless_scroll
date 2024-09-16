import 'dart:isolate';
import 'package:car_dealership/core/base/generic.dart';
import 'package:car_dealership/feature/home/data/repo/remote_data_source.dart';
import 'package:car_dealership/feature/home/domain/entities/used_car_entity.dart';
import 'package:car_dealership/feature/home/domain/repositories/old_cars_repository.dart';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@singleton
class GetMoreUsedCarsUseCase implements UseCase<List<UsedCarEntity>> {
  final IUsedCarsRepo usedCarsRepo;

  GetMoreUsedCarsUseCase(this.usedCarsRepo);

  final List<UsedCarEntity> _cachedUsedCars = [];
  List<UsedCarEntity> get cachedUsedCars => List.unmodifiable(_cachedUsedCars);

  static bool _isFetching = false;
  static bool _hasMoreData = true;

  @override
  Future<List<UsedCarEntity>> call(int page, int limit) async {
    if (_cachedUsedCars.isEmpty) {
      // If no cached data, fetch from API
      return await _fetchUsedCars(page, limit);
    } else {
      // Return cached data if available
      final cachedData = List<UsedCarEntity>.from(_cachedUsedCars);
      _cachedUsedCars.clear();
      return cachedData;
    }
  }

  Future<List<UsedCarEntity>> _fetchUsedCars(int page, int limit) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _fetchUsedCarsInBackground,
      [receivePort.sendPort, page, limit],
    );

    final data = await receivePort.first;
    if (data is List<UsedCarEntity>) {
      _cachedUsedCars.addAll(data);
      _hasMoreData = data.isNotEmpty;
      return data;
    } else {
      return [];
    }
  }

  static Future<void> _fetchUsedCarsInBackground(List<dynamic> params) async {
    final sendPort = params[0] as SendPort;
    final page = params[1] as int;
    final limit = params[2] as int;

    final dataSource = RemoteDataSource(http.Client());
    final repo = UsedCarsRepo(dataSource);

    try {
      final usedCars = await repo.getUsedCarsData(page: page, limit: limit);
      sendPort.send(usedCars);
    } catch (e) {
      sendPort.send([]);
    }
  }

  Future<void> startBackgroundFetch(int currentFetchedCount) async {
    if (_isFetching || !_hasMoreData) return;
    _isFetching = true;

    final receivePort = ReceivePort();
    await Isolate.spawn(
      _fetchUsedCarsInBackground,
      [receivePort.sendPort, (currentFetchedCount ~/ 10) + 1, 10],
    );

    final data = await receivePort.first;
    if (data is List<UsedCarEntity>) {
      _cachedUsedCars.addAll(data);
      _hasMoreData = data.isNotEmpty;
    }

    _isFetching = false;
  }
}
