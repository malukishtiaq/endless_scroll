import 'package:injectable/injectable.dart';

import '../../../../core/base/generic.dart';
import '../entities/new_car_entity.dart';
import '../repositories/new_cars_repository.dart';

class Param extends BaseParams {}

@singleton
class GetNewCarsUseCase implements UseCase<List<NewCarEntity>> {
  final INewCarsRepo newCarsRepo;

  const GetNewCarsUseCase(this.newCarsRepo);

  @override
  Future<List<NewCarEntity>> call(int page, int limit) async {
    try {
      // Fetch new cars data from the repository
      final newCars = await newCarsRepo.getNewCarsData();
      return newCars;
    } catch (e) {
      throw Exception('Error fetching new cars: $e');
    }
  }
}
