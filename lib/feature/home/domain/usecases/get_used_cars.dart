import 'package:injectable/injectable.dart';
import '../../../../core/base/generic.dart';
import '../entities/used_car_entity.dart';
import '../repositories/old_cars_repository.dart';

@singleton
class GetUsedCarsUseCase implements UseCase<List<UsedCarEntity>> {
  final IUsedCarsRepo usedCarsRepo;

  const GetUsedCarsUseCase(this.usedCarsRepo);

  @override
  Future<List<UsedCarEntity>> call(int page, int limit) async {
    try {
      final usedCars =
          await usedCarsRepo.getUsedCarsData(page: page, limit: limit);
      return usedCars;
    } catch (e) {
      throw Exception('Error fetching used cars: $e');
    }
  }
}
