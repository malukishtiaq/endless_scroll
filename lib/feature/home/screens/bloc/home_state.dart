import '../../domain/entities/new_car_entity.dart';
import '../../domain/entities/used_car_entity.dart';

sealed class HomeState {}

final class InitState extends HomeState {}

final class Loading extends HomeState {}

final class Error extends HomeState {}

final class Data extends HomeState {
  final List<UsedCarEntity> usedCars;
  final List<NewCarEntity> newCars;
  final int fetchedCount;

  Data(
      {required this.usedCars,
      required this.newCars,
      required this.fetchedCount});
}

class MoreDataLoaded extends HomeState {
  final List<UsedCarEntity> usedCars;
  final int fetchedCount;

  MoreDataLoaded({required this.usedCars, required this.fetchedCount});
}
