import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/local_entity.dart';
import '../../domain/repositories/local_repository.dart';
import '../datasources/local_remote_data_source.dart';

class LocalRepositoryImpl implements ILocalRepository {
  final LocalRemoteDataSource remoteDataSource;

  LocalRepositoryImpl({required this.remoteDataSource});

  @override
  Future<(Failure?, List<LocalEntity>?)> getLocalsByBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required String category,
  }) async {
    try {
      final remoteLocals = await remoteDataSource.getLocalsByBounds(
        minLat: minLat,
        maxLat: maxLat,
        minLng: minLng,
        maxLng: maxLng,
        category: category,
      );
      return (null, remoteLocals);
    } on ServerException catch (e) {
      return (ServerFailure(e.message), null);
    } catch (e) {
      return (const ServerFailure('Unexpected error occurred'), null);
    }
  }

  @override
  Stream<LocalEntity> watchSocialDataUpdates() {
    // El stream de modelos mapea directamente a entidades gracias a la herencia
    return remoteDataSource.watchSocialDataUpdates();
  }
}
