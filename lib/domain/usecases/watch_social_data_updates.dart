import '../entities/local_entity.dart';
import '../repositories/local_repository.dart';

class WatchSocialDataUpdates {
  final ILocalRepository repository;

  WatchSocialDataUpdates(this.repository);

  Stream<LocalEntity> call() {
    return repository.watchSocialDataUpdates();
  }
}
