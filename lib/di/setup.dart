import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'setup.config.dart';
import 'package:http/http.dart' as http;

final GetIt getIt = GetIt.instance;

@injectableInit
void configureInjection(String environment) {
  getIt.registerSingleton<http.Client>(http.Client());
  getIt.init(environment: environment);
}
