// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:car_dealership/feature/home/data/repo/data_source.dart'
    as _i119;
import 'package:car_dealership/feature/home/data/repo/remote_data_source.dart'
    as _i604;
import 'package:car_dealership/feature/home/domain/repositories/new_cars_repository.dart'
    as _i31;
import 'package:car_dealership/feature/home/domain/repositories/old_cars_repository.dart'
    as _i828;
import 'package:car_dealership/feature/home/domain/usecases/get_more_used_cars_use_case.dart'
    as _i750;
import 'package:car_dealership/feature/home/domain/usecases/get_new_cars.dart'
    as _i852;
import 'package:car_dealership/feature/home/domain/usecases/get_used_cars.dart'
    as _i750;
import 'package:car_dealership/feature/home/screens/bloc/home_bloc.dart'
    as _i337;
import 'package:get_it/get_it.dart' as _i174;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i119.DataSource>(
      () => _i604.RemoteDataSource(gh<_i519.Client>()),
      registerFor: {_dev},
    );
    gh.factory<_i31.INewCarsRepo>(
        () => _i31.NewCarsRepo(gh<_i119.DataSource>()));
    gh.factory<_i828.IUsedCarsRepo>(
        () => _i828.UsedCarsRepo(gh<_i119.DataSource>()));
    gh.singleton<_i852.GetNewCarsUseCase>(
        () => _i852.GetNewCarsUseCase(gh<_i31.INewCarsRepo>()));
    gh.singleton<_i750.GetUsedCarsUseCase>(
        () => _i750.GetUsedCarsUseCase(gh<_i828.IUsedCarsRepo>()));
    gh.singleton<_i750.GetMoreUsedCarsUseCase>(
        () => _i750.GetMoreUsedCarsUseCase(gh<_i828.IUsedCarsRepo>()));
    gh.factory<_i337.HomeBloc>(() => _i337.HomeBloc(
          getUsedCarsUseCase: gh<_i750.GetUsedCarsUseCase>(),
          getNewCarsUseCase: gh<_i852.GetNewCarsUseCase>(),
          getMoreUsedCarsUseCase: gh<_i750.GetMoreUsedCarsUseCase>(),
        ));
    return this;
  }
}
