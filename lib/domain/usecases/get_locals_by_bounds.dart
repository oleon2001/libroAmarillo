import '../../core/error/failures.dart';
import '../../core/usecases/usecase.dart';
import '../entities/local_entity.dart';
import '../repositories/local_repository.dart';

class GetLocalsByBounds implements UseCase<List<LocalEntity>, ParamsGetLocals> {
  final ILocalRepository repository;

  GetLocalsByBounds(this.repository);

  @override
  Future<(Failure?, List<LocalEntity>?)> call(ParamsGetLocals params) async {
    return await repository.getLocalsByBounds(
      minLat: params.minLat,
      maxLat: params.maxLat,
      minLng: params.minLng,
      maxLng: params.maxLng,
      category: params.category,
    );
  }
}

class ParamsGetLocals {
  final double minLat;
  final double maxLat;
  final double minLng;
  final double maxLng;
  final String category;

  ParamsGetLocals({
    required this.minLat,
    required this.maxLat,
    required this.minLng,
    required this.maxLng,
    required this.category,
  });
}
