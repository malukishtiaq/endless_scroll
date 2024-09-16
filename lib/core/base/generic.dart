abstract class BaseParams {}

abstract class UseCase<Type> {
  Future<Type> call(int page, int limit);
}

abstract class BaseModel {}
