import '../../core/error/failures.dart';
import '../entities/local_entity.dart';

abstract class ILocalRepository {
  /// Obtiene los datos geográficos básicos de forma rápida para renderizar 
  /// inmediatamente el mapa (evita bloquear la UI esperando a Playwright).
  /// Utiliza Dart 3 Records para retornar Either un Failure o los datos.
  Future<(Failure?, List<LocalEntity>?)> getLocalsByBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required String category,
  });

  /// Abre un stream (ej. WebSocket / Server-Sent Events) para escuchar las
  /// actualizaciones enviadas por el backend cuando un worker asíncrono 
  /// (Playwright) finaliza el scraping social de un Local.
  Stream<LocalEntity> watchSocialDataUpdates();
}
