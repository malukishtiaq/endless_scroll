import 'package:car_dealership/feature/home/data/repo/data_source.dart';
import 'package:car_dealership/feature/home/domain/entities/new_car_entity.dart';
import 'package:injectable/injectable.dart';

abstract class INewCarsRepo {
  Future<List<NewCarEntity>> getNewCarsData({int page = 1, int limit = 100});
}

@Injectable(as: INewCarsRepo)
class NewCarsRepo extends INewCarsRepo {
  final DataSource dataSource;
  NewCarsRepo(this.dataSource);

  @override
  Future<List<NewCarEntity>> getNewCarsData(
      {int page = 1, int limit = 100}) async {
    final resposne = await dataSource.getCars(
      'new-cars?page=1&limit=100',
      (json) => NewCarEntity.fromMap(json),
    );
    return resposne;
  }
}
