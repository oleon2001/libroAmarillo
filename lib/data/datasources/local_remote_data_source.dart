import '../models/local_model.dart';

abstract class LocalRemoteDataSource {
  /// Llama al endpoint /api/v1/locals?category=...&bounds=...
  /// 
  /// Lanza [ServerException] para todos los códigos de error.
  Future<List<LocalModel>> getLocalsByBounds({
    required double minLat,
    required double maxLat,
    required double minLng,
    required double maxLng,
    required String category,
  });

  /// Abre un stream WebSocket o SSE hacia /api/v1/locals/stream
  Stream<LocalModel> watchSocialDataUpdates();
}
