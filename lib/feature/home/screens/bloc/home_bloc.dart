import 'package:car_dealership/feature/home/domain/usecases/get_more_used_cars_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/used_car_entity.dart';
import '../../domain/usecases/get_new_cars.dart';
import '../../domain/usecases/get_used_cars.dart';
import 'home_state.dart';

@Injectable()
class HomeBloc extends Cubit<HomeState> {
  final GetUsedCarsUseCase getUsedCarsUseCase;
  final GetNewCarsUseCase getNewCarsUseCase;
  final GetMoreUsedCarsUseCase getMoreUsedCarsUseCase;

  HomeBloc({
    required this.getUsedCarsUseCase,
    required this.getNewCarsUseCase,
    required this.getMoreUsedCarsUseCase,
  }) : super(InitState());

  Future<void> loadBasicData() async {
    emit(Loading());
    try {
      final newCars = await getNewCarsUseCase.call(1, 10);

      emit(Data(
        usedCars: [],
        newCars: newCars,
        fetchedCount: 0,
      ));

      final usedCars = await getUsedCarsUseCase.call(1, 10);
      emit(Data(
        usedCars: usedCars,
        newCars: newCars,
        fetchedCount: usedCars.length,
      ));
      startBackgroundFetch(usedCars.length);
    } catch (e) {
      emit(Error());
    }
  }

  void startBackgroundFetch(int currentFetchedCount) {
    getMoreUsedCarsUseCase.startBackgroundFetch(currentFetchedCount).then((_) {
      final currentState = state as Data;
      final updatedUsedCars = List<UsedCarEntity>.from(currentState.usedCars)
        ..addAll(getMoreUsedCarsUseCase.cachedUsedCars);

      emit(Data(
        usedCars: updatedUsedCars,
        newCars: currentState.newCars,
        fetchedCount:
            currentFetchedCount + getMoreUsedCarsUseCase.cachedUsedCars.length,
      ));
    }).catchError((e) {
      emit(Error());
    });
  }
}
