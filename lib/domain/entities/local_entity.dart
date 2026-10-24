import 'social_data.dart';

enum SocialStatus { pending, loading, merged, failed }

class LocalEntity {
  final String id;
  final String googlePlaceId;
  final String name;
  final String category;
  final double latitude;
  final double longitude;
  final double googleRating;
  final String baseAddress;
  final SocialStatus socialStatus;
  final SocialData? socialData;

  const LocalEntity({
    required this.id,
    required this.googlePlaceId,
    required this.name,
    required this.category,
    required this.latitude,
    required this.longitude,
    required this.googleRating,
    required this.baseAddress,
    required this.socialStatus,
    this.socialData,
  });

  /// Útil para la lógica de dominio o BLoC al fusionar datos asíncronos
  LocalEntity copyWith({
    String? id,
    String? googlePlaceId,
    String? name,
    String? category,
    double? latitude,
    double? longitude,
    double? googleRating,
    String? baseAddress,
    SocialStatus? socialStatus,
    SocialData? socialData,
  }) {
    return LocalEntity(
      id: id ?? this.id,
      googlePlaceId: googlePlaceId ?? this.googlePlaceId,
      name: name ?? this.name,
      category: category ?? this.category,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      googleRating: googleRating ?? this.googleRating,
      baseAddress: baseAddress ?? this.baseAddress,
      socialStatus: socialStatus ?? this.socialStatus,
      socialData: socialData ?? this.socialData,
    );
  }
}
