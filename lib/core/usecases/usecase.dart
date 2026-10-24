import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<(Failure?, Type?)> call(Params params);
}

class NoParams {
  const NoParams();
}
