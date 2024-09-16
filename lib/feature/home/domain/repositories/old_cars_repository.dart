import 'package:car_dealership/feature/home/domain/entities/used_car_entity.dart';
import 'package:injectable/injectable.dart';

import '../../data/repo/data_source.dart';

abstract class IUsedCarsRepo {
  Future<List<UsedCarEntity>> getUsedCarsData({int page = 1, int limit = 100});
}

@Injectable(as: IUsedCarsRepo)
class UsedCarsRepo extends IUsedCarsRepo {
  final DataSource dataSource;
  UsedCarsRepo(this.dataSource);

  @override
  Future<List<UsedCarEntity>> getUsedCarsData(
      {int page = 1, int limit = 100}) async {
    final resposne = await dataSource.getCars<UsedCarEntity>(
      'used-cars?page=$page&limit=$limit',
      (json) => UsedCarEntity.fromMap(json),
    );
    return resposne;
  }
}
